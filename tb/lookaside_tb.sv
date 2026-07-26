module lookaside_tb;
    logic        clk;
    logic        reset_n;
    logic        rd_en;
    logic [47:0] ticker_in;
    logic        match_found;
    logic [5:0]  hash_idx_out;
    
    // Config port tied off for now since we rely on $readmemh
    logic        cfg_wr_en = 0;
    logic [5:0]  cfg_addr = 0;
    logic [1:0]  cfg_bank_sel = 0;
    logic [47:0] cfg_data = 0;

    lookaside_table dut (
        .clk(clk),
        .reset_n(reset_n),
        .rd_en(rd_en),
        .ticker_in(ticker_in),
        .match_found(match_found),
        .hash_idx_out(hash_idx_out),
        .cfg_wr_en(cfg_wr_en),
        .cfg_addr(cfg_addr),
        .cfg_bank_sel(cfg_bank_sel),
        .cfg_data(cfg_data)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset_n = 0;
        rd_en = 0;
        ticker_in = 0;
        
        #20 reset_n = 1;
        
        
        // Trace 1 - AAPL 
        
        @(posedge clk);
        ticker_in = 48'h4141_504C_2020;
        rd_en = 1;
        
        @(posedge clk);
        #1; 
        if (match_found === 1'b1) $display("Trace 1 PASS: AAPL Matched!");
        else $error("Trace 1 FAIL: AAPL Missed!");

        
        // Trace 2 - NVDA/META collision
        
        @(posedge clk);
        ticker_in = 48'h4D45_5441_2020; // Driving META
        rd_en = 1;

        @(posedge clk);
        #1;
        if (match_found === 1'b1) $display("Trace 2 PASS: META Collision Matched via 4-way OR!");
        else $error("Trace 2 FAIL: META Missed!");

        
        // Trace 3 - ZZZZZ! (Empty Bucket)
        
        @(posedge clk);
        ticker_in = 48'h5A5A_5A5A_5A21;
        rd_en = 1;
        
        @(posedge clk);
        #1;
        if (match_found === 1'b0) $display("Trace 3 PASS: ZZZZZ! Correctly Missed!");
        else $error("Trace 3 FAIL: False Positive!");

        
        // Trace 4 - All-Zero Ticker
        
        @(posedge clk);
        ticker_in = 48'h0000_0000_0000;
        rd_en = 1;
        
        @(posedge clk);
        #1;
        if (match_found === 1'b0) $display("Trace 4 PASS: Null-byte Guard Blocked False Positive!");
        else $error("Trace 4 FAIL: Null-byte vulnerability triggered!");

        
        // Trace 5 - EXAP (Bank 3 Deep Hit)
        
        @(posedge clk);
        ticker_in = 48'h4558_4150_2020;
        rd_en = 1;
        
        @(posedge clk);
        #1;
        if (match_found === 1'b1) $display("Trace 5 PASS: EXAP Matched via Bank 3 OR-leg!");
        else $error("Trace 5 FAIL: Bank 3 wiring broken!");

        
        // Trace 6 - HD (Bank 2 Hit)
        
        @(posedge clk);
        ticker_in = 48'h4844_2020_2020;
        rd_en = 1;
        
        @(posedge clk);
        #1;
        if (match_found === 1'b1) $display("Trace 6 PASS: HD Matched via Bank 2 OR-leg!");
        else $error("Trace 6 FAIL: Bank 2 wiring broken!");

        #100 $finish;
    end
endmodule
