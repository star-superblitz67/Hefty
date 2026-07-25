module config_controller (
    input  logic        clk, 
    input  logic        reset_n,

    // Software sends 32-bit writes to update the ticker table
    input  logic        s_cfg_wr_en,
    // Address bits: [8:7] = which bank, [6:1] = table slot, [0] = lower or upper half
    input  logic [8:0]  s_cfg_addr,
    input  logic        s_cfg_rd_en,
    input  logic [31:0] s_cfg_data,
    output logic [31:0] s_cfg_rd_data,   
    // Once both halves arrive, we fire a single 48-bit write to the ticker table
    output logic        dram_wr_en,
    output logic [5:0]  dram_wr_addr,
    output logic [1:0]  dram_wr_bank,
    output logic [47:0] dram_wr_data
);

    logic [31:0] lower_word_reg;
    logic [7:0]  lower_word_addr_reg;                                     
    logic        write_dropped_err;

    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            lower_word_reg      <= 32'h0;                                                           
            lower_word_addr_reg <= 8'h0;                                                            
            write_dropped_err   <= 1'b0;                                                            
            dram_wr_en          <= 1'b0;                                                            
            dram_wr_addr        <= 6'h0;                                                            
            dram_wr_bank        <= 2'h0;                                                            
            dram_wr_data        <= 48'h0;                                                           
            s_cfg_rd_data       <= 32'h0;
        end else begin
            // Reset the write enable every cycle so it only pulses for 1 clock
            dram_wr_en <= 1'b0;

            // Handle reads — return the error status flag
            if (s_cfg_rd_en) begin
                s_cfg_rd_data <= {31'h0, write_dropped_err};
                write_dropped_err <= 1'b0;
            end

            // Handle writes — collect two 32-bit halves and combine into one 48-bit ticker write
            if (s_cfg_wr_en) begin
                if (s_cfg_addr[0] == 1'b0) begin
                    lower_word_reg <= s_cfg_data;
                    lower_word_addr_reg <= s_cfg_addr[8:1];
                end else begin
                    if (s_cfg_addr[8:1] == lower_word_addr_reg) begin
                        dram_wr_data <= {s_cfg_data[15:0], lower_word_reg};                         
                        dram_wr_addr <= s_cfg_addr[6:1];                                            
                        dram_wr_bank <= s_cfg_addr[8:7];                                            
                        dram_wr_en   <= 1'b1; 
                    end else begin
                        write_dropped_err <= 1'b1;
                    end
                end
            end
        end
    end

endmodule
