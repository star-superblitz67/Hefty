module tb_top;
    logic         clk;
    logic         reset_n;

    logic [127:0] s_axis_tdata;
    logic         s_axis_tvalid;
    logic         s_axis_tlast;

    logic [127:0] m_payload_data;
    logic         m_payload_valid;

    logic         s_cfg_wr_en;
    logic         s_cfg_rd_en;
    logic [8:0]   s_cfg_addr;
    logic [31:0]  s_cfg_data;
    logic [31:0]  s_cfg_rd_data;
    logic [63:0]  m_timestamp;
    logic [47:0]  anomaly_ticker;
    logic         anomaly_detected;
    logic [15:0]  expected_seq;
    logic [15:0]  received_seq;
    logic [2:0]   fsm_state_dbg;

    
    // Error tracking infrastructure
    
    int error_count    = 0; // global total across all scenarios
    int scenario_errors = 0; // per-scenario, reset before each scenario

    // always @(fsm_state_dbg or m_payload_valid) $display("[%0t] fsm_state_dbg=%b, payload_valid=%b", $time, fsm_state_dbg, m_payload_valid);

    top_level dut (.*);

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    logic [63:0] tb_cycle_count = 0;
    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n) tb_cycle_count <= 0;
        else tb_cycle_count <= tb_cycle_count + 1;
    end

    // Anomaly signals are connected implicitly via .* and declared above

    // Catch anomaly pulse since it's only 1 cycle long
    logic caught_anomaly = 0;
    logic [15:0] caught_exp = 0;
    logic [15:0] caught_rec = 0;
    logic clear_anomaly = 0;
    
    always_ff @(posedge clk) begin
        if (clear_anomaly) begin
            caught_anomaly <= 0;
        end else if (anomaly_detected) begin
            caught_anomaly <= 1;
            caught_exp <= expected_seq;
            caught_rec <= received_seq;
        end
    end

    // Global capture for timestamp latency (Scenario 16)
    logic [63:0] last_packet_start_time = 0;

    
    // fail() — the only way to record a test failure.
    // Increments both the global error_count and the current
    // scenario's scenario_errors. Print $error so xsim/Verilator
    // log it with file+line. Every "Passed" banner is gated on
    // scenario_errors == 0, so no unconditional banners exist.
    
    task automatic fail(input string msg);
        $error("%s", msg);
        error_count++;
        scenario_errors++;
    endtask

    // Helper Task to send a standard 6-beat valid packet
    task send_packet(input logic [47:0] ticker, input logic [15:0] seq_num);
        @(negedge clk);
        last_packet_start_time = tb_cycle_count;
        s_axis_tvalid = 1;
        s_axis_tlast  = 0;
        s_axis_tdata  = {96'b0, 16'h0800, 16'b0}; // Beat 1: EtherType
        
        @(negedge clk);
        s_axis_tdata  = {56'b0, 8'h11, 64'b0};    // Beat 2: UDP Protocol
        
        @(negedge clk);
        s_axis_tdata  = {80'b0, ticker};           // Beat 3: Ticker
        
        @(negedge clk);
        s_axis_tdata  = {64'b0, seq_num, 48'b0};   // Beat 4: Sequence
        
        @(negedge clk);
        s_axis_tdata  = {128'hFFFFFFFF};           // Beat 5
        
        @(negedge clk);
        s_axis_tlast  = 1;                         // Beat 6: End of packet
        
        @(negedge clk);
        s_axis_tvalid = 0;
        s_axis_tlast  = 0;
        s_axis_tdata  = 0;
    endtask

    initial begin
        reset_n = 0;
        s_axis_tvalid = 0;
        s_axis_tlast = 0;
        s_axis_tdata = 0;
        s_cfg_wr_en = 0;
        s_cfg_rd_en = 0;
        s_cfg_addr = 0;
        s_cfg_data = 0;

        #20 reset_n = 1;

        
        // Step 1: Configure Lookaside Table via AXI-Lite
        
        @(negedge clk);
        // Write 1: AAPL to Bank 0 (hash 28)
        s_cfg_wr_en = 1;
        s_cfg_addr = 9'b00_011100_0;
        s_cfg_data = 32'h504C_2020; // "PL  "
        @(negedge clk);
        s_cfg_addr = 9'b00_011100_1;
        s_cfg_data = 32'h0000_4141; // "AA"
        
        // Write 2: GOOG to Bank 1 (real hash = 0)
        @(negedge clk);
        s_cfg_addr = 9'b01_000000_0;
        s_cfg_data = 32'h4F47_2020; // "OG  "
        @(negedge clk);
        s_cfg_addr = 9'b01_000000_1;
        s_cfg_data = 32'h0000_474F; // "GO"
        
        // Write 3: MSFT to Bank 2 (real hash = 12)
        @(negedge clk);
        s_cfg_addr = 9'b10_001100_0;
        s_cfg_data = 32'h4654_2020; // "FT  "
        @(negedge clk);
        s_cfg_addr = 9'b10_001100_1;
        s_cfg_data = 32'h0000_4D53; // "MS"
        
        // Write 4: NVDA to Bank 3 (real hash = 29)
        @(negedge clk);
        s_cfg_addr = 9'b11_011101_0;
        s_cfg_data = 32'h4441_2020; // "DA  "
        @(negedge clk);
        s_cfg_addr = 9'b11_011101_1;
        s_cfg_data = 32'h0000_4E56; // "NV"
        
        @(negedge clk);
        s_cfg_wr_en = 0;

        #30;

        
        // TODO 2: The Mismatch Attack
        
        @(negedge clk);
        s_cfg_wr_en=1;
        s_cfg_addr=9'b0_011100_0;
        s_cfg_data=32'hAAAA_AAAA;

        @(negedge clk);
        s_cfg_addr=9'b0_111100_1; // Changed to a DIFFERENT hash to force a mismatch!
        s_cfg_data=32'h0000_BBBB;

        @(negedge clk);
        s_cfg_wr_en=0;
        s_cfg_rd_en=1;

        @(negedge clk);
        if(s_cfg_rd_data[0]!==1'b1) fail("2: Sticky bit not set");
        
        // TODO 3: The Read-Clear
        
        @(negedge clk);
        if(s_cfg_rd_data[0]!==1'b0) fail("3: sticky bit didnt clear");
        s_cfg_rd_en=0;

        
        // TODO 4: The Set-vs-Clear Race
        
        @(negedge clk);
        s_cfg_wr_en = 1;
        s_cfg_addr  = 9'b0_101000_0;
        @(negedge clk);
        s_cfg_addr  = 9'b0_001100_1;
        s_cfg_rd_en = 1;
        @(negedge clk);
        s_cfg_wr_en=0;
        @(negedge clk);
        if (s_cfg_rd_data[0] !== 1'b1) fail("TODO 4 FAILED: Read-Clear swallowed the new error!");
        s_cfg_rd_en = 0;

        
        // PHASE 1: PARSER CORE (Scenarios 1-5)
        

        
        // Scenario 1: Valid Packet, In Table (AAPL)
        
        scenario_errors = 0;
        @(negedge clk);
        s_axis_tvalid = 1;
        s_axis_tdata = {96'b0, 16'h0800, 16'b0}; // Beat 1: EtherType

        @(negedge clk);
        s_axis_tdata = {56'b0, 8'h11, 64'b0};    // Beat 2: UDP Protocol

        @(negedge clk);
        s_axis_tdata = {80'b0, 48'h4141504C2020}; // Beat 3: Ticker "AAPL  "

        @(negedge clk);
        s_axis_tdata = {64'b0, 16'd100, 48'b0};   // Beat 4: Sequence 100

        @(negedge clk);
        s_axis_tdata = {128'hFFFFFFFF};           // Beat 5

        if(m_payload_valid !== 1'b1)
            fail("Scenario 1 Failed: Not a valid payload");
        if(fsm_state_dbg !== 3'b001)
            fail("Scenario 1 Failed: FSM is not in ST_ACTIVE");

        @(negedge clk);
        s_axis_tlast = 1;                         // Beat 6
        if(m_timestamp == 0)
            fail("Scenario 1 Failed: Timestamp did not latch!");

        @(negedge clk);
        s_axis_tvalid = 0;
        s_axis_tlast = 0;
        #50;
        if (scenario_errors == 0) $display("Scenario 1 Passed: Valid Packet Processed Correctly!");
        else                      $display("Scenario 1 FAILED (%0d errors).", scenario_errors);

        
        // Scenario 2: Valid Packet, NOT In Table (FAKE)
        
        scenario_errors = 0;
        @(negedge clk);
        s_axis_tvalid = 1;
        s_axis_tdata = {96'b0, 16'h0800, 16'b0}; // Beat 1: EtherType

        @(negedge clk);
        s_axis_tdata = {56'b0, 8'h11, 64'b0};    // Beat 2: UDP Protocol

        @(negedge clk);
        s_axis_tdata = {80'b0, 48'h46414B452020}; // Beat 3: Ticker "FAKE  "

        @(negedge clk);
        s_axis_tdata = {64'b0, 16'd100, 48'b0};   // Beat 4: Sequence 100

        @(negedge clk);
        s_axis_tdata = {128'hFFFFFFFF};           // Beat 5

        if(m_payload_valid !== 1'b0)
            fail("Scenario 2 Failed: Payload valid should be 0!");

        @(negedge clk);
        s_axis_tlast = 1;                         // Beat 6

        if(fsm_state_dbg !== 3'b001)
            fail("Scenario 2 Failed: FSM is not in ST_ACTIVE!");

        @(negedge clk);
        s_axis_tvalid = 0;
        s_axis_tlast = 0;
        #50;
        if (scenario_errors == 0) $display("Scenario 2 Passed: FAKE Ticker silently dropped!");
        else                      $display("Scenario 2 FAILED (%0d errors).", scenario_errors);

        
        // Scenario 3: Bad EtherType (ARP)
        
        scenario_errors = 0;
        @(negedge clk);
        s_axis_tvalid = 1;
        s_axis_tdata = {96'b0, 16'h0806, 16'b0}; // Beat 1: EtherType ARP

        @(negedge clk);
        s_axis_tlast = 1;                         // Beat 2: End early

        if(fsm_state_dbg !== 3'b010)
            fail("Scenario 3 Failed: FSM is not in ST_DROP_WAIT!");
        if(m_payload_valid !== 1'b0)
            fail("Scenario 3 Failed: Payload valid should be 0!");

        @(negedge clk);
        s_axis_tvalid = 0;
        s_axis_tlast = 0;
        #50;
        if (scenario_errors == 0) $display("Scenario 3 Passed: ARP packet dropped!");
        else                      $display("Scenario 3 FAILED (%0d errors).", scenario_errors);

        
        // Scenario 4: Bad Protocol (TCP)
        
        scenario_errors = 0;
        @(negedge clk);
        s_axis_tvalid = 1;
        s_axis_tdata = {96'b0, 16'h0800, 16'b0}; // Beat 1: EtherType

        @(negedge clk);
        s_axis_tdata = {56'b0, 8'h06, 64'b0};    // Beat 2: TCP Protocol

        @(negedge clk);
        s_axis_tlast=1;
        if(fsm_state_dbg !== 3'b010)
            fail("Scenario 4 Failed: FSM is not in ST_DROP_WAIT!");

        @(negedge clk);
        s_axis_tvalid = 0;
        s_axis_tlast = 0;
        #50;
        if (scenario_errors == 0) $display("Scenario 4 Passed: TCP!");
        else                      $display("Scenario 4 FAILED (%0d errors).", scenario_errors);

        
        // Scenario 5: Watchdog Timeout
        
        scenario_errors = 0;
        @(negedge clk);
        s_axis_tvalid = 1;
        s_axis_tdata = {96'b0, 16'h0800, 16'b0}; // Beat 1: EtherType

        @(negedge clk);
        s_axis_tdata = {56'b0, 8'h11, 64'b0};    // Beat 2: UDP Protocol

        @(negedge clk);
        s_axis_tvalid=0;
        s_axis_tdata=128'b0;

        repeat(34) @(negedge clk);

        if(fsm_state_dbg !== 3'b000)
            fail("Scenario 5 Failed: FSM is not in ST_IDLE!");

        @(negedge clk);
        s_axis_tvalid = 0;
        s_axis_tlast = 0;
        #50;
        if (scenario_errors == 0) $display("Scenario 5 Passed: Watchdog timeout!");
        else                      $display("Scenario 5 FAILED (%0d errors).", scenario_errors);

        
        // PHASE 2: PARSER CORE STRESS TESTS (Scenarios 6-10)
        

        
        // Scenario 6: Back-to-Back Packets
        
        scenario_errors = 0;
        @(negedge clk);
        s_axis_tvalid = 1;
        s_axis_tdata = {96'b0, 16'h0800, 16'b0}; // Beat 1: EtherType

        @(negedge clk);
        s_axis_tdata = {56'b0, 8'h11, 64'b0};    // Beat 2: UDP Protocol

        @(negedge clk);
        s_axis_tdata = {80'b0, 48'h4141504C2020}; // Beat 3: Ticker "AAPL  "

        @(negedge clk);
        s_axis_tdata = {64'b0, 16'd100, 48'b0};   // Beat 4: Sequence 100

        @(negedge clk);
        s_axis_tdata = {128'hFFFFFFFF};           // Beat 5

        if(m_payload_valid !== 1'b1)
            fail("Scenario 6 Failed: Not a valid payload on Packet 1");
        if(fsm_state_dbg !== 3'b001)
            fail("Scenario 6 Failed: FSM is not in ST_ACTIVE on Packet 1!");

        @(negedge clk);
        s_axis_tlast = 1;                         // Beat 6: End of packet 1

        // --- START PACKET 2 IMMEDIATELY ---
        @(negedge clk);
        s_axis_tlast = 0;
        s_axis_tvalid = 1;
        s_axis_tdata = {96'b0, 16'h0800, 16'b0}; // Beat 1: EtherType (Pkt 2)

        @(negedge clk);
        s_axis_tdata = {56'b0, 8'h11, 64'b0};    // Beat 2: UDP Protocol

        @(negedge clk);
        s_axis_tdata = {80'b0, 48'h4141504C2020}; // Beat 3: Ticker "AAPL  "

        @(negedge clk);
        s_axis_tdata = {64'b0, 16'd100, 48'b0};   // Beat 4: Sequence 100

        @(negedge clk);
        s_axis_tdata = {128'hFFFFFFFF};           // Beat 5

        if(m_payload_valid !== 1'b1)
            fail("Scenario 6 Failed: Not a valid payload on Packet 2");
        if(fsm_state_dbg !== 3'b001)
            fail("Scenario 6 Failed: FSM is not in ST_ACTIVE on Packet 2!");

        @(negedge clk);
        s_axis_tlast = 1;                         // Beat 6: End of packet 2

        @(negedge clk);
        s_axis_tvalid = 0;
        s_axis_tlast = 0;
        #50;
        if (scenario_errors == 0) $display("Scenario 6 Passed: Back-to-back packets!");
        else                      $display("Scenario 6 FAILED (%0d errors).", scenario_errors);

        
        // Scenario 7: Ticker Sequence (4 valid packets)
        
        scenario_errors = 0;
        for(int i=0;i<4;i++) begin
            @(negedge clk);
            s_axis_tvalid = 1;
            s_axis_tdata = {96'b0, 16'h0800, 16'b0}; // Beat 1: EtherType

            @(negedge clk);
            s_axis_tdata = {56'b0, 8'h11, 64'b0};    // Beat 2: UDP Protocol

            @(negedge clk);
            s_axis_tdata = {80'b0, 48'h4141504C2020}; // Beat 3: Ticker "AAPL  "

            @(negedge clk);
            s_axis_tdata = {64'b0, 16'd100, 48'b0};   // Beat 4: Sequence 100

            @(negedge clk);
            s_axis_tdata = {128'hFFFFFFFF};           // Beat 5

            if(m_payload_valid !== 1'b1)
                fail("Scenario 7 Failed: Not a valid payload");
            if(fsm_state_dbg !== 3'b001)
                fail("Scenario 7 Failed: FSM is not in ST_ACTIVE!");

            @(negedge clk);
            s_axis_tlast = 1;                         // Beat 6: End of packet

            @(negedge clk);
            s_axis_tvalid = 0;
            s_axis_tlast = 0;
            #50;
        end
        if (scenario_errors == 0) $display("Scenario 7 Passed: 4 Valid Packets Processed Correctly!");
        else                      $display("Scenario 7 FAILED (%0d errors).", scenario_errors);

        
        // Scenario 8: Mid-Packet Reset
        
        scenario_errors = 0;
        @(negedge clk);
        s_axis_tvalid = 1;
        s_axis_tdata = {96'b0, 16'h0800, 16'b0}; // Beat 1: EtherType

        @(negedge clk);
        s_axis_tdata = {56'b0, 8'h11, 64'b0};    // Beat 2: UDP Protocol

        @(negedge clk);
        reset_n=0;
        s_axis_tvalid=0;
        s_axis_tdata=0;

        repeat(2) @(negedge clk);

        reset_n=1;
        // Verify risk_layer outputs cleared by reset
        @(negedge clk); // allow one clock for flop outputs to settle
        if (anomaly_detected !== 1'b0)
            fail("Scenario 8 Failed: anomaly_detected not cleared by reset");
        if (anomaly_ticker !== 48'h0)
            fail("Scenario 8 Failed: anomaly_ticker not cleared by reset");
        if (expected_seq !== 16'h0)
            fail("Scenario 8 Failed: expected_seq not cleared by reset");
        if (received_seq !== 16'h0)
            fail("Scenario 8 Failed: received_seq not cleared by reset");
        if(fsm_state_dbg !== 3'b000)
            fail("Scenario 8 Failed: FSM is not in ST_IDLE!");

        @(negedge clk);
        s_axis_tvalid = 1;
        s_axis_tdata = {96'b0, 16'h0800, 16'b0}; // Beat 1: EtherType

        @(negedge clk);
        s_axis_tdata = {56'b0, 8'h11, 64'b0};    // Beat 2: UDP Protocol

        @(negedge clk);
        s_axis_tdata = {80'b0, 48'h4141504C2020}; // Beat 3: Ticker "AAPL  "

        @(negedge clk);
        s_axis_tdata = {64'b0, 16'd100, 48'b0};   // Beat 4: Sequence 100

        @(negedge clk);
        s_axis_tdata = {128'hFFFFFFFF};           // Beat 5

        if(m_payload_valid !== 1'b1)
            fail("Scenario 8 Failed: Not a valid payload after reset");
        if(fsm_state_dbg !== 3'b001)
            fail("Scenario 8 Failed: FSM is not in ST_ACTIVE after reset!");

        @(negedge clk);
        s_axis_tlast = 1;                         // Beat 6: End of packet
        if(m_timestamp == 0)
            fail("Scenario 8 Failed: Timestamp did not latch!");

        @(negedge clk);
        s_axis_tvalid = 0;
        s_axis_tlast = 0;
        #50;
        if (scenario_errors == 0) $display("Scenario 8 Passed: Mid-packet reset!");
        else                      $display("Scenario 8 FAILED (%0d errors).", scenario_errors);

        
        // Scenario 9: 100 Packets Back-to-Back
        
        scenario_errors = 0;
        @(negedge clk);
        repeat (100) begin
            s_axis_tvalid = 1;
            s_axis_tlast  = 0;
            s_axis_tdata = {96'b0, 16'h0800, 16'b0};

            @(negedge clk);
            s_axis_tdata = {56'b0, 8'h11, 64'b0};    // Beat 2

            @(negedge clk);
            s_axis_tdata = {80'b0, 48'h4141504C2020}; // Beat 3 "AAPL"

            @(negedge clk);
            s_axis_tdata = {64'b0, 16'd100, 48'b0};   // Beat 4

            @(negedge clk);
            s_axis_tdata = {128'hFFFFFFFF};           // Beat 5

            if(m_payload_valid !== 1'b1)
                fail("Scenario 9 Failed: Not a valid payload");
            if(fsm_state_dbg !== 3'b001)
                fail("Scenario 9 Failed: FSM is not in ST_ACTIVE!");

            @(negedge clk);
            s_axis_tlast = 1;                         // Beat 6: End of packet
            if(m_timestamp == 0)
                fail("Scenario 9 Failed: Timestamp did not latch!");

            @(negedge clk);
        end
        s_axis_tlast=0;
        s_axis_tvalid=0;
        #50;
        if (scenario_errors == 0) $display("Scenario 9 Passed: 100 packets!");
        else                      $display("Scenario 9 FAILED (%0d errors).", scenario_errors);

        
        // Scenario 10: Worst-Case Hash Bucket (4-Way Collision, NVDA/Bank 3)
        
        scenario_errors = 0;
        @(negedge clk);
        s_axis_tvalid = 1;
        s_axis_tdata = {96'b0, 16'h0800, 16'b0}; // Beat 1: EtherType

        @(negedge clk);
        s_axis_tdata = {56'b0, 8'h11, 64'b0};    // Beat 2: UDP Protocol

        @(negedge clk);
        s_axis_tdata = {80'b0, 48'h4E5644412020}; // Beat 3: Ticker "NVDA  "

        @(negedge clk);
        s_axis_tdata = {64'b0, 16'd100, 48'b0};   // Beat 4: Sequence 100

        @(negedge clk);
        s_axis_tdata = {128'hFFFFFFFF};           // Beat 5
        if(m_payload_valid !== 1'b1)
            fail("Scenario 10 Failed: Not a valid payload");
        if(fsm_state_dbg !== 3'b001)
            fail("Scenario 10 Failed: FSM is not in ST_ACTIVE!");

        @(negedge clk);
        s_axis_tlast = 1;                         // Beat 6: End of packet
        if(m_timestamp == 0)
            fail("Scenario 10 Failed: Timestamp did not latch!");

        @(negedge clk);
        s_axis_tvalid = 0;
        s_axis_tlast = 0;
        #50;
        if (scenario_errors == 0) $display("Scenario 10 Passed: 4-way hash collision survived!");
        else                      $display("Scenario 10 FAILED (%0d errors).", scenario_errors);

        
        // Scenario 11: The Short Packet Attack
        
        scenario_errors = 0;
        @(negedge clk);
        s_axis_tvalid = 1;
        s_axis_tdata = {96'b0, 16'h0800, 16'b0}; // Beat 1: EtherType

        @(negedge clk);
        s_axis_tdata = {56'b0, 8'h11, 64'b0};    // Beat 2: UDP Protocol

        @(negedge clk);
        s_axis_tdata = {80'b0, 48'h4E5644412020}; // Beat 3: Ticker "NVDA  "
        s_axis_tlast=1;

        @(negedge clk); // Wait for FSM to react on the posedge

        if(fsm_state_dbg !== 3'b000)
            fail("Scenario 11 Failed: FSM is not in ST_IDLE!");
        if(m_payload_valid !== 1'b0)
            fail("Scenario 11 Failed: Payload valid was asserted during malformed packet!");

        @(negedge clk);
        s_axis_tvalid=0;
        s_axis_tlast=0;
        s_axis_tdata=0;
        #50;
        if (scenario_errors == 0) $display("Scenario 11 Passed: Short packet attack defended!");
        else                      $display("Scenario 11 FAILED (%0d errors).", scenario_errors);

        
        // PHASE 3: RISK LAYER (Sequence Anomaly Detection)
        

        // Clean reset so Risk Layer's sequence memory is cleared
        // from all the Sequence 100 packets sent in Phases 1 and 2.
        // Use negedge-aligned reset to avoid #-delay race conditions.
        @(negedge clk);
        reset_n = 0;
        repeat(3) @(negedge clk);
        reset_n = 1;
        repeat(3) @(negedge clk); // let pipeline drain after reset

        
        // Scenario 12: Sequential Packets (No Anomaly)
        
        scenario_errors = 0;
        // Hold clear_anomaly for 2 negedge cycles so at least one
        // posedge sees it=1, avoiding the #-delay/posedge race.
        clear_anomaly = 1;
        repeat(2) @(negedge clk);
        clear_anomaly = 0;
        @(negedge clk); // settle
        send_packet(48'h4141504C2020, 16'd101); // AAPL Seq 101
        #50;
        send_packet(48'h4141504C2020, 16'd102); // AAPL Seq 102
        #50;
        if (caught_anomaly == 1)
            fail("Scenario 12 Failed: False anomaly detected on sequential packets!");
        if (scenario_errors == 0) $display("Scenario 12 Passed: Sequential packets, no anomaly!");
        else                      $display("Scenario 12 FAILED (%0d errors).", scenario_errors);

        
        // Scenario 13: Sequence Gap
        
        scenario_errors = 0;
        clear_anomaly = 1; @(negedge clk); clear_anomaly = 0;
        send_packet(48'h4141504C2020, 16'd104); // AAPL Seq 104 (Skipped 103!)
        #50;
        if (caught_anomaly == 0)
            fail("Scenario 13 Failed: Missed a sequence gap!");
        if (caught_exp !== 16'd103 || caught_rec !== 16'd104)
            fail("Scenario 13 Failed: Wrong anomaly details logged!");
        if (scenario_errors == 0) $display("Scenario 13 Passed: Sequence gap detected!");
        else                      $display("Scenario 13 FAILED (%0d errors).", scenario_errors);

        
        // Scenario 14: Sequence Regression
        
        scenario_errors = 0;
        clear_anomaly = 1; @(negedge clk); clear_anomaly = 0;
        send_packet(48'h4141504C2020, 16'd102); // AAPL Seq 102 (Regression!)
        #50;
        if (caught_anomaly == 0)
            fail("Scenario 14 Failed: Missed a sequence regression!");
        if (scenario_errors == 0) $display("Scenario 14 Passed: Sequence regression detected!");
        else                      $display("Scenario 14 FAILED (%0d errors).", scenario_errors);

        
        // Scenario 15: Independent Tickers (No Cross-Contamination)
        
        scenario_errors = 0;
        // Even though AAPL just regressed to 102, GOOG (Bank 1) is still at 0!
        clear_anomaly = 1;
        repeat(2) @(negedge clk);
        clear_anomaly = 0;
        @(negedge clk); // settle
        send_packet(48'h474F4F472020, 16'd1); // GOOG Seq 1
        #50;
        send_packet(48'h474F4F472020, 16'd2); // GOOG Seq 2
        #50;
        if (caught_anomaly == 1)
            fail("Scenario 15 Failed: Ticker sequences are cross-contaminating!");
        if (scenario_errors == 0) $display("Scenario 15 Passed: Independent ticker isolation confirmed!");
        else                      $display("Scenario 15 FAILED (%0d errors).", scenario_errors);

        
        // PHASE 4: OBSERVER LAYER (Latency Measurement)
        

        
        // Scenario 16: Timestamp Latency Offset
        
        scenario_errors = 0;
        send_packet(48'h4141504C2020, 16'd200); // Send AAPL
        #50;
        $display("Scenario 16: measured latency = %0d cycles", (m_timestamp - last_packet_start_time));
        if (m_timestamp - last_packet_start_time !== 4)
            fail($sformatf("Scenario 16 Failed: Expected latency delta of 4, got %0d (start=%0d, end=%0d)",
                    (m_timestamp - last_packet_start_time), last_packet_start_time, m_timestamp));
        if (scenario_errors == 0) $display("Scenario 16 Passed!");
        else                      $display("Scenario 16 FAILED (%0d errors).", scenario_errors);

        
        // PHASE 5: THE FINAL BOSS (V2 Architecture)
        

        
        // Scenario 17: Zero-Gap Back-to-Back Collision Test
        
        scenario_errors = 0;
        @(negedge clk);
        // AAPL Packet - Beat 1
        s_axis_tvalid = 1;
        s_axis_tdata = {96'b0, 16'h0800, 16'b0};

        @(negedge clk);
        // AAPL Packet - Beat 2
        s_axis_tdata = {56'b0, 8'h11, 64'b0};

        @(negedge clk);
        // AAPL Packet - Beat 3
        s_axis_tdata = {80'b0, 48'h4141504C2020}; // AAPL

        @(negedge clk);
        // AAPL Packet - Beat 4 (tlast)
        s_axis_tdata = {64'b0, 16'd300, 48'b0};
        s_axis_tlast = 1;

        @(negedge clk);
        // Cycle 5: GOOG Packet - Beat 1
        // At this exact moment, m_payload_valid for AAPL should be 1!
        if (m_payload_valid !== 1'b1)
            fail("Scenario 17 Failed: AAPL payload was dropped during collision!");
        s_axis_tlast = 0;
        s_axis_tvalid = 1;
        s_axis_tdata = {96'b0, 16'h0800, 16'b0};

        @(negedge clk);
        // Cycle 6: GOOG Packet - Beat 2
        s_axis_tdata = {56'b0, 8'h11, 64'b0};

        @(negedge clk);
        // Cycle 7: GOOG Packet - Beat 3
        s_axis_tdata = {80'b0, 48'h474F4F472020}; // GOOG

        @(negedge clk);
        // Cycle 8: GOOG Packet - Beat 4 (tlast)
        s_axis_tdata = {64'b0, 16'd301, 48'b0};
        s_axis_tlast = 1;

        @(negedge clk);
        // Cycle 9: GOOG finishes.
        // At this exact moment, m_payload_valid for GOOG should be 1!
        if (m_payload_valid !== 1'b1)
            fail("Scenario 17 Failed: GOOG payload was dropped during collision!");
        s_axis_tlast = 0;
        s_axis_tvalid = 0;
        #50;
        if (scenario_errors == 0) $display("Scenario 17 Passed: Zero-Gap Collision Survived!");
        else                      $display("Scenario 17 FAILED (%0d errors).", scenario_errors);

        
        // Scenario 18: Early tlast (Short Packet) Zero-Gap Collision
        
        scenario_errors = 0;
        @(negedge clk);
        // Bad Packet - Beat 1 (EtherType OK)
        s_axis_tvalid = 1;
        s_axis_tdata = {96'b0, 16'h0800, 16'b0};

        @(negedge clk);
        // Bad Packet - Beat 2 (Early tlast!)
        s_axis_tdata = {56'b0, 8'h11, 64'b0};
        s_axis_tlast = 1;

        @(negedge clk);
        // Cycle 3: AAPL Packet - Beat 1 (Zero Gap!)
        if (m_payload_valid !== 1'b0)
            fail("Scenario 18 Failed: Spurious m_payload_valid during zero-gap transition!");
        s_axis_tlast = 0;
        s_axis_tvalid = 1;
        s_axis_tdata = {96'b0, 16'h0800, 16'b0};

        @(negedge clk);
        // Cycle 4: AAPL Packet - Beat 2
        if (m_payload_valid !== 1'b0)
            fail("Scenario 18 Failed: Spurious m_payload_valid during zero-gap transition!");
        s_axis_tdata = {56'b0, 8'h11, 64'b0};

        @(negedge clk);
        // Cycle 5: AAPL Packet - Beat 3
        if (m_payload_valid !== 1'b0)
            fail("Scenario 18 Failed: Spurious m_payload_valid during zero-gap transition!");
        s_axis_tdata = {80'b0, 48'h4141504C2020}; // AAPL

        @(negedge clk);
        // Cycle 6: AAPL Packet - Beat 4 (tlast)
        if (m_payload_valid !== 1'b0)
            fail("Scenario 18 Failed: Spurious m_payload_valid during zero-gap transition!");
        s_axis_tdata = {64'b0, 16'd302, 48'b0};
        s_axis_tlast = 1;

        @(negedge clk);
        // Cycle 7: AAPL finishes. m_payload_valid for AAPL should be 1!
        if (m_payload_valid !== 1'b1)
            fail("Scenario 18 Failed: AAPL payload was dropped after short packet collision!");
        s_axis_tlast = 0;
        s_axis_tvalid = 0;
        #50;
        if (scenario_errors == 0) $display("Scenario 18 Passed: Early tlast zero-gap survived!");
        else                      $display("Scenario 18 FAILED (%0d errors).", scenario_errors);

        
        // FINAL VERDICT — gated on actual error count
        
        if (error_count == 0) begin
            $display("ALL SCENARIOS PASSED");
            $finish;
        end else begin
            $fatal(1, "%0d SCENARIO(S) FAILED. See errors above.", error_count);
        end
    end
endmodule
