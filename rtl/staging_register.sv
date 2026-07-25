module staging_register (
    input  logic         clk,
    input  logic         reset_n,
    input  logic         latch_en,
    input  logic         clear,
    input  logic [127:0] s_axis_tdata,
    output logic [47:0]  staging_reg
);
    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            staging_reg <= 48'b0;
        end
        // Clear the register if the watchdog times out
        else if (clear) begin
            staging_reg <= 48'b0;
        end
        else if (latch_en) begin
            staging_reg <= s_axis_tdata[47:0];
        end 
    end
endmodule
