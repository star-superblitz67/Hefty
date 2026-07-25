module ingress_fsm (
    input  logic         clk,
    input  logic         reset_n,
    
    // AXI-Stream input
    input  logic [127:0] s_axis_tdata,
    input  logic         s_axis_tvalid,
    input  logic         s_axis_tlast,
    
    //  watchdog
    input  logic         timeout,
    
    //  lookaside table
    input  logic         match_found,
    
    //  staging register
    output logic         latch_en,
    
    //  lookaside table
    output logic         dram_rd_en,
    
    //  output
    output logic [127:0] m_payload_data,
    output logic         m_payload_valid,
    
    // Debug, Taps
    output logic [2:0]   fsm_state_dbg,
    output logic         pipe_valid_5
);

    // Three states: idle, actively parsing a packet, or waiting to drop bad one
    localparam [2:0] ST_IDLE      = 3'b000;
    localparam [2:0] ST_ACTIVE    = 3'b001;
    localparam [2:0] ST_DROP_WAIT = 3'b010;

    logic [2:0] current_state, next_state;


    // 1. Beat counter, tracks which 128bit chunk of the packet we are looking at

    logic [3:0] beat_count;
    logic       is_new_packet;
    
    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            beat_count <= 4'd0;
            is_new_packet <= 1'b1;
        end else if (timeout) begin
            beat_count <= 4'd0;
            is_new_packet <= 1'b1;
        end else if (s_axis_tvalid) begin
            if (s_axis_tlast) begin
                beat_count <= 4'd0;
                is_new_packet <= 1'b1;
            end else begin
                if (is_new_packet) begin
                    beat_count <= 4'd1;
                end else if (beat_count != 4'd15) begin
                    beat_count <= beat_count + 4'd1;
                end
                is_new_packet <= 1'b0;
            end
        end
    end
    
    // Combinational evaluation of the beat currently on the bus
    logic [3:0] current_beat;
    always_comb begin
        if (s_axis_tvalid) begin
            if (is_new_packet) begin
                current_beat = 4'd1;
            end else begin
                current_beat = beat_count + 4'd1;
            end
        end else begin
            current_beat = beat_count;
        end
    end


    // 2. Main state machine  decides whether to keep parsing or drop the packet
    
    always_comb begin
        next_state = current_state;
        
        if (timeout) begin
            next_state = ST_IDLE;
        end else if (s_axis_tlast && s_axis_tvalid) begin
            next_state = ST_IDLE; // Always return to IDLE at end of packet
        end else begin
            case (current_state)
                ST_IDLE: begin
                    if (s_axis_tvalid && current_beat == 4'd1) begin
                        if (s_axis_tdata[31:16] == 16'h0800) begin
                            next_state = ST_ACTIVE;
                        end else begin
                            next_state = ST_DROP_WAIT;
                        end
                    end
                end
                
                ST_ACTIVE: begin
                    if (s_axis_tvalid && current_beat == 4'd2) begin
                        // Check if it is UDP (protocol 0x11). If not, drop it.
                        if (s_axis_tdata[71:64] != 8'h11) begin
                            next_state = ST_DROP_WAIT;
                        end
                    end
                    // Stay in ST_ACTIVE until tlast
                end
                
                ST_DROP_WAIT: begin
                    // Just sit here doing nothing until the bad packet ends
                end
                
                default: next_state = ST_IDLE;
            endcase
        end
    end

    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            current_state <= ST_IDLE;
        end else begin
            current_state <= next_state;
        end
    end


    // 3. Datapath  controls when we latch the ticker, look it up, and forward payload
    
    // We gate everything off the beat counter, not the FSM state.
    // This keeps the datapath clean and predictable.
    
    assign latch_en   = (current_state == ST_ACTIVE) && s_axis_tvalid && (current_beat == 4'd3);
    assign dram_rd_en = (current_state == ST_ACTIVE) && s_axis_tvalid && (current_beat == 4'd4);
    
    // Shift register delay for BRAM latency (Cycle 4 -> Cycle 5)
    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            pipe_valid_5 <= 1'b0;
        end else if (timeout) begin
            pipe_valid_5 <= 1'b0;
        end else begin
            // One cycle delay so the lookup result is ready when we check it
            // If the packet aborted early (tlast before beat 4), dram_rd_en never fires.
            pipe_valid_5 <= dram_rd_en;
        end
    end

    // match on cycle 5, keep forwarding the rest
    logic forward_stream;
    
    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            forward_stream <= 1'b0;
        end else if (timeout) begin
            forward_stream <= 1'b0;
        end else begin
            if (pipe_valid_5 && match_found) begin
                // If the packet ends right on cycle 5, there is nothing left to forward
                if (s_axis_tvalid && s_axis_tlast) begin
                    forward_stream <= 1'b0;
                end else begin
                    forward_stream <= 1'b1;
                end
            end else if (forward_stream && s_axis_tvalid && s_axis_tlast) begin
                forward_stream <= 1'b0;
            end
        end
    end

    always_comb begin
        m_payload_valid = 1'b0;
        m_payload_data  = 128'b0;

        if (pipe_valid_5 && match_found) begin
            m_payload_valid = 1'b1;
            m_payload_data  = s_axis_tdata;
        end else if (forward_stream) begin
            m_payload_valid = s_axis_tvalid;
            m_payload_data  = s_axis_tdata;
        end
    end

    // Debug output
    assign fsm_state_dbg = current_state;

endmodule
