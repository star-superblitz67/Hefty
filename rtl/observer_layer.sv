module observer_layer (
    input  logic        clk, 
    input  logic        reset_n,
    input  logic        match_found,
    output logic [63:0] m_timestamp
);

    logic [63:0] free_counter;

    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            free_counter <= 64'd0;
            m_timestamp  <= 64'd0;
        end else begin
            free_counter <= free_counter + 64'd1;
            
            if (match_found) begin
                m_timestamp <= free_counter;
            end
        end
    end

endmodule
