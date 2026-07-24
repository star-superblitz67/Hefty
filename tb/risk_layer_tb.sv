module risk_layer_tb;
    logic        clk;
    logic        reset_n;
    logic        match_found;
    logic [5:0]  hash_idx;
    logic [15:0] seq_num_in;
    logic [47:0] ticker_in;
    logic        bank0_hit;
    logic        bank1_hit;
    logic        bank2_hit;
    logic        bank3_hit;
    
    logic        anomaly_detected;
    logic [47:0] anomaly_ticker;
    logic [15:0] expected_seq;
    logic [15:0] received_seq;

    risk_layer dut (.*);

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        reset_n = 0;
        match_found = 0;
        hash_idx = 0;
        seq_num_in = 0;
        ticker_in = 0;
        bank0_hit = 0;
        bank1_hit = 0;
        bank2_hit = 0;
        bank3_hit = 0;

        #20 reset_n = 1;

        // -----------------------------------------------------------------
        // 1. Fresh ticker (last_seq==0) -> no anomaly
        // -----------------------------------------------------------------
        @(negedge clk);
        match_found = 1; hash_idx = 28; bank0_hit = 1; bank1_hit = 0; bank2_hit = 0; bank3_hit = 0;
        ticker_in = 48'h4141_504C_2020; seq_num_in = 16'd100;
        
        @(negedge clk);
        #1;
        $display("DEBUG Trace 1: anomaly_detected = %b, expected_seq = %d, received_seq = %d", anomaly_detected, expected_seq, received_seq);
        if (anomaly_detected === 1'b0) $display("Trace 1 PASS: Fresh ticker"); 
        else $error("Trace 1 FAIL: Fresh ticker");

        // -----------------------------------------------------------------
        // 2. Consecutive (seq_num_in == last_seq+1) -> no anomaly
        // -----------------------------------------------------------------
        match_found = 1; hash_idx = 28; bank0_hit = 1; 
        ticker_in = 48'h4141_504C_2020; seq_num_in = 16'd101;
        
        @(negedge clk);
        #1;
        $display("DEBUG Trace 2: anomaly_detected = %b, expected_seq = %d, received_seq = %d", anomaly_detected, expected_seq, received_seq);
        if (anomaly_detected === 1'b0) $display("Trace 2 PASS: Consecutive packet"); 
        else $error("Trace 2 FAIL: Consecutive packet");

        // -----------------------------------------------------------------
        // 3. Jump-ahead anomaly
        // -----------------------------------------------------------------
        match_found = 1; hash_idx = 28; bank0_hit = 1; 
        ticker_in = 48'h4141_504C_2020; seq_num_in = 16'd105;
        
        @(negedge clk);
        #1;
        $display("DEBUG Trace 3: anomaly_detected = %b, expected_seq = %d, received_seq = %d", anomaly_detected, expected_seq, received_seq);
        if (anomaly_detected === 1'b1 && expected_seq == 16'd102 && received_seq == 16'd105) 
            $display("Trace 3 PASS: Jump-ahead anomaly correctly detected"); 
        else $error("Trace 3 FAIL: Jump-ahead anomaly failed");

        // -----------------------------------------------------------------
        // 4. 1-cycle pulse behavior on non-match cycles
        // -----------------------------------------------------------------
        match_found = 0; // Simulate idle cycle
        @(negedge clk);
        #1;
        $display("DEBUG Trace 4: anomaly_detected = %b, expected_seq = %d, received_seq = %d", anomaly_detected, expected_seq, received_seq);
        if (anomaly_detected === 1'b0) 
            $display("Trace 4 PASS: 1-cycle pulse cleared anomaly_detected correctly"); 
        else $error("Trace 4 FAIL: anomaly_detected stuck high on idle cycle");

        // -----------------------------------------------------------------
        // 5. Replay/duplicate anomaly
        // -----------------------------------------------------------------
        match_found = 1; hash_idx = 28; bank0_hit = 1; 
        ticker_in = 48'h4141_504C_2020; seq_num_in = 16'd105; // Replay of 105
        
        @(negedge clk);
        #1;
        $display("DEBUG Trace 5: anomaly_detected = %b, expected_seq = %d, received_seq = %d", anomaly_detected, expected_seq, received_seq);
        if (anomaly_detected === 1'b1 && expected_seq == 16'd106 && received_seq == 16'd105) 
            $display("Trace 5 PASS: Replay/duplicate correctly detected"); 
        else $error("Trace 5 FAIL: Replay/duplicate failed");

        // -----------------------------------------------------------------
        // 6. Bank collision isolation (MSFT vs HD on hash 12)
        // -----------------------------------------------------------------
        // Set MSFT in Bank 0
        match_found = 1; hash_idx = 12; bank0_hit = 1; bank2_hit = 0;
        ticker_in = 48'h4D53_4654_2020; seq_num_in = 16'd500;
        @(negedge clk);
        
        // Set HD in Bank 2 (same hash!)
        match_found = 1; hash_idx = 12; bank0_hit = 0; bank2_hit = 1;
        ticker_in = 48'h4844_2020_2020; seq_num_in = 16'd900;
        @(negedge clk);

        // Advance MSFT (should expect 501, NOT 901)
        match_found = 1; hash_idx = 12; bank0_hit = 1; bank2_hit = 0;
        ticker_in = 48'h4D53_4654_2020; seq_num_in = 16'd501;
        
        @(negedge clk);
        #1;
        $display("DEBUG Trace 6: anomaly_detected = %b, expected_seq = %d, received_seq = %d", anomaly_detected, expected_seq, received_seq);
        if (anomaly_detected === 1'b0) 
            $display("Trace 6 PASS: Bank collision isolated successfully (MSFT didn't stomp HD)"); 
        else $error("Trace 6 FAIL: Sequence arrays crossed streams on hash collision");

        // -----------------------------------------------------------------
        // 7. Wraparound
        // -----------------------------------------------------------------
        // First force the sequence up to FFFF
        match_found = 1; hash_idx = 28; bank0_hit = 1; bank2_hit = 0;
        ticker_in = 48'h4141_504C_2020; seq_num_in = 16'hFFFF;
        @(negedge clk);
        
        // Now wrap it around to 0
        match_found = 1; hash_idx = 28; bank0_hit = 1; 
        ticker_in = 48'h4141_504C_2020; seq_num_in = 16'h0000;
        
        @(negedge clk);
        #1;
        $display("DEBUG Trace 7: anomaly_detected = %b, expected_seq = %d, received_seq = %d", anomaly_detected, expected_seq, received_seq);
        if (anomaly_detected === 1'b0) 
            $display("Trace 7 PASS: Wraparound correctly ignored as valid"); 
        else $error("Trace 7 FAIL: Wraparound flagged as anomaly");

        #100 $finish;
    end
endmodule
