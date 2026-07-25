module config_controller (
    input  logic        clk, 
    input  logic        reset_n,

    // Incoming 32-bit Config Interface
    input  logic        s_cfg_wr_en,
    // [8:7] = Bank select (0-3)
    // [6:1] = Hash index (0-63)
    // [0]   = Word select (0 = Lower 32 bits, 1 = Upper 16 bits)
    input  logic [8:0]  s_cfg_addr,
    input  logic        s_cfg_rd_en,
    input  logic [31:0] s_cfg_data,
    output logic [31:0] s_cfg_rd_data,   
    // Outgoing Atomic 48-bit Interface
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
            // Default to 0 to ensure 1-cycle pulse
            dram_wr_en <= 1'b0;

            // 1. Read Block (Executes first in sequential order)
            if (s_cfg_rd_en) begin
                s_cfg_rd_data <= {31'h0, write_dropped_err};
                write_dropped_err <= 1'b0;
            end

            // 2. Write Block (Executes second, so its assignments overwrite the read's clear)
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
