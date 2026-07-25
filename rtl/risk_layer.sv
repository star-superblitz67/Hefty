module risk_layer (
    input  logic        clk, 
    input  logic        reset_n,
    
    input  logic        match_found,
    input  logic [5:0]  hash_idx,
    input  logic [15:0] seq_num_in,
    input  logic [47:0] ticker_in,
    
    input  logic        bank0_hit,
    input  logic        bank1_hit,
    input  logic        bank2_hit,
    input  logic        bank3_hit,
    
    
    output logic        anomaly_detected,
    output logic [47:0] anomaly_ticker,
    output logic [15:0] expected_seq,
    output logic [15:0] received_seq
);

    // 4 tables of 64 entries each — stores the last sequence number we saw for every ticker
    logic [15:0] seq_table_b0 [0:63];
    logic [15:0] seq_table_b1 [0:63];
    logic [15:0] seq_table_b2 [0:63];
    logic [15:0] seq_table_b3 [0:63];

    initial begin
        for (int i = 0; i < 64; i++) begin
            seq_table_b0[i] = 16'h0000;
            seq_table_b1[i] = 16'h0000;
            seq_table_b2[i] = 16'h0000;
            seq_table_b3[i] = 16'h0000;
        end
    end



    // 4-stage pipeline to detect sequence anomalies:
    //   Stage 1: Latch all the inputs
    //   Stage 2: Read the last sequence number from memory, write the new one
    //   Stage 3: Do the math — is this the sequence number we expected?
    //   Stage 4: Output the result (anomaly or not)
    //
    // This adds 3 cycles to anomaly detection, but does NOT slow down
    // the main packet forwarding path at all.
    

    // Stage 1 Registers
    logic [5:0]  hash_idx_reg;
    logic        match_found_reg;
    logic [15:0] seq_num_in_reg;
    logic [47:0] ticker_in_reg;
    logic        bank0_hit_reg;
    logic        bank1_hit_reg;
    logic        bank2_hit_reg;
    logic        bank3_hit_reg;

    // Stage 2 Registers (aligned with RAM read data)
    logic        match_found_reg2;
    logic [15:0] seq_num_in_reg2;
    logic [47:0] ticker_in_reg2;
    logic [15:0] last_seq_reg;

    always_ff @(posedge clk) begin
        // Stage 1: grab everything
        hash_idx_reg    <= hash_idx;
        match_found_reg <= match_found;
        seq_num_in_reg  <= seq_num_in;
        ticker_in_reg   <= ticker_in;
        bank0_hit_reg   <= bank0_hit;
        bank1_hit_reg   <= bank1_hit;
        bank2_hit_reg   <= bank2_hit;
        bank3_hit_reg   <= bank3_hit;

        // Stage 2: wait for memory to come back
        match_found_reg2 <= match_found_reg;
        seq_num_in_reg2  <= seq_num_in_reg;
        ticker_in_reg2   <= ticker_in_reg;

        // Stage 2: read the last sequence number from whichever bank matched
        if      (bank0_hit_reg) last_seq_reg <= seq_table_b0[hash_idx_reg];
        else if (bank1_hit_reg) last_seq_reg <= seq_table_b1[hash_idx_reg];
        else if (bank2_hit_reg) last_seq_reg <= seq_table_b2[hash_idx_reg];
        else if (bank3_hit_reg) last_seq_reg <= seq_table_b3[hash_idx_reg];
        else                    last_seq_reg <= 16'h0000;
    end


    // Stage 3: did we get the sequence number we expected?
    
    logic        match_found_reg3;
    logic [15:0] seq_num_in_reg3;
    logic [47:0] ticker_in_reg3;
    logic [15:0] expected_seq_calc;
    logic        is_anomaly;

    always_ff @(posedge clk) begin
        match_found_reg3 <= match_found_reg2;
        seq_num_in_reg3  <= seq_num_in_reg2;
        ticker_in_reg3   <= ticker_in_reg2;
        
        expected_seq_calc <= last_seq_reg + 1;

        if (seq_num_in_reg2 == last_seq_reg + 1)
            is_anomaly <= 1'b0;
        else if (last_seq_reg == 16'h0000)
            is_anomaly <= 1'b0;
        else if (last_seq_reg == 16'hFFFF && seq_num_in_reg2 == 16'h0000)
            is_anomaly <= 1'b0;
        else
            is_anomaly <= 1'b1; // Gap or Regression
    end


    // Stage 4: output the final verdict
    
    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            anomaly_detected <= 1'b0;
            anomaly_ticker   <= 48'h0;
            expected_seq     <= 16'h0;
            received_seq     <= 16'h0;
        end
        else if (match_found_reg3) begin
            // Debug print so we can see every match in the sim log
            $display("[RISK @%0t] match3 is_anomaly=%b expected=%0d seq_in3=%0d ticker3=%h",
                     $time, is_anomaly, expected_seq_calc, seq_num_in_reg3, ticker_in_reg3);

            anomaly_detected <= is_anomaly;
            
            if (is_anomaly) begin
                anomaly_ticker   <= ticker_in_reg3;
                expected_seq     <= expected_seq_calc;
                received_seq     <= seq_num_in_reg3;
            end
        end
        else begin
            anomaly_detected <= 1'b0;
        end
    end


    // Update the sequence table with the new number
    // from using fast LUT-RAM, and the initial block already zeroes everything
    
    always_ff @(posedge clk) begin
        if (match_found_reg) begin
            if      (bank0_hit_reg) seq_table_b0[hash_idx_reg] <= seq_num_in_reg;
            else if (bank1_hit_reg) seq_table_b1[hash_idx_reg] <= seq_num_in_reg;
            else if (bank2_hit_reg) seq_table_b2[hash_idx_reg] <= seq_num_in_reg;
            else if (bank3_hit_reg) seq_table_b3[hash_idx_reg] <= seq_num_in_reg;
        end
    end


endmodule
