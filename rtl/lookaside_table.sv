module lookaside_table (
    input  logic        clk,
    input  logic        reset_n,
    input  logic        rd_en,
    input  logic [47:0] ticker_in,
    output logic        match_found,
    output logic [5:0]  hash_idx_out, // Exposed for risk_layer
    // Config port
    input  logic        cfg_wr_en,
    input  logic [5:0]  cfg_addr,
    input  logic [1:0]  cfg_bank_sel,
    input  logic [47:0] cfg_data,
    
    // Per-bank hit signals for risk_layer
    output logic        bank0_hit,
    output logic        bank1_hit,
    output logic        bank2_hit,
    output logic        bank3_hit
);
    // 64-entry x 49-bit arrays, 4-way associative.
    // Distributed LUT-RAM (RAM64X1S) is used instead of Block RAM because:
    //   1. At 64 entries x 49 bits each bank is only 3136 bits — too small
    //      to justify BRAM overhead.
    //   2. BRAM has a fixed 1.8 ns CLK-to-DOADO propagation delay which
    //      dominates the critical path at 250 MHz. Distributed RAM captures
    //      into a standard FDRE (~0.4 ns CLK-to-Q), saving ~1.4 ns with
    //      zero change to pipeline latency.
    (* ram_style = "distributed" *) logic [48:0] bank0 [0:63];
    (* ram_style = "distributed" *) logic [48:0] bank1 [0:63];
    (* ram_style = "distributed" *) logic [48:0] bank2 [0:63];
    (* ram_style = "distributed" *) logic [48:0] bank3 [0:63];

    initial begin
        $readmemh("mem/bank0.hex", bank0);
        $readmemh("mem/bank1.hex", bank1);
        $readmemh("mem/bank2.hex", bank2);
        $readmemh("mem/bank3.hex", bank3);
    end

    // =========================================================================
    // 1. Combinational Hash (Cycle 4)
    // =========================================================================
    logic [7:0] xor_byte;
    logic [5:0] hash_idx;

    assign xor_byte = ticker_in[47:40] ^ ticker_in[39:32] ^ 
                      ticker_in[31:24] ^ ticker_in[23:16] ^ 
                      ticker_in[15:8]  ^ ticker_in[7:0];

    assign hash_idx = xor_byte[5:0];
    assign hash_idx_out = hash_idx;

    // =========================================================================
    // 2. Synchronous BRAM Read (Cycle 4 -> Cycle 5)
    // =========================================================================
    logic [48:0] bank0_out;
    logic [48:0] bank1_out;
    logic [48:0] bank2_out;
    logic [48:0] bank3_out;

    always_ff @(posedge clk) begin
        if (rd_en) begin
            bank0_out <= bank0[hash_idx];
            bank1_out <= bank1[hash_idx];
            bank2_out <= bank2[hash_idx];
            bank3_out <= bank3[hash_idx];
        end
    end

    always_ff @(posedge clk) begin
        if(cfg_wr_en) begin 
            case(cfg_bank_sel)
                2'd0: bank0[cfg_addr] <= {1'b1, cfg_data};
                2'd1: bank1[cfg_addr] <= {1'b1, cfg_data};
                2'd2: bank2[cfg_addr] <= {1'b1, cfg_data};
                2'd3: bank3[cfg_addr] <= {1'b1, cfg_data};
            endcase
        end 
    end

    // =========================================================================
    // 3. Pipelined Comparison (Cycle 5)
    // =========================================================================
    logic [47:0] ticker_in_delayed;

    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            ticker_in_delayed <= 48'b0;
        end else if (rd_en) begin
            ticker_in_delayed <= ticker_in;
        end
    end

    // 4-way OR comparison (incorporating the 49th bit as the VALID flag)
    // TEMP: remove != 0 guard after valid-bit verified, see hole re: null-byte packets
    assign bank0_hit = (bank0_out[48] & (bank0_out[47:0] == ticker_in_delayed));
    assign bank1_hit = (bank1_out[48] & (bank1_out[47:0] == ticker_in_delayed));
    assign bank2_hit = (bank2_out[48] & (bank2_out[47:0] == ticker_in_delayed));
    assign bank3_hit = (bank3_out[48] & (bank3_out[47:0] == ticker_in_delayed));

    assign match_found = (ticker_in_delayed != 48'h0) & (
                           bank0_hit | bank1_hit | bank2_hit | bank3_hit
                         );

endmodule
