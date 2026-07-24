module parser_core (
    input  logic         clk,
    input  logic         reset_n,

    input  logic [127:0] s_axis_tdata,
    input  logic         s_axis_tvalid,
    input  logic         s_axis_tlast,

    output logic [127:0] m_payload_data,
    output logic         m_payload_valid,

    // BRAM write interface (from config_controller)
    input  logic         bram_wr_en,
    input  logic [5:0]   bram_wr_addr,
    input  logic [1:0]   bram_wr_bank,
    input  logic [47:0]  bram_wr_data,

    // Tap signals out to risk_layer and observer_layer
    output logic         match_found_pulse,
    output logic [5:0]   hash_idx_out,
    output logic [15:0]  seq_num_out,
    output logic [47:0]  ticker_out,
    output logic         bank0_hit_out,
    output logic         bank1_hit_out,
    output logic         bank2_hit_out,
    output logic         bank3_hit_out,
    output logic [2:0]   fsm_state_dbg
);

    logic         timeout;
    logic         match_found;
    logic         latch_en;
    logic         bram_rd_en;
    logic [47:0]  staging_reg;
    logic         fsm_active;
    logic         pipe_valid_5;

    ingress_fsm u_ingress_fsm (
        .clk             (clk),
        .reset_n         (reset_n),
        .s_axis_tdata    (s_axis_tdata),
        .s_axis_tvalid   (s_axis_tvalid),
        .s_axis_tlast    (s_axis_tlast),
        .timeout         (timeout),
        .match_found     (match_found),
        .latch_en        (latch_en),
        .bram_rd_en      (bram_rd_en),
        .m_payload_data  (m_payload_data),
        .m_payload_valid (m_payload_valid),
        .fsm_state_dbg   (fsm_state_dbg),
        .pipe_valid_5    (pipe_valid_5)
    );

    staging_register u_staging_reg (
        .clk             (clk),
        .reset_n         (reset_n),
        .latch_en        (latch_en),
        .clear           (timeout), // timeout directly clears staging_reg
        .s_axis_tdata    (s_axis_tdata),
        .staging_reg     (staging_reg)
    );

    // Latch Sequence Number during Cycle 4 (when bram_rd_en is high)
    // The sequence number is at bytes 56-57, which is tdata[63:48] in Beat 4.
    logic [15:0] seq_num_reg;
    always_ff @(posedge clk) begin
        if (bram_rd_en) begin
            seq_num_reg <= s_axis_tdata[63:48];
        end
    end

    watchdog_timer #(
        .THRESHOLD(8'd32)
    ) u_watchdog (
        .clk             (clk),
        .reset_n         (reset_n),
        .fsm_active      (fsm_active),
        .timeout         (timeout)
    );

    // fsm_active monitors if a packet is currently on the wire OR in the pipeline
    assign fsm_active  = (fsm_state_dbg != 3'b000) || pipe_valid_5;

    // Pass signals out
    logic [5:0]   bram_hash_idx;
    logic         bank0_hit;
    logic         bank1_hit;
    logic         bank2_hit;
    logic         bank3_hit;

    lookaside_table u_lookaside_table (
        .clk          (clk),
        .reset_n      (reset_n),
        .rd_en        (bram_rd_en),
        .ticker_in    (staging_reg),
        .match_found  (match_found),
        .hash_idx_out (bram_hash_idx),
        .cfg_wr_en    (bram_wr_en),
        .cfg_addr     (bram_wr_addr),
        .cfg_bank_sel (bram_wr_bank),
        .cfg_data     (bram_wr_data),
        .bank0_hit    (bank0_hit),
        .bank1_hit    (bank1_hit),
        .bank2_hit    (bank2_hit),
        .bank3_hit    (bank3_hit)
    );

    // match_found stays high for the whole packet because staging_reg is constant.
    // We must gate it to EXACTLY one cycle (Cycle 5) so the risk layer evaluates once.
    logic risk_layer_en;
    assign risk_layer_en = match_found && pipe_valid_5;

    // Pass signals out
    assign hash_idx_out = bram_hash_idx;
    assign ticker_out   = staging_reg;
    assign seq_num_out  = seq_num_reg;
    assign match_found_pulse = risk_layer_en;
    assign bank0_hit_out = bank0_hit;
    assign bank1_hit_out = bank1_hit;
    assign bank2_hit_out = bank2_hit;
    assign bank3_hit_out = bank3_hit;

endmodule
