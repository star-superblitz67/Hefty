module top_level (
    input  logic         clk,
    input  logic         reset_n,

    input  logic [127:0] s_axis_tdata,
    input  logic         s_axis_tvalid,
    input  logic         s_axis_tlast,

    output logic [127:0] m_payload_data,
    output logic         m_payload_valid,

    input  logic         s_cfg_wr_en,
    input  logic         s_cfg_rd_en,
    input  logic [8:0]   s_cfg_addr,
    input  logic [31:0]  s_cfg_data,
    output logic [31:0]  s_cfg_rd_data,
    
    // Tap outputs exposed to top-level pins for testbench / downstream
    output logic [63:0]  m_timestamp,
    output logic [47:0]  anomaly_ticker,
    output logic         anomaly_detected,
    output logic [15:0]  expected_seq,
    output logic [15:0]  received_seq,
    
    // Debug
    output logic [2:0]   fsm_state_dbg
);

    // ---------------------------------------------------------
    // Internal Wires (Tap signals from Core to Taps)
    // ---------------------------------------------------------
    logic         bram_wr_en;
    logic [5:0]   bram_wr_addr;
    logic [1:0]   bram_wr_bank;
    logic [47:0]  bram_wr_data;

    logic         match_found_pulse;
    logic [5:0]   hash_idx_out;
    logic [15:0]  seq_num_out;
    logic [47:0]  ticker_out;
    logic         bank0_hit_out;
    logic         bank1_hit_out;
    logic         bank2_hit_out;
    logic         bank3_hit_out;

    // ---------------------------------------------------------
    // Level 0: Parser Core
    // ---------------------------------------------------------
    parser_core u_parser_core (
        .clk               (clk),
        .reset_n           (reset_n),
        .s_axis_tdata      (s_axis_tdata),
        .s_axis_tvalid     (s_axis_tvalid),
        .s_axis_tlast      (s_axis_tlast),
        .m_payload_data    (m_payload_data),
        .m_payload_valid   (m_payload_valid),
        .bram_wr_en        (bram_wr_en),
        .bram_wr_addr      (bram_wr_addr),
        .bram_wr_bank      (bram_wr_bank),
        .bram_wr_data      (bram_wr_data),
        .match_found_pulse (match_found_pulse),
        .hash_idx_out      (hash_idx_out),
        .seq_num_out       (seq_num_out),
        .ticker_out        (ticker_out),
        .bank0_hit_out     (bank0_hit_out),
        .bank1_hit_out     (bank1_hit_out),
        .bank2_hit_out     (bank2_hit_out),
        .bank3_hit_out     (bank3_hit_out),
        .fsm_state_dbg     (fsm_state_dbg)
    );

    // ---------------------------------------------------------
    // Level 1: Risk Layer (Sequence Anomaly Tap)
    // ---------------------------------------------------------
    risk_layer u_risk_layer (
        .clk               (clk),
        .reset_n           (reset_n),
        .match_found       (match_found_pulse),
        .hash_idx          (hash_idx_out),
        .seq_num_in        (seq_num_out), 
        .ticker_in         (ticker_out),
        .anomaly_detected  (anomaly_detected),
        .anomaly_ticker    (anomaly_ticker),
        .expected_seq      (expected_seq),
        .received_seq      (received_seq),
        .bank0_hit         (bank0_hit_out),
        .bank1_hit         (bank1_hit_out),
        .bank2_hit         (bank2_hit_out),
        .bank3_hit         (bank3_hit_out)
    );

    // ---------------------------------------------------------
    // Level 1: Observer Layer (Timestamp Tap)
    // ---------------------------------------------------------
    observer_layer u_observer_layer (
        .clk         (clk),
        .reset_n     (reset_n),
        .match_found (match_found_pulse),
        .m_timestamp (m_timestamp)
    );

    // ---------------------------------------------------------
    // Level 1: Config Controller (BRAM Write Tap)
    // ---------------------------------------------------------
    config_controller u_config_controller (
        .clk           (clk),
        .reset_n       (reset_n),
        .s_cfg_wr_en   (s_cfg_wr_en),
        .s_cfg_rd_en   (s_cfg_rd_en),
        .s_cfg_addr    (s_cfg_addr),
        .s_cfg_data    (s_cfg_data),
        .s_cfg_rd_data (s_cfg_rd_data),
        .bram_wr_en   (bram_wr_en),
        .bram_wr_addr (bram_wr_addr),
        .bram_wr_bank (bram_wr_bank),
        .bram_wr_data (bram_wr_data)
    );

endmodule
