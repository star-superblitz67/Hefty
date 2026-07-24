module watchdog_timer #(
    parameter THRESHOLD = 8'd32
)(
    input  logic clk,
    input  logic reset_n,
    input  logic fsm_active,       // HIGH when FSM != ST_IDLE
    output logic timeout
);
    // Internal 8-bit counter
    logic [7:0] timeout_cnt;

    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            timeout_cnt <= 8'd0;
            timeout     <= 1'b0;
        end 
        else if (!fsm_active) begin
            timeout_cnt <= 8'd0;
            timeout     <= 1'b0;
        end 
        else begin
            if (timeout_cnt >= THRESHOLD) begin
                timeout <= 1'b1;
            end 
            else begin
                timeout_cnt <= timeout_cnt + 8'd1;
                timeout     <= 1'b0;
            end
        end
    end
endmodule
