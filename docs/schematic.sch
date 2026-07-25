# File saved with Nlview 7.8.0 2024-04-26 e1825d835c VDI=44 GEI=38 GUI=JA:21.0 threadsafe
# 
# non-default properties - (restore without -noprops)
property -colorscheme classic
property attrcolor #000000
property attrfontsize 8
property autobundle 1
property backgroundcolor #ffffff
property boxcolor0 #000000
property boxcolor1 #000000
property boxcolor2 #000000
property boxinstcolor #000000
property boxpincolor #000000
property buscolor #008000
property closeenough 5
property createnetattrdsp 2048
property decorate 1
property elidetext 40
property fillcolor1 #ffffcc
property fillcolor2 #dfebf8
property fillcolor3 #f0f0f0
property gatecellname 2
property instattrmax 30
property instdrag 15
property instorder 1
property marksize 12
property maxfontsize 12
property maxzoom 5
property netcolor #19b400
property objecthighlight0 #ff00ff
property objecthighlight1 #ffff00
property objecthighlight2 #00ff00
property objecthighlight3 #0095ff
property objecthighlight4 #8000ff
property objecthighlight5 #ffc800
property objecthighlight7 #00ffff
property objecthighlight8 #ff00ff
property objecthighlight9 #ccccff
property objecthighlight10 #0ead00
property objecthighlight11 #cefc00
property objecthighlight12 #9e2dbe
property objecthighlight13 #ba6a29
property objecthighlight14 #fc0188
property objecthighlight15 #02f990
property objecthighlight16 #f1b0fb
property objecthighlight17 #fec004
property objecthighlight18 #149bff
property objecthighlight19 #eb591b
property overlaycolor #19b400
property pbuscolor #000000
property pbusnamecolor #000000
property pinattrmax 20
property pinorder 2
property pinpermute 0
property portcolor #000000
property portnamecolor #000000
property ripindexfontsize 4
property rippercolor #000000
property rubberbandcolor #000000
property rubberbandfontsize 12
property selectattr 0
property selectionappearance 2
property selectioncolor #0000ff
property sheetheight 44
property sheetwidth 68
property showmarks 1
property shownetname 0
property showpagenumbers 1
property showripindex 1
property timelimit 1
#
module new top_level work:top_level:NOFILE -nosplit
load symbol config_controller work:config_controller:NOFILE HIERBOX pin clk input.left pin dram_wr_en output.right pin reset_n input.left pin s_cfg_rd_en input.left pin s_cfg_wr_en input.left pinBus dram_wr_addr output.right [5:0] pinBus dram_wr_bank output.right [1:0] pinBus dram_wr_data output.right [47:0] pinBus s_cfg_addr input.left [8:0] pinBus s_cfg_data input.left [31:0] pinBus s_cfg_rd_data output.right [31:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol observer_layer work:observer_layer:NOFILE HIERBOX pin clk input.left pin match_found input.left pin reset_n input.left pinBus m_timestamp output.right [63:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol parser_core work:parser_core:NOFILE HIERBOX pin bank0_hit_out output.right pin bank1_hit_out output.right pin bank2_hit_out output.right pin bank3_hit_out output.right pin clk input.left pin dram_wr_en input.left pin m_payload_valid output.right pin match_found_pulse output.right pin reset_n input.left pin s_axis_tlast input.left pin s_axis_tvalid input.left pinBus dram_wr_addr input.left [5:0] pinBus dram_wr_bank input.left [1:0] pinBus dram_wr_data input.left [47:0] pinBus fsm_state_dbg output.right [2:0] pinBus hash_idx_out output.right [5:0] pinBus m_payload_data output.right [127:0] pinBus s_axis_tdata input.left [127:0] pinBus seq_num_out output.right [15:0] pinBus ticker_out output.right [47:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol risk_layer work:risk_layer:NOFILE HIERBOX pin anomaly_detected output.right pin bank0_hit input.left pin bank1_hit input.left pin bank2_hit input.left pin bank3_hit input.left pin clk input.left pin match_found input.left pin reset_n input.left pinBus anomaly_ticker output.right [47:0] pinBus expected_seq output.right [15:0] pinBus hash_idx input.left [5:0] pinBus received_seq output.right [15:0] pinBus seq_num_in input.left [15:0] pinBus ticker_in input.left [47:0] boxcolor 1 fillcolor 2 minwidth 13%
load port anomaly_detected output -pg 1 -lvl 4 -x 1270 -y 150
load port clk input -pg 1 -lvl 0 -x 0 -y 20
load port m_payload_valid output -pg 1 -lvl 4 -x 1270 -y 330
load port reset_n input -pg 1 -lvl 0 -x 0 -y 90
load port s_axis_tlast input -pg 1 -lvl 0 -x 0 -y 250
load port s_axis_tvalid input -pg 1 -lvl 0 -x 0 -y 270
load port s_cfg_rd_en input -pg 1 -lvl 0 -x 0 -y 150
load port s_cfg_wr_en input -pg 1 -lvl 0 -x 0 -y 170
load portBus anomaly_ticker output [47:0] -attr @name anomaly_ticker[47:0] -pg 1 -lvl 4 -x 1270 -y 170
load portBus expected_seq output [15:0] -attr @name expected_seq[15:0] -pg 1 -lvl 4 -x 1270 -y 190
load portBus fsm_state_dbg output [2:0] -attr @name fsm_state_dbg[2:0] -pg 1 -lvl 4 -x 1270 -y 30
load portBus m_payload_data output [127:0] -attr @name m_payload_data[127:0] -pg 1 -lvl 4 -x 1270 -y 310
load portBus m_timestamp output [63:0] -attr @name m_timestamp[63:0] -pg 1 -lvl 4 -x 1270 -y 430
load portBus received_seq output [15:0] -attr @name received_seq[15:0] -pg 1 -lvl 4 -x 1270 -y 210
load portBus s_axis_tdata input [127:0] -attr @name s_axis_tdata[127:0] -pg 1 -lvl 0 -x 0 -y 230
load portBus s_cfg_addr input [8:0] -attr @name s_cfg_addr[8:0] -pg 1 -lvl 0 -x 0 -y 110
load portBus s_cfg_data input [31:0] -attr @name s_cfg_data[31:0] -pg 1 -lvl 0 -x 0 -y 130
load portBus s_cfg_rd_data output [31:0] -attr @name s_cfg_rd_data[31:0] -pg 1 -lvl 4 -x 1270 -y 350
load inst u_config_controller config_controller work:config_controller:NOFILE -autohide -attr @cell(#000000) config_controller -pinBusAttr dram_wr_addr @name dram_wr_addr[5:0] -pinBusAttr dram_wr_bank @name dram_wr_bank[1:0] -pinBusAttr dram_wr_data @name dram_wr_data[47:0] -pinBusAttr s_cfg_addr @name s_cfg_addr[8:0] -pinBusAttr s_cfg_data @name s_cfg_data[31:0] -pinBusAttr s_cfg_rd_data @name s_cfg_rd_data[31:0] -pg 1 -lvl 1 -x 150 -y 60
load inst u_observer_layer observer_layer work:observer_layer:NOFILE -autohide -attr @cell(#000000) observer_layer -pinBusAttr m_timestamp @name m_timestamp[63:0] -pg 1 -lvl 3 -x 1060 -y 400
load inst u_parser_core parser_core work:parser_core:NOFILE -autohide -attr @cell(#000000) parser_core -pinBusAttr dram_wr_addr @name dram_wr_addr[5:0] -pinBusAttr dram_wr_bank @name dram_wr_bank[1:0] -pinBusAttr dram_wr_data @name dram_wr_data[47:0] -pinBusAttr fsm_state_dbg @name fsm_state_dbg[2:0] -pinBusAttr hash_idx_out @name hash_idx_out[5:0] -pinBusAttr m_payload_data @name m_payload_data[127:0] -pinBusAttr s_axis_tdata @name s_axis_tdata[127:0] -pinBusAttr seq_num_out @name seq_num_out[15:0] -pinBusAttr ticker_out @name ticker_out[47:0] -pg 1 -lvl 2 -x 590 -y 80
load inst u_risk_layer risk_layer work:risk_layer:NOFILE -autohide -attr @cell(#000000) risk_layer -pinBusAttr anomaly_ticker @name anomaly_ticker[47:0] -pinBusAttr expected_seq @name expected_seq[15:0] -pinBusAttr hash_idx @name hash_idx[5:0] -pinBusAttr received_seq @name received_seq[15:0] -pinBusAttr seq_num_in @name seq_num_in[15:0] -pinBusAttr ticker_in @name ticker_in[47:0] -pg 1 -lvl 3 -x 1060 -y 80
load net anomaly_detected -port anomaly_detected -pin u_risk_layer anomaly_detected
netloc anomaly_detected 1 3 1 NJ 150
load net anomaly_ticker[0] -attr @rip anomaly_ticker[0] -port anomaly_ticker[0] -pin u_risk_layer anomaly_ticker[0]
load net anomaly_ticker[10] -attr @rip anomaly_ticker[10] -port anomaly_ticker[10] -pin u_risk_layer anomaly_ticker[10]
load net anomaly_ticker[11] -attr @rip anomaly_ticker[11] -port anomaly_ticker[11] -pin u_risk_layer anomaly_ticker[11]
load net anomaly_ticker[12] -attr @rip anomaly_ticker[12] -port anomaly_ticker[12] -pin u_risk_layer anomaly_ticker[12]
load net anomaly_ticker[13] -attr @rip anomaly_ticker[13] -port anomaly_ticker[13] -pin u_risk_layer anomaly_ticker[13]
load net anomaly_ticker[14] -attr @rip anomaly_ticker[14] -port anomaly_ticker[14] -pin u_risk_layer anomaly_ticker[14]
load net anomaly_ticker[15] -attr @rip anomaly_ticker[15] -port anomaly_ticker[15] -pin u_risk_layer anomaly_ticker[15]
load net anomaly_ticker[16] -attr @rip anomaly_ticker[16] -port anomaly_ticker[16] -pin u_risk_layer anomaly_ticker[16]
load net anomaly_ticker[17] -attr @rip anomaly_ticker[17] -port anomaly_ticker[17] -pin u_risk_layer anomaly_ticker[17]
load net anomaly_ticker[18] -attr @rip anomaly_ticker[18] -port anomaly_ticker[18] -pin u_risk_layer anomaly_ticker[18]
load net anomaly_ticker[19] -attr @rip anomaly_ticker[19] -port anomaly_ticker[19] -pin u_risk_layer anomaly_ticker[19]
load net anomaly_ticker[1] -attr @rip anomaly_ticker[1] -port anomaly_ticker[1] -pin u_risk_layer anomaly_ticker[1]
load net anomaly_ticker[20] -attr @rip anomaly_ticker[20] -port anomaly_ticker[20] -pin u_risk_layer anomaly_ticker[20]
load net anomaly_ticker[21] -attr @rip anomaly_ticker[21] -port anomaly_ticker[21] -pin u_risk_layer anomaly_ticker[21]
load net anomaly_ticker[22] -attr @rip anomaly_ticker[22] -port anomaly_ticker[22] -pin u_risk_layer anomaly_ticker[22]
load net anomaly_ticker[23] -attr @rip anomaly_ticker[23] -port anomaly_ticker[23] -pin u_risk_layer anomaly_ticker[23]
load net anomaly_ticker[24] -attr @rip anomaly_ticker[24] -port anomaly_ticker[24] -pin u_risk_layer anomaly_ticker[24]
load net anomaly_ticker[25] -attr @rip anomaly_ticker[25] -port anomaly_ticker[25] -pin u_risk_layer anomaly_ticker[25]
load net anomaly_ticker[26] -attr @rip anomaly_ticker[26] -port anomaly_ticker[26] -pin u_risk_layer anomaly_ticker[26]
load net anomaly_ticker[27] -attr @rip anomaly_ticker[27] -port anomaly_ticker[27] -pin u_risk_layer anomaly_ticker[27]
load net anomaly_ticker[28] -attr @rip anomaly_ticker[28] -port anomaly_ticker[28] -pin u_risk_layer anomaly_ticker[28]
load net anomaly_ticker[29] -attr @rip anomaly_ticker[29] -port anomaly_ticker[29] -pin u_risk_layer anomaly_ticker[29]
load net anomaly_ticker[2] -attr @rip anomaly_ticker[2] -port anomaly_ticker[2] -pin u_risk_layer anomaly_ticker[2]
load net anomaly_ticker[30] -attr @rip anomaly_ticker[30] -port anomaly_ticker[30] -pin u_risk_layer anomaly_ticker[30]
load net anomaly_ticker[31] -attr @rip anomaly_ticker[31] -port anomaly_ticker[31] -pin u_risk_layer anomaly_ticker[31]
load net anomaly_ticker[32] -attr @rip anomaly_ticker[32] -port anomaly_ticker[32] -pin u_risk_layer anomaly_ticker[32]
load net anomaly_ticker[33] -attr @rip anomaly_ticker[33] -port anomaly_ticker[33] -pin u_risk_layer anomaly_ticker[33]
load net anomaly_ticker[34] -attr @rip anomaly_ticker[34] -port anomaly_ticker[34] -pin u_risk_layer anomaly_ticker[34]
load net anomaly_ticker[35] -attr @rip anomaly_ticker[35] -port anomaly_ticker[35] -pin u_risk_layer anomaly_ticker[35]
load net anomaly_ticker[36] -attr @rip anomaly_ticker[36] -port anomaly_ticker[36] -pin u_risk_layer anomaly_ticker[36]
load net anomaly_ticker[37] -attr @rip anomaly_ticker[37] -port anomaly_ticker[37] -pin u_risk_layer anomaly_ticker[37]
load net anomaly_ticker[38] -attr @rip anomaly_ticker[38] -port anomaly_ticker[38] -pin u_risk_layer anomaly_ticker[38]
load net anomaly_ticker[39] -attr @rip anomaly_ticker[39] -port anomaly_ticker[39] -pin u_risk_layer anomaly_ticker[39]
load net anomaly_ticker[3] -attr @rip anomaly_ticker[3] -port anomaly_ticker[3] -pin u_risk_layer anomaly_ticker[3]
load net anomaly_ticker[40] -attr @rip anomaly_ticker[40] -port anomaly_ticker[40] -pin u_risk_layer anomaly_ticker[40]
load net anomaly_ticker[41] -attr @rip anomaly_ticker[41] -port anomaly_ticker[41] -pin u_risk_layer anomaly_ticker[41]
load net anomaly_ticker[42] -attr @rip anomaly_ticker[42] -port anomaly_ticker[42] -pin u_risk_layer anomaly_ticker[42]
load net anomaly_ticker[43] -attr @rip anomaly_ticker[43] -port anomaly_ticker[43] -pin u_risk_layer anomaly_ticker[43]
load net anomaly_ticker[44] -attr @rip anomaly_ticker[44] -port anomaly_ticker[44] -pin u_risk_layer anomaly_ticker[44]
load net anomaly_ticker[45] -attr @rip anomaly_ticker[45] -port anomaly_ticker[45] -pin u_risk_layer anomaly_ticker[45]
load net anomaly_ticker[46] -attr @rip anomaly_ticker[46] -port anomaly_ticker[46] -pin u_risk_layer anomaly_ticker[46]
load net anomaly_ticker[47] -attr @rip anomaly_ticker[47] -port anomaly_ticker[47] -pin u_risk_layer anomaly_ticker[47]
load net anomaly_ticker[4] -attr @rip anomaly_ticker[4] -port anomaly_ticker[4] -pin u_risk_layer anomaly_ticker[4]
load net anomaly_ticker[5] -attr @rip anomaly_ticker[5] -port anomaly_ticker[5] -pin u_risk_layer anomaly_ticker[5]
load net anomaly_ticker[6] -attr @rip anomaly_ticker[6] -port anomaly_ticker[6] -pin u_risk_layer anomaly_ticker[6]
load net anomaly_ticker[7] -attr @rip anomaly_ticker[7] -port anomaly_ticker[7] -pin u_risk_layer anomaly_ticker[7]
load net anomaly_ticker[8] -attr @rip anomaly_ticker[8] -port anomaly_ticker[8] -pin u_risk_layer anomaly_ticker[8]
load net anomaly_ticker[9] -attr @rip anomaly_ticker[9] -port anomaly_ticker[9] -pin u_risk_layer anomaly_ticker[9]
load net bank0_hit_out -pin u_parser_core bank0_hit_out -pin u_risk_layer bank0_hit
netloc bank0_hit_out 1 2 1 N 90
load net bank1_hit_out -pin u_parser_core bank1_hit_out -pin u_risk_layer bank1_hit
netloc bank1_hit_out 1 2 1 N 110
load net bank2_hit_out -pin u_parser_core bank2_hit_out -pin u_risk_layer bank2_hit
netloc bank2_hit_out 1 2 1 N 130
load net bank3_hit_out -pin u_parser_core bank3_hit_out -pin u_risk_layer bank3_hit
netloc bank3_hit_out 1 2 1 N 150
load net clk -port clk -pin u_config_controller clk -pin u_observer_layer clk -pin u_parser_core clk -pin u_risk_layer clk
netloc clk 1 0 3 20 10 450 30 850
load net dram_wr_addr[0] -attr @rip dram_wr_addr[0] -pin u_config_controller dram_wr_addr[0] -pin u_parser_core dram_wr_addr[0]
load net dram_wr_addr[1] -attr @rip dram_wr_addr[1] -pin u_config_controller dram_wr_addr[1] -pin u_parser_core dram_wr_addr[1]
load net dram_wr_addr[2] -attr @rip dram_wr_addr[2] -pin u_config_controller dram_wr_addr[2] -pin u_parser_core dram_wr_addr[2]
load net dram_wr_addr[3] -attr @rip dram_wr_addr[3] -pin u_config_controller dram_wr_addr[3] -pin u_parser_core dram_wr_addr[3]
load net dram_wr_addr[4] -attr @rip dram_wr_addr[4] -pin u_config_controller dram_wr_addr[4] -pin u_parser_core dram_wr_addr[4]
load net dram_wr_addr[5] -attr @rip dram_wr_addr[5] -pin u_config_controller dram_wr_addr[5] -pin u_parser_core dram_wr_addr[5]
load net dram_wr_bank[0] -attr @rip dram_wr_bank[0] -pin u_config_controller dram_wr_bank[0] -pin u_parser_core dram_wr_bank[0]
load net dram_wr_bank[1] -attr @rip dram_wr_bank[1] -pin u_config_controller dram_wr_bank[1] -pin u_parser_core dram_wr_bank[1]
load net dram_wr_data[0] -attr @rip dram_wr_data[0] -pin u_config_controller dram_wr_data[0] -pin u_parser_core dram_wr_data[0]
load net dram_wr_data[10] -attr @rip dram_wr_data[10] -pin u_config_controller dram_wr_data[10] -pin u_parser_core dram_wr_data[10]
load net dram_wr_data[11] -attr @rip dram_wr_data[11] -pin u_config_controller dram_wr_data[11] -pin u_parser_core dram_wr_data[11]
load net dram_wr_data[12] -attr @rip dram_wr_data[12] -pin u_config_controller dram_wr_data[12] -pin u_parser_core dram_wr_data[12]
load net dram_wr_data[13] -attr @rip dram_wr_data[13] -pin u_config_controller dram_wr_data[13] -pin u_parser_core dram_wr_data[13]
load net dram_wr_data[14] -attr @rip dram_wr_data[14] -pin u_config_controller dram_wr_data[14] -pin u_parser_core dram_wr_data[14]
load net dram_wr_data[15] -attr @rip dram_wr_data[15] -pin u_config_controller dram_wr_data[15] -pin u_parser_core dram_wr_data[15]
load net dram_wr_data[16] -attr @rip dram_wr_data[16] -pin u_config_controller dram_wr_data[16] -pin u_parser_core dram_wr_data[16]
load net dram_wr_data[17] -attr @rip dram_wr_data[17] -pin u_config_controller dram_wr_data[17] -pin u_parser_core dram_wr_data[17]
load net dram_wr_data[18] -attr @rip dram_wr_data[18] -pin u_config_controller dram_wr_data[18] -pin u_parser_core dram_wr_data[18]
load net dram_wr_data[19] -attr @rip dram_wr_data[19] -pin u_config_controller dram_wr_data[19] -pin u_parser_core dram_wr_data[19]
load net dram_wr_data[1] -attr @rip dram_wr_data[1] -pin u_config_controller dram_wr_data[1] -pin u_parser_core dram_wr_data[1]
load net dram_wr_data[20] -attr @rip dram_wr_data[20] -pin u_config_controller dram_wr_data[20] -pin u_parser_core dram_wr_data[20]
load net dram_wr_data[21] -attr @rip dram_wr_data[21] -pin u_config_controller dram_wr_data[21] -pin u_parser_core dram_wr_data[21]
load net dram_wr_data[22] -attr @rip dram_wr_data[22] -pin u_config_controller dram_wr_data[22] -pin u_parser_core dram_wr_data[22]
load net dram_wr_data[23] -attr @rip dram_wr_data[23] -pin u_config_controller dram_wr_data[23] -pin u_parser_core dram_wr_data[23]
load net dram_wr_data[24] -attr @rip dram_wr_data[24] -pin u_config_controller dram_wr_data[24] -pin u_parser_core dram_wr_data[24]
load net dram_wr_data[25] -attr @rip dram_wr_data[25] -pin u_config_controller dram_wr_data[25] -pin u_parser_core dram_wr_data[25]
load net dram_wr_data[26] -attr @rip dram_wr_data[26] -pin u_config_controller dram_wr_data[26] -pin u_parser_core dram_wr_data[26]
load net dram_wr_data[27] -attr @rip dram_wr_data[27] -pin u_config_controller dram_wr_data[27] -pin u_parser_core dram_wr_data[27]
load net dram_wr_data[28] -attr @rip dram_wr_data[28] -pin u_config_controller dram_wr_data[28] -pin u_parser_core dram_wr_data[28]
load net dram_wr_data[29] -attr @rip dram_wr_data[29] -pin u_config_controller dram_wr_data[29] -pin u_parser_core dram_wr_data[29]
load net dram_wr_data[2] -attr @rip dram_wr_data[2] -pin u_config_controller dram_wr_data[2] -pin u_parser_core dram_wr_data[2]
load net dram_wr_data[30] -attr @rip dram_wr_data[30] -pin u_config_controller dram_wr_data[30] -pin u_parser_core dram_wr_data[30]
load net dram_wr_data[31] -attr @rip dram_wr_data[31] -pin u_config_controller dram_wr_data[31] -pin u_parser_core dram_wr_data[31]
load net dram_wr_data[32] -attr @rip dram_wr_data[32] -pin u_config_controller dram_wr_data[32] -pin u_parser_core dram_wr_data[32]
load net dram_wr_data[33] -attr @rip dram_wr_data[33] -pin u_config_controller dram_wr_data[33] -pin u_parser_core dram_wr_data[33]
load net dram_wr_data[34] -attr @rip dram_wr_data[34] -pin u_config_controller dram_wr_data[34] -pin u_parser_core dram_wr_data[34]
load net dram_wr_data[35] -attr @rip dram_wr_data[35] -pin u_config_controller dram_wr_data[35] -pin u_parser_core dram_wr_data[35]
load net dram_wr_data[36] -attr @rip dram_wr_data[36] -pin u_config_controller dram_wr_data[36] -pin u_parser_core dram_wr_data[36]
load net dram_wr_data[37] -attr @rip dram_wr_data[37] -pin u_config_controller dram_wr_data[37] -pin u_parser_core dram_wr_data[37]
load net dram_wr_data[38] -attr @rip dram_wr_data[38] -pin u_config_controller dram_wr_data[38] -pin u_parser_core dram_wr_data[38]
load net dram_wr_data[39] -attr @rip dram_wr_data[39] -pin u_config_controller dram_wr_data[39] -pin u_parser_core dram_wr_data[39]
load net dram_wr_data[3] -attr @rip dram_wr_data[3] -pin u_config_controller dram_wr_data[3] -pin u_parser_core dram_wr_data[3]
load net dram_wr_data[40] -attr @rip dram_wr_data[40] -pin u_config_controller dram_wr_data[40] -pin u_parser_core dram_wr_data[40]
load net dram_wr_data[41] -attr @rip dram_wr_data[41] -pin u_config_controller dram_wr_data[41] -pin u_parser_core dram_wr_data[41]
load net dram_wr_data[42] -attr @rip dram_wr_data[42] -pin u_config_controller dram_wr_data[42] -pin u_parser_core dram_wr_data[42]
load net dram_wr_data[43] -attr @rip dram_wr_data[43] -pin u_config_controller dram_wr_data[43] -pin u_parser_core dram_wr_data[43]
load net dram_wr_data[44] -attr @rip dram_wr_data[44] -pin u_config_controller dram_wr_data[44] -pin u_parser_core dram_wr_data[44]
load net dram_wr_data[45] -attr @rip dram_wr_data[45] -pin u_config_controller dram_wr_data[45] -pin u_parser_core dram_wr_data[45]
load net dram_wr_data[46] -attr @rip dram_wr_data[46] -pin u_config_controller dram_wr_data[46] -pin u_parser_core dram_wr_data[46]
load net dram_wr_data[47] -attr @rip dram_wr_data[47] -pin u_config_controller dram_wr_data[47] -pin u_parser_core dram_wr_data[47]
load net dram_wr_data[4] -attr @rip dram_wr_data[4] -pin u_config_controller dram_wr_data[4] -pin u_parser_core dram_wr_data[4]
load net dram_wr_data[5] -attr @rip dram_wr_data[5] -pin u_config_controller dram_wr_data[5] -pin u_parser_core dram_wr_data[5]
load net dram_wr_data[6] -attr @rip dram_wr_data[6] -pin u_config_controller dram_wr_data[6] -pin u_parser_core dram_wr_data[6]
load net dram_wr_data[7] -attr @rip dram_wr_data[7] -pin u_config_controller dram_wr_data[7] -pin u_parser_core dram_wr_data[7]
load net dram_wr_data[8] -attr @rip dram_wr_data[8] -pin u_config_controller dram_wr_data[8] -pin u_parser_core dram_wr_data[8]
load net dram_wr_data[9] -attr @rip dram_wr_data[9] -pin u_config_controller dram_wr_data[9] -pin u_parser_core dram_wr_data[9]
load net dram_wr_en -pin u_config_controller dram_wr_en -pin u_parser_core dram_wr_en
netloc dram_wr_en 1 1 1 370 130n
load net expected_seq[0] -attr @rip expected_seq[0] -port expected_seq[0] -pin u_risk_layer expected_seq[0]
load net expected_seq[10] -attr @rip expected_seq[10] -port expected_seq[10] -pin u_risk_layer expected_seq[10]
load net expected_seq[11] -attr @rip expected_seq[11] -port expected_seq[11] -pin u_risk_layer expected_seq[11]
load net expected_seq[12] -attr @rip expected_seq[12] -port expected_seq[12] -pin u_risk_layer expected_seq[12]
load net expected_seq[13] -attr @rip expected_seq[13] -port expected_seq[13] -pin u_risk_layer expected_seq[13]
load net expected_seq[14] -attr @rip expected_seq[14] -port expected_seq[14] -pin u_risk_layer expected_seq[14]
load net expected_seq[15] -attr @rip expected_seq[15] -port expected_seq[15] -pin u_risk_layer expected_seq[15]
load net expected_seq[1] -attr @rip expected_seq[1] -port expected_seq[1] -pin u_risk_layer expected_seq[1]
load net expected_seq[2] -attr @rip expected_seq[2] -port expected_seq[2] -pin u_risk_layer expected_seq[2]
load net expected_seq[3] -attr @rip expected_seq[3] -port expected_seq[3] -pin u_risk_layer expected_seq[3]
load net expected_seq[4] -attr @rip expected_seq[4] -port expected_seq[4] -pin u_risk_layer expected_seq[4]
load net expected_seq[5] -attr @rip expected_seq[5] -port expected_seq[5] -pin u_risk_layer expected_seq[5]
load net expected_seq[6] -attr @rip expected_seq[6] -port expected_seq[6] -pin u_risk_layer expected_seq[6]
load net expected_seq[7] -attr @rip expected_seq[7] -port expected_seq[7] -pin u_risk_layer expected_seq[7]
load net expected_seq[8] -attr @rip expected_seq[8] -port expected_seq[8] -pin u_risk_layer expected_seq[8]
load net expected_seq[9] -attr @rip expected_seq[9] -port expected_seq[9] -pin u_risk_layer expected_seq[9]
load net fsm_state_dbg[0] -attr @rip fsm_state_dbg[0] -port fsm_state_dbg[0] -pin u_parser_core fsm_state_dbg[0]
load net fsm_state_dbg[1] -attr @rip fsm_state_dbg[1] -port fsm_state_dbg[1] -pin u_parser_core fsm_state_dbg[1]
load net fsm_state_dbg[2] -attr @rip fsm_state_dbg[2] -port fsm_state_dbg[2] -pin u_parser_core fsm_state_dbg[2]
load net hash_idx_out[0] -attr @rip hash_idx_out[0] -pin u_parser_core hash_idx_out[0] -pin u_risk_layer hash_idx[0]
load net hash_idx_out[1] -attr @rip hash_idx_out[1] -pin u_parser_core hash_idx_out[1] -pin u_risk_layer hash_idx[1]
load net hash_idx_out[2] -attr @rip hash_idx_out[2] -pin u_parser_core hash_idx_out[2] -pin u_risk_layer hash_idx[2]
load net hash_idx_out[3] -attr @rip hash_idx_out[3] -pin u_parser_core hash_idx_out[3] -pin u_risk_layer hash_idx[3]
load net hash_idx_out[4] -attr @rip hash_idx_out[4] -pin u_parser_core hash_idx_out[4] -pin u_risk_layer hash_idx[4]
load net hash_idx_out[5] -attr @rip hash_idx_out[5] -pin u_parser_core hash_idx_out[5] -pin u_risk_layer hash_idx[5]
load net m_payload_data[0] -attr @rip m_payload_data[0] -port m_payload_data[0] -pin u_parser_core m_payload_data[0]
load net m_payload_data[100] -attr @rip m_payload_data[100] -port m_payload_data[100] -pin u_parser_core m_payload_data[100]
load net m_payload_data[101] -attr @rip m_payload_data[101] -port m_payload_data[101] -pin u_parser_core m_payload_data[101]
load net m_payload_data[102] -attr @rip m_payload_data[102] -port m_payload_data[102] -pin u_parser_core m_payload_data[102]
load net m_payload_data[103] -attr @rip m_payload_data[103] -port m_payload_data[103] -pin u_parser_core m_payload_data[103]
load net m_payload_data[104] -attr @rip m_payload_data[104] -port m_payload_data[104] -pin u_parser_core m_payload_data[104]
load net m_payload_data[105] -attr @rip m_payload_data[105] -port m_payload_data[105] -pin u_parser_core m_payload_data[105]
load net m_payload_data[106] -attr @rip m_payload_data[106] -port m_payload_data[106] -pin u_parser_core m_payload_data[106]
load net m_payload_data[107] -attr @rip m_payload_data[107] -port m_payload_data[107] -pin u_parser_core m_payload_data[107]
load net m_payload_data[108] -attr @rip m_payload_data[108] -port m_payload_data[108] -pin u_parser_core m_payload_data[108]
load net m_payload_data[109] -attr @rip m_payload_data[109] -port m_payload_data[109] -pin u_parser_core m_payload_data[109]
load net m_payload_data[10] -attr @rip m_payload_data[10] -port m_payload_data[10] -pin u_parser_core m_payload_data[10]
load net m_payload_data[110] -attr @rip m_payload_data[110] -port m_payload_data[110] -pin u_parser_core m_payload_data[110]
load net m_payload_data[111] -attr @rip m_payload_data[111] -port m_payload_data[111] -pin u_parser_core m_payload_data[111]
load net m_payload_data[112] -attr @rip m_payload_data[112] -port m_payload_data[112] -pin u_parser_core m_payload_data[112]
load net m_payload_data[113] -attr @rip m_payload_data[113] -port m_payload_data[113] -pin u_parser_core m_payload_data[113]
load net m_payload_data[114] -attr @rip m_payload_data[114] -port m_payload_data[114] -pin u_parser_core m_payload_data[114]
load net m_payload_data[115] -attr @rip m_payload_data[115] -port m_payload_data[115] -pin u_parser_core m_payload_data[115]
load net m_payload_data[116] -attr @rip m_payload_data[116] -port m_payload_data[116] -pin u_parser_core m_payload_data[116]
load net m_payload_data[117] -attr @rip m_payload_data[117] -port m_payload_data[117] -pin u_parser_core m_payload_data[117]
load net m_payload_data[118] -attr @rip m_payload_data[118] -port m_payload_data[118] -pin u_parser_core m_payload_data[118]
load net m_payload_data[119] -attr @rip m_payload_data[119] -port m_payload_data[119] -pin u_parser_core m_payload_data[119]
load net m_payload_data[11] -attr @rip m_payload_data[11] -port m_payload_data[11] -pin u_parser_core m_payload_data[11]
load net m_payload_data[120] -attr @rip m_payload_data[120] -port m_payload_data[120] -pin u_parser_core m_payload_data[120]
load net m_payload_data[121] -attr @rip m_payload_data[121] -port m_payload_data[121] -pin u_parser_core m_payload_data[121]
load net m_payload_data[122] -attr @rip m_payload_data[122] -port m_payload_data[122] -pin u_parser_core m_payload_data[122]
load net m_payload_data[123] -attr @rip m_payload_data[123] -port m_payload_data[123] -pin u_parser_core m_payload_data[123]
load net m_payload_data[124] -attr @rip m_payload_data[124] -port m_payload_data[124] -pin u_parser_core m_payload_data[124]
load net m_payload_data[125] -attr @rip m_payload_data[125] -port m_payload_data[125] -pin u_parser_core m_payload_data[125]
load net m_payload_data[126] -attr @rip m_payload_data[126] -port m_payload_data[126] -pin u_parser_core m_payload_data[126]
load net m_payload_data[127] -attr @rip m_payload_data[127] -port m_payload_data[127] -pin u_parser_core m_payload_data[127]
load net m_payload_data[12] -attr @rip m_payload_data[12] -port m_payload_data[12] -pin u_parser_core m_payload_data[12]
load net m_payload_data[13] -attr @rip m_payload_data[13] -port m_payload_data[13] -pin u_parser_core m_payload_data[13]
load net m_payload_data[14] -attr @rip m_payload_data[14] -port m_payload_data[14] -pin u_parser_core m_payload_data[14]
load net m_payload_data[15] -attr @rip m_payload_data[15] -port m_payload_data[15] -pin u_parser_core m_payload_data[15]
load net m_payload_data[16] -attr @rip m_payload_data[16] -port m_payload_data[16] -pin u_parser_core m_payload_data[16]
load net m_payload_data[17] -attr @rip m_payload_data[17] -port m_payload_data[17] -pin u_parser_core m_payload_data[17]
load net m_payload_data[18] -attr @rip m_payload_data[18] -port m_payload_data[18] -pin u_parser_core m_payload_data[18]
load net m_payload_data[19] -attr @rip m_payload_data[19] -port m_payload_data[19] -pin u_parser_core m_payload_data[19]
load net m_payload_data[1] -attr @rip m_payload_data[1] -port m_payload_data[1] -pin u_parser_core m_payload_data[1]
load net m_payload_data[20] -attr @rip m_payload_data[20] -port m_payload_data[20] -pin u_parser_core m_payload_data[20]
load net m_payload_data[21] -attr @rip m_payload_data[21] -port m_payload_data[21] -pin u_parser_core m_payload_data[21]
load net m_payload_data[22] -attr @rip m_payload_data[22] -port m_payload_data[22] -pin u_parser_core m_payload_data[22]
load net m_payload_data[23] -attr @rip m_payload_data[23] -port m_payload_data[23] -pin u_parser_core m_payload_data[23]
load net m_payload_data[24] -attr @rip m_payload_data[24] -port m_payload_data[24] -pin u_parser_core m_payload_data[24]
load net m_payload_data[25] -attr @rip m_payload_data[25] -port m_payload_data[25] -pin u_parser_core m_payload_data[25]
load net m_payload_data[26] -attr @rip m_payload_data[26] -port m_payload_data[26] -pin u_parser_core m_payload_data[26]
load net m_payload_data[27] -attr @rip m_payload_data[27] -port m_payload_data[27] -pin u_parser_core m_payload_data[27]
load net m_payload_data[28] -attr @rip m_payload_data[28] -port m_payload_data[28] -pin u_parser_core m_payload_data[28]
load net m_payload_data[29] -attr @rip m_payload_data[29] -port m_payload_data[29] -pin u_parser_core m_payload_data[29]
load net m_payload_data[2] -attr @rip m_payload_data[2] -port m_payload_data[2] -pin u_parser_core m_payload_data[2]
load net m_payload_data[30] -attr @rip m_payload_data[30] -port m_payload_data[30] -pin u_parser_core m_payload_data[30]
load net m_payload_data[31] -attr @rip m_payload_data[31] -port m_payload_data[31] -pin u_parser_core m_payload_data[31]
load net m_payload_data[32] -attr @rip m_payload_data[32] -port m_payload_data[32] -pin u_parser_core m_payload_data[32]
load net m_payload_data[33] -attr @rip m_payload_data[33] -port m_payload_data[33] -pin u_parser_core m_payload_data[33]
load net m_payload_data[34] -attr @rip m_payload_data[34] -port m_payload_data[34] -pin u_parser_core m_payload_data[34]
load net m_payload_data[35] -attr @rip m_payload_data[35] -port m_payload_data[35] -pin u_parser_core m_payload_data[35]
load net m_payload_data[36] -attr @rip m_payload_data[36] -port m_payload_data[36] -pin u_parser_core m_payload_data[36]
load net m_payload_data[37] -attr @rip m_payload_data[37] -port m_payload_data[37] -pin u_parser_core m_payload_data[37]
load net m_payload_data[38] -attr @rip m_payload_data[38] -port m_payload_data[38] -pin u_parser_core m_payload_data[38]
load net m_payload_data[39] -attr @rip m_payload_data[39] -port m_payload_data[39] -pin u_parser_core m_payload_data[39]
load net m_payload_data[3] -attr @rip m_payload_data[3] -port m_payload_data[3] -pin u_parser_core m_payload_data[3]
load net m_payload_data[40] -attr @rip m_payload_data[40] -port m_payload_data[40] -pin u_parser_core m_payload_data[40]
load net m_payload_data[41] -attr @rip m_payload_data[41] -port m_payload_data[41] -pin u_parser_core m_payload_data[41]
load net m_payload_data[42] -attr @rip m_payload_data[42] -port m_payload_data[42] -pin u_parser_core m_payload_data[42]
load net m_payload_data[43] -attr @rip m_payload_data[43] -port m_payload_data[43] -pin u_parser_core m_payload_data[43]
load net m_payload_data[44] -attr @rip m_payload_data[44] -port m_payload_data[44] -pin u_parser_core m_payload_data[44]
load net m_payload_data[45] -attr @rip m_payload_data[45] -port m_payload_data[45] -pin u_parser_core m_payload_data[45]
load net m_payload_data[46] -attr @rip m_payload_data[46] -port m_payload_data[46] -pin u_parser_core m_payload_data[46]
load net m_payload_data[47] -attr @rip m_payload_data[47] -port m_payload_data[47] -pin u_parser_core m_payload_data[47]
load net m_payload_data[48] -attr @rip m_payload_data[48] -port m_payload_data[48] -pin u_parser_core m_payload_data[48]
load net m_payload_data[49] -attr @rip m_payload_data[49] -port m_payload_data[49] -pin u_parser_core m_payload_data[49]
load net m_payload_data[4] -attr @rip m_payload_data[4] -port m_payload_data[4] -pin u_parser_core m_payload_data[4]
load net m_payload_data[50] -attr @rip m_payload_data[50] -port m_payload_data[50] -pin u_parser_core m_payload_data[50]
load net m_payload_data[51] -attr @rip m_payload_data[51] -port m_payload_data[51] -pin u_parser_core m_payload_data[51]
load net m_payload_data[52] -attr @rip m_payload_data[52] -port m_payload_data[52] -pin u_parser_core m_payload_data[52]
load net m_payload_data[53] -attr @rip m_payload_data[53] -port m_payload_data[53] -pin u_parser_core m_payload_data[53]
load net m_payload_data[54] -attr @rip m_payload_data[54] -port m_payload_data[54] -pin u_parser_core m_payload_data[54]
load net m_payload_data[55] -attr @rip m_payload_data[55] -port m_payload_data[55] -pin u_parser_core m_payload_data[55]
load net m_payload_data[56] -attr @rip m_payload_data[56] -port m_payload_data[56] -pin u_parser_core m_payload_data[56]
load net m_payload_data[57] -attr @rip m_payload_data[57] -port m_payload_data[57] -pin u_parser_core m_payload_data[57]
load net m_payload_data[58] -attr @rip m_payload_data[58] -port m_payload_data[58] -pin u_parser_core m_payload_data[58]
load net m_payload_data[59] -attr @rip m_payload_data[59] -port m_payload_data[59] -pin u_parser_core m_payload_data[59]
load net m_payload_data[5] -attr @rip m_payload_data[5] -port m_payload_data[5] -pin u_parser_core m_payload_data[5]
load net m_payload_data[60] -attr @rip m_payload_data[60] -port m_payload_data[60] -pin u_parser_core m_payload_data[60]
load net m_payload_data[61] -attr @rip m_payload_data[61] -port m_payload_data[61] -pin u_parser_core m_payload_data[61]
load net m_payload_data[62] -attr @rip m_payload_data[62] -port m_payload_data[62] -pin u_parser_core m_payload_data[62]
load net m_payload_data[63] -attr @rip m_payload_data[63] -port m_payload_data[63] -pin u_parser_core m_payload_data[63]
load net m_payload_data[64] -attr @rip m_payload_data[64] -port m_payload_data[64] -pin u_parser_core m_payload_data[64]
load net m_payload_data[65] -attr @rip m_payload_data[65] -port m_payload_data[65] -pin u_parser_core m_payload_data[65]
load net m_payload_data[66] -attr @rip m_payload_data[66] -port m_payload_data[66] -pin u_parser_core m_payload_data[66]
load net m_payload_data[67] -attr @rip m_payload_data[67] -port m_payload_data[67] -pin u_parser_core m_payload_data[67]
load net m_payload_data[68] -attr @rip m_payload_data[68] -port m_payload_data[68] -pin u_parser_core m_payload_data[68]
load net m_payload_data[69] -attr @rip m_payload_data[69] -port m_payload_data[69] -pin u_parser_core m_payload_data[69]
load net m_payload_data[6] -attr @rip m_payload_data[6] -port m_payload_data[6] -pin u_parser_core m_payload_data[6]
load net m_payload_data[70] -attr @rip m_payload_data[70] -port m_payload_data[70] -pin u_parser_core m_payload_data[70]
load net m_payload_data[71] -attr @rip m_payload_data[71] -port m_payload_data[71] -pin u_parser_core m_payload_data[71]
load net m_payload_data[72] -attr @rip m_payload_data[72] -port m_payload_data[72] -pin u_parser_core m_payload_data[72]
load net m_payload_data[73] -attr @rip m_payload_data[73] -port m_payload_data[73] -pin u_parser_core m_payload_data[73]
load net m_payload_data[74] -attr @rip m_payload_data[74] -port m_payload_data[74] -pin u_parser_core m_payload_data[74]
load net m_payload_data[75] -attr @rip m_payload_data[75] -port m_payload_data[75] -pin u_parser_core m_payload_data[75]
load net m_payload_data[76] -attr @rip m_payload_data[76] -port m_payload_data[76] -pin u_parser_core m_payload_data[76]
load net m_payload_data[77] -attr @rip m_payload_data[77] -port m_payload_data[77] -pin u_parser_core m_payload_data[77]
load net m_payload_data[78] -attr @rip m_payload_data[78] -port m_payload_data[78] -pin u_parser_core m_payload_data[78]
load net m_payload_data[79] -attr @rip m_payload_data[79] -port m_payload_data[79] -pin u_parser_core m_payload_data[79]
load net m_payload_data[7] -attr @rip m_payload_data[7] -port m_payload_data[7] -pin u_parser_core m_payload_data[7]
load net m_payload_data[80] -attr @rip m_payload_data[80] -port m_payload_data[80] -pin u_parser_core m_payload_data[80]
load net m_payload_data[81] -attr @rip m_payload_data[81] -port m_payload_data[81] -pin u_parser_core m_payload_data[81]
load net m_payload_data[82] -attr @rip m_payload_data[82] -port m_payload_data[82] -pin u_parser_core m_payload_data[82]
load net m_payload_data[83] -attr @rip m_payload_data[83] -port m_payload_data[83] -pin u_parser_core m_payload_data[83]
load net m_payload_data[84] -attr @rip m_payload_data[84] -port m_payload_data[84] -pin u_parser_core m_payload_data[84]
load net m_payload_data[85] -attr @rip m_payload_data[85] -port m_payload_data[85] -pin u_parser_core m_payload_data[85]
load net m_payload_data[86] -attr @rip m_payload_data[86] -port m_payload_data[86] -pin u_parser_core m_payload_data[86]
load net m_payload_data[87] -attr @rip m_payload_data[87] -port m_payload_data[87] -pin u_parser_core m_payload_data[87]
load net m_payload_data[88] -attr @rip m_payload_data[88] -port m_payload_data[88] -pin u_parser_core m_payload_data[88]
load net m_payload_data[89] -attr @rip m_payload_data[89] -port m_payload_data[89] -pin u_parser_core m_payload_data[89]
load net m_payload_data[8] -attr @rip m_payload_data[8] -port m_payload_data[8] -pin u_parser_core m_payload_data[8]
load net m_payload_data[90] -attr @rip m_payload_data[90] -port m_payload_data[90] -pin u_parser_core m_payload_data[90]
load net m_payload_data[91] -attr @rip m_payload_data[91] -port m_payload_data[91] -pin u_parser_core m_payload_data[91]
load net m_payload_data[92] -attr @rip m_payload_data[92] -port m_payload_data[92] -pin u_parser_core m_payload_data[92]
load net m_payload_data[93] -attr @rip m_payload_data[93] -port m_payload_data[93] -pin u_parser_core m_payload_data[93]
load net m_payload_data[94] -attr @rip m_payload_data[94] -port m_payload_data[94] -pin u_parser_core m_payload_data[94]
load net m_payload_data[95] -attr @rip m_payload_data[95] -port m_payload_data[95] -pin u_parser_core m_payload_data[95]
load net m_payload_data[96] -attr @rip m_payload_data[96] -port m_payload_data[96] -pin u_parser_core m_payload_data[96]
load net m_payload_data[97] -attr @rip m_payload_data[97] -port m_payload_data[97] -pin u_parser_core m_payload_data[97]
load net m_payload_data[98] -attr @rip m_payload_data[98] -port m_payload_data[98] -pin u_parser_core m_payload_data[98]
load net m_payload_data[99] -attr @rip m_payload_data[99] -port m_payload_data[99] -pin u_parser_core m_payload_data[99]
load net m_payload_data[9] -attr @rip m_payload_data[9] -port m_payload_data[9] -pin u_parser_core m_payload_data[9]
load net m_payload_valid -port m_payload_valid -pin u_parser_core m_payload_valid
netloc m_payload_valid 1 2 2 830J 330 NJ
load net m_timestamp[0] -attr @rip m_timestamp[0] -port m_timestamp[0] -pin u_observer_layer m_timestamp[0]
load net m_timestamp[10] -attr @rip m_timestamp[10] -port m_timestamp[10] -pin u_observer_layer m_timestamp[10]
load net m_timestamp[11] -attr @rip m_timestamp[11] -port m_timestamp[11] -pin u_observer_layer m_timestamp[11]
load net m_timestamp[12] -attr @rip m_timestamp[12] -port m_timestamp[12] -pin u_observer_layer m_timestamp[12]
load net m_timestamp[13] -attr @rip m_timestamp[13] -port m_timestamp[13] -pin u_observer_layer m_timestamp[13]
load net m_timestamp[14] -attr @rip m_timestamp[14] -port m_timestamp[14] -pin u_observer_layer m_timestamp[14]
load net m_timestamp[15] -attr @rip m_timestamp[15] -port m_timestamp[15] -pin u_observer_layer m_timestamp[15]
load net m_timestamp[16] -attr @rip m_timestamp[16] -port m_timestamp[16] -pin u_observer_layer m_timestamp[16]
load net m_timestamp[17] -attr @rip m_timestamp[17] -port m_timestamp[17] -pin u_observer_layer m_timestamp[17]
load net m_timestamp[18] -attr @rip m_timestamp[18] -port m_timestamp[18] -pin u_observer_layer m_timestamp[18]
load net m_timestamp[19] -attr @rip m_timestamp[19] -port m_timestamp[19] -pin u_observer_layer m_timestamp[19]
load net m_timestamp[1] -attr @rip m_timestamp[1] -port m_timestamp[1] -pin u_observer_layer m_timestamp[1]
load net m_timestamp[20] -attr @rip m_timestamp[20] -port m_timestamp[20] -pin u_observer_layer m_timestamp[20]
load net m_timestamp[21] -attr @rip m_timestamp[21] -port m_timestamp[21] -pin u_observer_layer m_timestamp[21]
load net m_timestamp[22] -attr @rip m_timestamp[22] -port m_timestamp[22] -pin u_observer_layer m_timestamp[22]
load net m_timestamp[23] -attr @rip m_timestamp[23] -port m_timestamp[23] -pin u_observer_layer m_timestamp[23]
load net m_timestamp[24] -attr @rip m_timestamp[24] -port m_timestamp[24] -pin u_observer_layer m_timestamp[24]
load net m_timestamp[25] -attr @rip m_timestamp[25] -port m_timestamp[25] -pin u_observer_layer m_timestamp[25]
load net m_timestamp[26] -attr @rip m_timestamp[26] -port m_timestamp[26] -pin u_observer_layer m_timestamp[26]
load net m_timestamp[27] -attr @rip m_timestamp[27] -port m_timestamp[27] -pin u_observer_layer m_timestamp[27]
load net m_timestamp[28] -attr @rip m_timestamp[28] -port m_timestamp[28] -pin u_observer_layer m_timestamp[28]
load net m_timestamp[29] -attr @rip m_timestamp[29] -port m_timestamp[29] -pin u_observer_layer m_timestamp[29]
load net m_timestamp[2] -attr @rip m_timestamp[2] -port m_timestamp[2] -pin u_observer_layer m_timestamp[2]
load net m_timestamp[30] -attr @rip m_timestamp[30] -port m_timestamp[30] -pin u_observer_layer m_timestamp[30]
load net m_timestamp[31] -attr @rip m_timestamp[31] -port m_timestamp[31] -pin u_observer_layer m_timestamp[31]
load net m_timestamp[32] -attr @rip m_timestamp[32] -port m_timestamp[32] -pin u_observer_layer m_timestamp[32]
load net m_timestamp[33] -attr @rip m_timestamp[33] -port m_timestamp[33] -pin u_observer_layer m_timestamp[33]
load net m_timestamp[34] -attr @rip m_timestamp[34] -port m_timestamp[34] -pin u_observer_layer m_timestamp[34]
load net m_timestamp[35] -attr @rip m_timestamp[35] -port m_timestamp[35] -pin u_observer_layer m_timestamp[35]
load net m_timestamp[36] -attr @rip m_timestamp[36] -port m_timestamp[36] -pin u_observer_layer m_timestamp[36]
load net m_timestamp[37] -attr @rip m_timestamp[37] -port m_timestamp[37] -pin u_observer_layer m_timestamp[37]
load net m_timestamp[38] -attr @rip m_timestamp[38] -port m_timestamp[38] -pin u_observer_layer m_timestamp[38]
load net m_timestamp[39] -attr @rip m_timestamp[39] -port m_timestamp[39] -pin u_observer_layer m_timestamp[39]
load net m_timestamp[3] -attr @rip m_timestamp[3] -port m_timestamp[3] -pin u_observer_layer m_timestamp[3]
load net m_timestamp[40] -attr @rip m_timestamp[40] -port m_timestamp[40] -pin u_observer_layer m_timestamp[40]
load net m_timestamp[41] -attr @rip m_timestamp[41] -port m_timestamp[41] -pin u_observer_layer m_timestamp[41]
load net m_timestamp[42] -attr @rip m_timestamp[42] -port m_timestamp[42] -pin u_observer_layer m_timestamp[42]
load net m_timestamp[43] -attr @rip m_timestamp[43] -port m_timestamp[43] -pin u_observer_layer m_timestamp[43]
load net m_timestamp[44] -attr @rip m_timestamp[44] -port m_timestamp[44] -pin u_observer_layer m_timestamp[44]
load net m_timestamp[45] -attr @rip m_timestamp[45] -port m_timestamp[45] -pin u_observer_layer m_timestamp[45]
load net m_timestamp[46] -attr @rip m_timestamp[46] -port m_timestamp[46] -pin u_observer_layer m_timestamp[46]
load net m_timestamp[47] -attr @rip m_timestamp[47] -port m_timestamp[47] -pin u_observer_layer m_timestamp[47]
load net m_timestamp[48] -attr @rip m_timestamp[48] -port m_timestamp[48] -pin u_observer_layer m_timestamp[48]
load net m_timestamp[49] -attr @rip m_timestamp[49] -port m_timestamp[49] -pin u_observer_layer m_timestamp[49]
load net m_timestamp[4] -attr @rip m_timestamp[4] -port m_timestamp[4] -pin u_observer_layer m_timestamp[4]
load net m_timestamp[50] -attr @rip m_timestamp[50] -port m_timestamp[50] -pin u_observer_layer m_timestamp[50]
load net m_timestamp[51] -attr @rip m_timestamp[51] -port m_timestamp[51] -pin u_observer_layer m_timestamp[51]
load net m_timestamp[52] -attr @rip m_timestamp[52] -port m_timestamp[52] -pin u_observer_layer m_timestamp[52]
load net m_timestamp[53] -attr @rip m_timestamp[53] -port m_timestamp[53] -pin u_observer_layer m_timestamp[53]
load net m_timestamp[54] -attr @rip m_timestamp[54] -port m_timestamp[54] -pin u_observer_layer m_timestamp[54]
load net m_timestamp[55] -attr @rip m_timestamp[55] -port m_timestamp[55] -pin u_observer_layer m_timestamp[55]
load net m_timestamp[56] -attr @rip m_timestamp[56] -port m_timestamp[56] -pin u_observer_layer m_timestamp[56]
load net m_timestamp[57] -attr @rip m_timestamp[57] -port m_timestamp[57] -pin u_observer_layer m_timestamp[57]
load net m_timestamp[58] -attr @rip m_timestamp[58] -port m_timestamp[58] -pin u_observer_layer m_timestamp[58]
load net m_timestamp[59] -attr @rip m_timestamp[59] -port m_timestamp[59] -pin u_observer_layer m_timestamp[59]
load net m_timestamp[5] -attr @rip m_timestamp[5] -port m_timestamp[5] -pin u_observer_layer m_timestamp[5]
load net m_timestamp[60] -attr @rip m_timestamp[60] -port m_timestamp[60] -pin u_observer_layer m_timestamp[60]
load net m_timestamp[61] -attr @rip m_timestamp[61] -port m_timestamp[61] -pin u_observer_layer m_timestamp[61]
load net m_timestamp[62] -attr @rip m_timestamp[62] -port m_timestamp[62] -pin u_observer_layer m_timestamp[62]
load net m_timestamp[63] -attr @rip m_timestamp[63] -port m_timestamp[63] -pin u_observer_layer m_timestamp[63]
load net m_timestamp[6] -attr @rip m_timestamp[6] -port m_timestamp[6] -pin u_observer_layer m_timestamp[6]
load net m_timestamp[7] -attr @rip m_timestamp[7] -port m_timestamp[7] -pin u_observer_layer m_timestamp[7]
load net m_timestamp[8] -attr @rip m_timestamp[8] -port m_timestamp[8] -pin u_observer_layer m_timestamp[8]
load net m_timestamp[9] -attr @rip m_timestamp[9] -port m_timestamp[9] -pin u_observer_layer m_timestamp[9]
load net match_found_pulse -pin u_observer_layer match_found -pin u_parser_core match_found_pulse -pin u_risk_layer match_found
netloc match_found_pulse 1 2 1 870 210n
load net received_seq[0] -attr @rip received_seq[0] -port received_seq[0] -pin u_risk_layer received_seq[0]
load net received_seq[10] -attr @rip received_seq[10] -port received_seq[10] -pin u_risk_layer received_seq[10]
load net received_seq[11] -attr @rip received_seq[11] -port received_seq[11] -pin u_risk_layer received_seq[11]
load net received_seq[12] -attr @rip received_seq[12] -port received_seq[12] -pin u_risk_layer received_seq[12]
load net received_seq[13] -attr @rip received_seq[13] -port received_seq[13] -pin u_risk_layer received_seq[13]
load net received_seq[14] -attr @rip received_seq[14] -port received_seq[14] -pin u_risk_layer received_seq[14]
load net received_seq[15] -attr @rip received_seq[15] -port received_seq[15] -pin u_risk_layer received_seq[15]
load net received_seq[1] -attr @rip received_seq[1] -port received_seq[1] -pin u_risk_layer received_seq[1]
load net received_seq[2] -attr @rip received_seq[2] -port received_seq[2] -pin u_risk_layer received_seq[2]
load net received_seq[3] -attr @rip received_seq[3] -port received_seq[3] -pin u_risk_layer received_seq[3]
load net received_seq[4] -attr @rip received_seq[4] -port received_seq[4] -pin u_risk_layer received_seq[4]
load net received_seq[5] -attr @rip received_seq[5] -port received_seq[5] -pin u_risk_layer received_seq[5]
load net received_seq[6] -attr @rip received_seq[6] -port received_seq[6] -pin u_risk_layer received_seq[6]
load net received_seq[7] -attr @rip received_seq[7] -port received_seq[7] -pin u_risk_layer received_seq[7]
load net received_seq[8] -attr @rip received_seq[8] -port received_seq[8] -pin u_risk_layer received_seq[8]
load net received_seq[9] -attr @rip received_seq[9] -port received_seq[9] -pin u_risk_layer received_seq[9]
load net reset_n -port reset_n -pin u_config_controller reset_n -pin u_observer_layer reset_n -pin u_parser_core reset_n -pin u_risk_layer reset_n
netloc reset_n 1 0 3 20 210 450 350 910
load net s_axis_tdata[0] -attr @rip s_axis_tdata[0] -port s_axis_tdata[0] -pin u_parser_core s_axis_tdata[0]
load net s_axis_tdata[100] -attr @rip s_axis_tdata[100] -port s_axis_tdata[100] -pin u_parser_core s_axis_tdata[100]
load net s_axis_tdata[101] -attr @rip s_axis_tdata[101] -port s_axis_tdata[101] -pin u_parser_core s_axis_tdata[101]
load net s_axis_tdata[102] -attr @rip s_axis_tdata[102] -port s_axis_tdata[102] -pin u_parser_core s_axis_tdata[102]
load net s_axis_tdata[103] -attr @rip s_axis_tdata[103] -port s_axis_tdata[103] -pin u_parser_core s_axis_tdata[103]
load net s_axis_tdata[104] -attr @rip s_axis_tdata[104] -port s_axis_tdata[104] -pin u_parser_core s_axis_tdata[104]
load net s_axis_tdata[105] -attr @rip s_axis_tdata[105] -port s_axis_tdata[105] -pin u_parser_core s_axis_tdata[105]
load net s_axis_tdata[106] -attr @rip s_axis_tdata[106] -port s_axis_tdata[106] -pin u_parser_core s_axis_tdata[106]
load net s_axis_tdata[107] -attr @rip s_axis_tdata[107] -port s_axis_tdata[107] -pin u_parser_core s_axis_tdata[107]
load net s_axis_tdata[108] -attr @rip s_axis_tdata[108] -port s_axis_tdata[108] -pin u_parser_core s_axis_tdata[108]
load net s_axis_tdata[109] -attr @rip s_axis_tdata[109] -port s_axis_tdata[109] -pin u_parser_core s_axis_tdata[109]
load net s_axis_tdata[10] -attr @rip s_axis_tdata[10] -port s_axis_tdata[10] -pin u_parser_core s_axis_tdata[10]
load net s_axis_tdata[110] -attr @rip s_axis_tdata[110] -port s_axis_tdata[110] -pin u_parser_core s_axis_tdata[110]
load net s_axis_tdata[111] -attr @rip s_axis_tdata[111] -port s_axis_tdata[111] -pin u_parser_core s_axis_tdata[111]
load net s_axis_tdata[112] -attr @rip s_axis_tdata[112] -port s_axis_tdata[112] -pin u_parser_core s_axis_tdata[112]
load net s_axis_tdata[113] -attr @rip s_axis_tdata[113] -port s_axis_tdata[113] -pin u_parser_core s_axis_tdata[113]
load net s_axis_tdata[114] -attr @rip s_axis_tdata[114] -port s_axis_tdata[114] -pin u_parser_core s_axis_tdata[114]
load net s_axis_tdata[115] -attr @rip s_axis_tdata[115] -port s_axis_tdata[115] -pin u_parser_core s_axis_tdata[115]
load net s_axis_tdata[116] -attr @rip s_axis_tdata[116] -port s_axis_tdata[116] -pin u_parser_core s_axis_tdata[116]
load net s_axis_tdata[117] -attr @rip s_axis_tdata[117] -port s_axis_tdata[117] -pin u_parser_core s_axis_tdata[117]
load net s_axis_tdata[118] -attr @rip s_axis_tdata[118] -port s_axis_tdata[118] -pin u_parser_core s_axis_tdata[118]
load net s_axis_tdata[119] -attr @rip s_axis_tdata[119] -port s_axis_tdata[119] -pin u_parser_core s_axis_tdata[119]
load net s_axis_tdata[11] -attr @rip s_axis_tdata[11] -port s_axis_tdata[11] -pin u_parser_core s_axis_tdata[11]
load net s_axis_tdata[120] -attr @rip s_axis_tdata[120] -port s_axis_tdata[120] -pin u_parser_core s_axis_tdata[120]
load net s_axis_tdata[121] -attr @rip s_axis_tdata[121] -port s_axis_tdata[121] -pin u_parser_core s_axis_tdata[121]
load net s_axis_tdata[122] -attr @rip s_axis_tdata[122] -port s_axis_tdata[122] -pin u_parser_core s_axis_tdata[122]
load net s_axis_tdata[123] -attr @rip s_axis_tdata[123] -port s_axis_tdata[123] -pin u_parser_core s_axis_tdata[123]
load net s_axis_tdata[124] -attr @rip s_axis_tdata[124] -port s_axis_tdata[124] -pin u_parser_core s_axis_tdata[124]
load net s_axis_tdata[125] -attr @rip s_axis_tdata[125] -port s_axis_tdata[125] -pin u_parser_core s_axis_tdata[125]
load net s_axis_tdata[126] -attr @rip s_axis_tdata[126] -port s_axis_tdata[126] -pin u_parser_core s_axis_tdata[126]
load net s_axis_tdata[127] -attr @rip s_axis_tdata[127] -port s_axis_tdata[127] -pin u_parser_core s_axis_tdata[127]
load net s_axis_tdata[12] -attr @rip s_axis_tdata[12] -port s_axis_tdata[12] -pin u_parser_core s_axis_tdata[12]
load net s_axis_tdata[13] -attr @rip s_axis_tdata[13] -port s_axis_tdata[13] -pin u_parser_core s_axis_tdata[13]
load net s_axis_tdata[14] -attr @rip s_axis_tdata[14] -port s_axis_tdata[14] -pin u_parser_core s_axis_tdata[14]
load net s_axis_tdata[15] -attr @rip s_axis_tdata[15] -port s_axis_tdata[15] -pin u_parser_core s_axis_tdata[15]
load net s_axis_tdata[16] -attr @rip s_axis_tdata[16] -port s_axis_tdata[16] -pin u_parser_core s_axis_tdata[16]
load net s_axis_tdata[17] -attr @rip s_axis_tdata[17] -port s_axis_tdata[17] -pin u_parser_core s_axis_tdata[17]
load net s_axis_tdata[18] -attr @rip s_axis_tdata[18] -port s_axis_tdata[18] -pin u_parser_core s_axis_tdata[18]
load net s_axis_tdata[19] -attr @rip s_axis_tdata[19] -port s_axis_tdata[19] -pin u_parser_core s_axis_tdata[19]
load net s_axis_tdata[1] -attr @rip s_axis_tdata[1] -port s_axis_tdata[1] -pin u_parser_core s_axis_tdata[1]
load net s_axis_tdata[20] -attr @rip s_axis_tdata[20] -port s_axis_tdata[20] -pin u_parser_core s_axis_tdata[20]
load net s_axis_tdata[21] -attr @rip s_axis_tdata[21] -port s_axis_tdata[21] -pin u_parser_core s_axis_tdata[21]
load net s_axis_tdata[22] -attr @rip s_axis_tdata[22] -port s_axis_tdata[22] -pin u_parser_core s_axis_tdata[22]
load net s_axis_tdata[23] -attr @rip s_axis_tdata[23] -port s_axis_tdata[23] -pin u_parser_core s_axis_tdata[23]
load net s_axis_tdata[24] -attr @rip s_axis_tdata[24] -port s_axis_tdata[24] -pin u_parser_core s_axis_tdata[24]
load net s_axis_tdata[25] -attr @rip s_axis_tdata[25] -port s_axis_tdata[25] -pin u_parser_core s_axis_tdata[25]
load net s_axis_tdata[26] -attr @rip s_axis_tdata[26] -port s_axis_tdata[26] -pin u_parser_core s_axis_tdata[26]
load net s_axis_tdata[27] -attr @rip s_axis_tdata[27] -port s_axis_tdata[27] -pin u_parser_core s_axis_tdata[27]
load net s_axis_tdata[28] -attr @rip s_axis_tdata[28] -port s_axis_tdata[28] -pin u_parser_core s_axis_tdata[28]
load net s_axis_tdata[29] -attr @rip s_axis_tdata[29] -port s_axis_tdata[29] -pin u_parser_core s_axis_tdata[29]
load net s_axis_tdata[2] -attr @rip s_axis_tdata[2] -port s_axis_tdata[2] -pin u_parser_core s_axis_tdata[2]
load net s_axis_tdata[30] -attr @rip s_axis_tdata[30] -port s_axis_tdata[30] -pin u_parser_core s_axis_tdata[30]
load net s_axis_tdata[31] -attr @rip s_axis_tdata[31] -port s_axis_tdata[31] -pin u_parser_core s_axis_tdata[31]
load net s_axis_tdata[32] -attr @rip s_axis_tdata[32] -port s_axis_tdata[32] -pin u_parser_core s_axis_tdata[32]
load net s_axis_tdata[33] -attr @rip s_axis_tdata[33] -port s_axis_tdata[33] -pin u_parser_core s_axis_tdata[33]
load net s_axis_tdata[34] -attr @rip s_axis_tdata[34] -port s_axis_tdata[34] -pin u_parser_core s_axis_tdata[34]
load net s_axis_tdata[35] -attr @rip s_axis_tdata[35] -port s_axis_tdata[35] -pin u_parser_core s_axis_tdata[35]
load net s_axis_tdata[36] -attr @rip s_axis_tdata[36] -port s_axis_tdata[36] -pin u_parser_core s_axis_tdata[36]
load net s_axis_tdata[37] -attr @rip s_axis_tdata[37] -port s_axis_tdata[37] -pin u_parser_core s_axis_tdata[37]
load net s_axis_tdata[38] -attr @rip s_axis_tdata[38] -port s_axis_tdata[38] -pin u_parser_core s_axis_tdata[38]
load net s_axis_tdata[39] -attr @rip s_axis_tdata[39] -port s_axis_tdata[39] -pin u_parser_core s_axis_tdata[39]
load net s_axis_tdata[3] -attr @rip s_axis_tdata[3] -port s_axis_tdata[3] -pin u_parser_core s_axis_tdata[3]
load net s_axis_tdata[40] -attr @rip s_axis_tdata[40] -port s_axis_tdata[40] -pin u_parser_core s_axis_tdata[40]
load net s_axis_tdata[41] -attr @rip s_axis_tdata[41] -port s_axis_tdata[41] -pin u_parser_core s_axis_tdata[41]
load net s_axis_tdata[42] -attr @rip s_axis_tdata[42] -port s_axis_tdata[42] -pin u_parser_core s_axis_tdata[42]
load net s_axis_tdata[43] -attr @rip s_axis_tdata[43] -port s_axis_tdata[43] -pin u_parser_core s_axis_tdata[43]
load net s_axis_tdata[44] -attr @rip s_axis_tdata[44] -port s_axis_tdata[44] -pin u_parser_core s_axis_tdata[44]
load net s_axis_tdata[45] -attr @rip s_axis_tdata[45] -port s_axis_tdata[45] -pin u_parser_core s_axis_tdata[45]
load net s_axis_tdata[46] -attr @rip s_axis_tdata[46] -port s_axis_tdata[46] -pin u_parser_core s_axis_tdata[46]
load net s_axis_tdata[47] -attr @rip s_axis_tdata[47] -port s_axis_tdata[47] -pin u_parser_core s_axis_tdata[47]
load net s_axis_tdata[48] -attr @rip s_axis_tdata[48] -port s_axis_tdata[48] -pin u_parser_core s_axis_tdata[48]
load net s_axis_tdata[49] -attr @rip s_axis_tdata[49] -port s_axis_tdata[49] -pin u_parser_core s_axis_tdata[49]
load net s_axis_tdata[4] -attr @rip s_axis_tdata[4] -port s_axis_tdata[4] -pin u_parser_core s_axis_tdata[4]
load net s_axis_tdata[50] -attr @rip s_axis_tdata[50] -port s_axis_tdata[50] -pin u_parser_core s_axis_tdata[50]
load net s_axis_tdata[51] -attr @rip s_axis_tdata[51] -port s_axis_tdata[51] -pin u_parser_core s_axis_tdata[51]
load net s_axis_tdata[52] -attr @rip s_axis_tdata[52] -port s_axis_tdata[52] -pin u_parser_core s_axis_tdata[52]
load net s_axis_tdata[53] -attr @rip s_axis_tdata[53] -port s_axis_tdata[53] -pin u_parser_core s_axis_tdata[53]
load net s_axis_tdata[54] -attr @rip s_axis_tdata[54] -port s_axis_tdata[54] -pin u_parser_core s_axis_tdata[54]
load net s_axis_tdata[55] -attr @rip s_axis_tdata[55] -port s_axis_tdata[55] -pin u_parser_core s_axis_tdata[55]
load net s_axis_tdata[56] -attr @rip s_axis_tdata[56] -port s_axis_tdata[56] -pin u_parser_core s_axis_tdata[56]
load net s_axis_tdata[57] -attr @rip s_axis_tdata[57] -port s_axis_tdata[57] -pin u_parser_core s_axis_tdata[57]
load net s_axis_tdata[58] -attr @rip s_axis_tdata[58] -port s_axis_tdata[58] -pin u_parser_core s_axis_tdata[58]
load net s_axis_tdata[59] -attr @rip s_axis_tdata[59] -port s_axis_tdata[59] -pin u_parser_core s_axis_tdata[59]
load net s_axis_tdata[5] -attr @rip s_axis_tdata[5] -port s_axis_tdata[5] -pin u_parser_core s_axis_tdata[5]
load net s_axis_tdata[60] -attr @rip s_axis_tdata[60] -port s_axis_tdata[60] -pin u_parser_core s_axis_tdata[60]
load net s_axis_tdata[61] -attr @rip s_axis_tdata[61] -port s_axis_tdata[61] -pin u_parser_core s_axis_tdata[61]
load net s_axis_tdata[62] -attr @rip s_axis_tdata[62] -port s_axis_tdata[62] -pin u_parser_core s_axis_tdata[62]
load net s_axis_tdata[63] -attr @rip s_axis_tdata[63] -port s_axis_tdata[63] -pin u_parser_core s_axis_tdata[63]
load net s_axis_tdata[64] -attr @rip s_axis_tdata[64] -port s_axis_tdata[64] -pin u_parser_core s_axis_tdata[64]
load net s_axis_tdata[65] -attr @rip s_axis_tdata[65] -port s_axis_tdata[65] -pin u_parser_core s_axis_tdata[65]
load net s_axis_tdata[66] -attr @rip s_axis_tdata[66] -port s_axis_tdata[66] -pin u_parser_core s_axis_tdata[66]
load net s_axis_tdata[67] -attr @rip s_axis_tdata[67] -port s_axis_tdata[67] -pin u_parser_core s_axis_tdata[67]
load net s_axis_tdata[68] -attr @rip s_axis_tdata[68] -port s_axis_tdata[68] -pin u_parser_core s_axis_tdata[68]
load net s_axis_tdata[69] -attr @rip s_axis_tdata[69] -port s_axis_tdata[69] -pin u_parser_core s_axis_tdata[69]
load net s_axis_tdata[6] -attr @rip s_axis_tdata[6] -port s_axis_tdata[6] -pin u_parser_core s_axis_tdata[6]
load net s_axis_tdata[70] -attr @rip s_axis_tdata[70] -port s_axis_tdata[70] -pin u_parser_core s_axis_tdata[70]
load net s_axis_tdata[71] -attr @rip s_axis_tdata[71] -port s_axis_tdata[71] -pin u_parser_core s_axis_tdata[71]
load net s_axis_tdata[72] -attr @rip s_axis_tdata[72] -port s_axis_tdata[72] -pin u_parser_core s_axis_tdata[72]
load net s_axis_tdata[73] -attr @rip s_axis_tdata[73] -port s_axis_tdata[73] -pin u_parser_core s_axis_tdata[73]
load net s_axis_tdata[74] -attr @rip s_axis_tdata[74] -port s_axis_tdata[74] -pin u_parser_core s_axis_tdata[74]
load net s_axis_tdata[75] -attr @rip s_axis_tdata[75] -port s_axis_tdata[75] -pin u_parser_core s_axis_tdata[75]
load net s_axis_tdata[76] -attr @rip s_axis_tdata[76] -port s_axis_tdata[76] -pin u_parser_core s_axis_tdata[76]
load net s_axis_tdata[77] -attr @rip s_axis_tdata[77] -port s_axis_tdata[77] -pin u_parser_core s_axis_tdata[77]
load net s_axis_tdata[78] -attr @rip s_axis_tdata[78] -port s_axis_tdata[78] -pin u_parser_core s_axis_tdata[78]
load net s_axis_tdata[79] -attr @rip s_axis_tdata[79] -port s_axis_tdata[79] -pin u_parser_core s_axis_tdata[79]
load net s_axis_tdata[7] -attr @rip s_axis_tdata[7] -port s_axis_tdata[7] -pin u_parser_core s_axis_tdata[7]
load net s_axis_tdata[80] -attr @rip s_axis_tdata[80] -port s_axis_tdata[80] -pin u_parser_core s_axis_tdata[80]
load net s_axis_tdata[81] -attr @rip s_axis_tdata[81] -port s_axis_tdata[81] -pin u_parser_core s_axis_tdata[81]
load net s_axis_tdata[82] -attr @rip s_axis_tdata[82] -port s_axis_tdata[82] -pin u_parser_core s_axis_tdata[82]
load net s_axis_tdata[83] -attr @rip s_axis_tdata[83] -port s_axis_tdata[83] -pin u_parser_core s_axis_tdata[83]
load net s_axis_tdata[84] -attr @rip s_axis_tdata[84] -port s_axis_tdata[84] -pin u_parser_core s_axis_tdata[84]
load net s_axis_tdata[85] -attr @rip s_axis_tdata[85] -port s_axis_tdata[85] -pin u_parser_core s_axis_tdata[85]
load net s_axis_tdata[86] -attr @rip s_axis_tdata[86] -port s_axis_tdata[86] -pin u_parser_core s_axis_tdata[86]
load net s_axis_tdata[87] -attr @rip s_axis_tdata[87] -port s_axis_tdata[87] -pin u_parser_core s_axis_tdata[87]
load net s_axis_tdata[88] -attr @rip s_axis_tdata[88] -port s_axis_tdata[88] -pin u_parser_core s_axis_tdata[88]
load net s_axis_tdata[89] -attr @rip s_axis_tdata[89] -port s_axis_tdata[89] -pin u_parser_core s_axis_tdata[89]
load net s_axis_tdata[8] -attr @rip s_axis_tdata[8] -port s_axis_tdata[8] -pin u_parser_core s_axis_tdata[8]
load net s_axis_tdata[90] -attr @rip s_axis_tdata[90] -port s_axis_tdata[90] -pin u_parser_core s_axis_tdata[90]
load net s_axis_tdata[91] -attr @rip s_axis_tdata[91] -port s_axis_tdata[91] -pin u_parser_core s_axis_tdata[91]
load net s_axis_tdata[92] -attr @rip s_axis_tdata[92] -port s_axis_tdata[92] -pin u_parser_core s_axis_tdata[92]
load net s_axis_tdata[93] -attr @rip s_axis_tdata[93] -port s_axis_tdata[93] -pin u_parser_core s_axis_tdata[93]
load net s_axis_tdata[94] -attr @rip s_axis_tdata[94] -port s_axis_tdata[94] -pin u_parser_core s_axis_tdata[94]
load net s_axis_tdata[95] -attr @rip s_axis_tdata[95] -port s_axis_tdata[95] -pin u_parser_core s_axis_tdata[95]
load net s_axis_tdata[96] -attr @rip s_axis_tdata[96] -port s_axis_tdata[96] -pin u_parser_core s_axis_tdata[96]
load net s_axis_tdata[97] -attr @rip s_axis_tdata[97] -port s_axis_tdata[97] -pin u_parser_core s_axis_tdata[97]
load net s_axis_tdata[98] -attr @rip s_axis_tdata[98] -port s_axis_tdata[98] -pin u_parser_core s_axis_tdata[98]
load net s_axis_tdata[99] -attr @rip s_axis_tdata[99] -port s_axis_tdata[99] -pin u_parser_core s_axis_tdata[99]
load net s_axis_tdata[9] -attr @rip s_axis_tdata[9] -port s_axis_tdata[9] -pin u_parser_core s_axis_tdata[9]
load net s_axis_tlast -port s_axis_tlast -pin u_parser_core s_axis_tlast
netloc s_axis_tlast 1 0 2 NJ 250 NJ
load net s_axis_tvalid -port s_axis_tvalid -pin u_parser_core s_axis_tvalid
netloc s_axis_tvalid 1 0 2 NJ 270 NJ
load net s_cfg_addr[0] -attr @rip s_cfg_addr[0] -port s_cfg_addr[0] -pin u_config_controller s_cfg_addr[0]
load net s_cfg_addr[1] -attr @rip s_cfg_addr[1] -port s_cfg_addr[1] -pin u_config_controller s_cfg_addr[1]
load net s_cfg_addr[2] -attr @rip s_cfg_addr[2] -port s_cfg_addr[2] -pin u_config_controller s_cfg_addr[2]
load net s_cfg_addr[3] -attr @rip s_cfg_addr[3] -port s_cfg_addr[3] -pin u_config_controller s_cfg_addr[3]
load net s_cfg_addr[4] -attr @rip s_cfg_addr[4] -port s_cfg_addr[4] -pin u_config_controller s_cfg_addr[4]
load net s_cfg_addr[5] -attr @rip s_cfg_addr[5] -port s_cfg_addr[5] -pin u_config_controller s_cfg_addr[5]
load net s_cfg_addr[6] -attr @rip s_cfg_addr[6] -port s_cfg_addr[6] -pin u_config_controller s_cfg_addr[6]
load net s_cfg_addr[7] -attr @rip s_cfg_addr[7] -port s_cfg_addr[7] -pin u_config_controller s_cfg_addr[7]
load net s_cfg_addr[8] -attr @rip s_cfg_addr[8] -port s_cfg_addr[8] -pin u_config_controller s_cfg_addr[8]
load net s_cfg_data[0] -attr @rip s_cfg_data[0] -port s_cfg_data[0] -pin u_config_controller s_cfg_data[0]
load net s_cfg_data[10] -attr @rip s_cfg_data[10] -port s_cfg_data[10] -pin u_config_controller s_cfg_data[10]
load net s_cfg_data[11] -attr @rip s_cfg_data[11] -port s_cfg_data[11] -pin u_config_controller s_cfg_data[11]
load net s_cfg_data[12] -attr @rip s_cfg_data[12] -port s_cfg_data[12] -pin u_config_controller s_cfg_data[12]
load net s_cfg_data[13] -attr @rip s_cfg_data[13] -port s_cfg_data[13] -pin u_config_controller s_cfg_data[13]
load net s_cfg_data[14] -attr @rip s_cfg_data[14] -port s_cfg_data[14] -pin u_config_controller s_cfg_data[14]
load net s_cfg_data[15] -attr @rip s_cfg_data[15] -port s_cfg_data[15] -pin u_config_controller s_cfg_data[15]
load net s_cfg_data[16] -attr @rip s_cfg_data[16] -port s_cfg_data[16] -pin u_config_controller s_cfg_data[16]
load net s_cfg_data[17] -attr @rip s_cfg_data[17] -port s_cfg_data[17] -pin u_config_controller s_cfg_data[17]
load net s_cfg_data[18] -attr @rip s_cfg_data[18] -port s_cfg_data[18] -pin u_config_controller s_cfg_data[18]
load net s_cfg_data[19] -attr @rip s_cfg_data[19] -port s_cfg_data[19] -pin u_config_controller s_cfg_data[19]
load net s_cfg_data[1] -attr @rip s_cfg_data[1] -port s_cfg_data[1] -pin u_config_controller s_cfg_data[1]
load net s_cfg_data[20] -attr @rip s_cfg_data[20] -port s_cfg_data[20] -pin u_config_controller s_cfg_data[20]
load net s_cfg_data[21] -attr @rip s_cfg_data[21] -port s_cfg_data[21] -pin u_config_controller s_cfg_data[21]
load net s_cfg_data[22] -attr @rip s_cfg_data[22] -port s_cfg_data[22] -pin u_config_controller s_cfg_data[22]
load net s_cfg_data[23] -attr @rip s_cfg_data[23] -port s_cfg_data[23] -pin u_config_controller s_cfg_data[23]
load net s_cfg_data[24] -attr @rip s_cfg_data[24] -port s_cfg_data[24] -pin u_config_controller s_cfg_data[24]
load net s_cfg_data[25] -attr @rip s_cfg_data[25] -port s_cfg_data[25] -pin u_config_controller s_cfg_data[25]
load net s_cfg_data[26] -attr @rip s_cfg_data[26] -port s_cfg_data[26] -pin u_config_controller s_cfg_data[26]
load net s_cfg_data[27] -attr @rip s_cfg_data[27] -port s_cfg_data[27] -pin u_config_controller s_cfg_data[27]
load net s_cfg_data[28] -attr @rip s_cfg_data[28] -port s_cfg_data[28] -pin u_config_controller s_cfg_data[28]
load net s_cfg_data[29] -attr @rip s_cfg_data[29] -port s_cfg_data[29] -pin u_config_controller s_cfg_data[29]
load net s_cfg_data[2] -attr @rip s_cfg_data[2] -port s_cfg_data[2] -pin u_config_controller s_cfg_data[2]
load net s_cfg_data[30] -attr @rip s_cfg_data[30] -port s_cfg_data[30] -pin u_config_controller s_cfg_data[30]
load net s_cfg_data[31] -attr @rip s_cfg_data[31] -port s_cfg_data[31] -pin u_config_controller s_cfg_data[31]
load net s_cfg_data[3] -attr @rip s_cfg_data[3] -port s_cfg_data[3] -pin u_config_controller s_cfg_data[3]
load net s_cfg_data[4] -attr @rip s_cfg_data[4] -port s_cfg_data[4] -pin u_config_controller s_cfg_data[4]
load net s_cfg_data[5] -attr @rip s_cfg_data[5] -port s_cfg_data[5] -pin u_config_controller s_cfg_data[5]
load net s_cfg_data[6] -attr @rip s_cfg_data[6] -port s_cfg_data[6] -pin u_config_controller s_cfg_data[6]
load net s_cfg_data[7] -attr @rip s_cfg_data[7] -port s_cfg_data[7] -pin u_config_controller s_cfg_data[7]
load net s_cfg_data[8] -attr @rip s_cfg_data[8] -port s_cfg_data[8] -pin u_config_controller s_cfg_data[8]
load net s_cfg_data[9] -attr @rip s_cfg_data[9] -port s_cfg_data[9] -pin u_config_controller s_cfg_data[9]
load net s_cfg_rd_data[0] -attr @rip s_cfg_rd_data[0] -port s_cfg_rd_data[0] -pin u_config_controller s_cfg_rd_data[0]
load net s_cfg_rd_data[10] -attr @rip s_cfg_rd_data[10] -port s_cfg_rd_data[10] -pin u_config_controller s_cfg_rd_data[10]
load net s_cfg_rd_data[11] -attr @rip s_cfg_rd_data[11] -port s_cfg_rd_data[11] -pin u_config_controller s_cfg_rd_data[11]
load net s_cfg_rd_data[12] -attr @rip s_cfg_rd_data[12] -port s_cfg_rd_data[12] -pin u_config_controller s_cfg_rd_data[12]
load net s_cfg_rd_data[13] -attr @rip s_cfg_rd_data[13] -port s_cfg_rd_data[13] -pin u_config_controller s_cfg_rd_data[13]
load net s_cfg_rd_data[14] -attr @rip s_cfg_rd_data[14] -port s_cfg_rd_data[14] -pin u_config_controller s_cfg_rd_data[14]
load net s_cfg_rd_data[15] -attr @rip s_cfg_rd_data[15] -port s_cfg_rd_data[15] -pin u_config_controller s_cfg_rd_data[15]
load net s_cfg_rd_data[16] -attr @rip s_cfg_rd_data[16] -port s_cfg_rd_data[16] -pin u_config_controller s_cfg_rd_data[16]
load net s_cfg_rd_data[17] -attr @rip s_cfg_rd_data[17] -port s_cfg_rd_data[17] -pin u_config_controller s_cfg_rd_data[17]
load net s_cfg_rd_data[18] -attr @rip s_cfg_rd_data[18] -port s_cfg_rd_data[18] -pin u_config_controller s_cfg_rd_data[18]
load net s_cfg_rd_data[19] -attr @rip s_cfg_rd_data[19] -port s_cfg_rd_data[19] -pin u_config_controller s_cfg_rd_data[19]
load net s_cfg_rd_data[1] -attr @rip s_cfg_rd_data[1] -port s_cfg_rd_data[1] -pin u_config_controller s_cfg_rd_data[1]
load net s_cfg_rd_data[20] -attr @rip s_cfg_rd_data[20] -port s_cfg_rd_data[20] -pin u_config_controller s_cfg_rd_data[20]
load net s_cfg_rd_data[21] -attr @rip s_cfg_rd_data[21] -port s_cfg_rd_data[21] -pin u_config_controller s_cfg_rd_data[21]
load net s_cfg_rd_data[22] -attr @rip s_cfg_rd_data[22] -port s_cfg_rd_data[22] -pin u_config_controller s_cfg_rd_data[22]
load net s_cfg_rd_data[23] -attr @rip s_cfg_rd_data[23] -port s_cfg_rd_data[23] -pin u_config_controller s_cfg_rd_data[23]
load net s_cfg_rd_data[24] -attr @rip s_cfg_rd_data[24] -port s_cfg_rd_data[24] -pin u_config_controller s_cfg_rd_data[24]
load net s_cfg_rd_data[25] -attr @rip s_cfg_rd_data[25] -port s_cfg_rd_data[25] -pin u_config_controller s_cfg_rd_data[25]
load net s_cfg_rd_data[26] -attr @rip s_cfg_rd_data[26] -port s_cfg_rd_data[26] -pin u_config_controller s_cfg_rd_data[26]
load net s_cfg_rd_data[27] -attr @rip s_cfg_rd_data[27] -port s_cfg_rd_data[27] -pin u_config_controller s_cfg_rd_data[27]
load net s_cfg_rd_data[28] -attr @rip s_cfg_rd_data[28] -port s_cfg_rd_data[28] -pin u_config_controller s_cfg_rd_data[28]
load net s_cfg_rd_data[29] -attr @rip s_cfg_rd_data[29] -port s_cfg_rd_data[29] -pin u_config_controller s_cfg_rd_data[29]
load net s_cfg_rd_data[2] -attr @rip s_cfg_rd_data[2] -port s_cfg_rd_data[2] -pin u_config_controller s_cfg_rd_data[2]
load net s_cfg_rd_data[30] -attr @rip s_cfg_rd_data[30] -port s_cfg_rd_data[30] -pin u_config_controller s_cfg_rd_data[30]
load net s_cfg_rd_data[31] -attr @rip s_cfg_rd_data[31] -port s_cfg_rd_data[31] -pin u_config_controller s_cfg_rd_data[31]
load net s_cfg_rd_data[3] -attr @rip s_cfg_rd_data[3] -port s_cfg_rd_data[3] -pin u_config_controller s_cfg_rd_data[3]
load net s_cfg_rd_data[4] -attr @rip s_cfg_rd_data[4] -port s_cfg_rd_data[4] -pin u_config_controller s_cfg_rd_data[4]
load net s_cfg_rd_data[5] -attr @rip s_cfg_rd_data[5] -port s_cfg_rd_data[5] -pin u_config_controller s_cfg_rd_data[5]
load net s_cfg_rd_data[6] -attr @rip s_cfg_rd_data[6] -port s_cfg_rd_data[6] -pin u_config_controller s_cfg_rd_data[6]
load net s_cfg_rd_data[7] -attr @rip s_cfg_rd_data[7] -port s_cfg_rd_data[7] -pin u_config_controller s_cfg_rd_data[7]
load net s_cfg_rd_data[8] -attr @rip s_cfg_rd_data[8] -port s_cfg_rd_data[8] -pin u_config_controller s_cfg_rd_data[8]
load net s_cfg_rd_data[9] -attr @rip s_cfg_rd_data[9] -port s_cfg_rd_data[9] -pin u_config_controller s_cfg_rd_data[9]
load net s_cfg_rd_en -port s_cfg_rd_en -pin u_config_controller s_cfg_rd_en
netloc s_cfg_rd_en 1 0 1 NJ 150
load net s_cfg_wr_en -port s_cfg_wr_en -pin u_config_controller s_cfg_wr_en
netloc s_cfg_wr_en 1 0 1 NJ 170
load net seq_num_out[0] -attr @rip seq_num_out[0] -pin u_parser_core seq_num_out[0] -pin u_risk_layer seq_num_in[0]
load net seq_num_out[10] -attr @rip seq_num_out[10] -pin u_parser_core seq_num_out[10] -pin u_risk_layer seq_num_in[10]
load net seq_num_out[11] -attr @rip seq_num_out[11] -pin u_parser_core seq_num_out[11] -pin u_risk_layer seq_num_in[11]
load net seq_num_out[12] -attr @rip seq_num_out[12] -pin u_parser_core seq_num_out[12] -pin u_risk_layer seq_num_in[12]
load net seq_num_out[13] -attr @rip seq_num_out[13] -pin u_parser_core seq_num_out[13] -pin u_risk_layer seq_num_in[13]
load net seq_num_out[14] -attr @rip seq_num_out[14] -pin u_parser_core seq_num_out[14] -pin u_risk_layer seq_num_in[14]
load net seq_num_out[15] -attr @rip seq_num_out[15] -pin u_parser_core seq_num_out[15] -pin u_risk_layer seq_num_in[15]
load net seq_num_out[1] -attr @rip seq_num_out[1] -pin u_parser_core seq_num_out[1] -pin u_risk_layer seq_num_in[1]
load net seq_num_out[2] -attr @rip seq_num_out[2] -pin u_parser_core seq_num_out[2] -pin u_risk_layer seq_num_in[2]
load net seq_num_out[3] -attr @rip seq_num_out[3] -pin u_parser_core seq_num_out[3] -pin u_risk_layer seq_num_in[3]
load net seq_num_out[4] -attr @rip seq_num_out[4] -pin u_parser_core seq_num_out[4] -pin u_risk_layer seq_num_in[4]
load net seq_num_out[5] -attr @rip seq_num_out[5] -pin u_parser_core seq_num_out[5] -pin u_risk_layer seq_num_in[5]
load net seq_num_out[6] -attr @rip seq_num_out[6] -pin u_parser_core seq_num_out[6] -pin u_risk_layer seq_num_in[6]
load net seq_num_out[7] -attr @rip seq_num_out[7] -pin u_parser_core seq_num_out[7] -pin u_risk_layer seq_num_in[7]
load net seq_num_out[8] -attr @rip seq_num_out[8] -pin u_parser_core seq_num_out[8] -pin u_risk_layer seq_num_in[8]
load net seq_num_out[9] -attr @rip seq_num_out[9] -pin u_parser_core seq_num_out[9] -pin u_risk_layer seq_num_in[9]
load net ticker_out[0] -attr @rip ticker_out[0] -pin u_parser_core ticker_out[0] -pin u_risk_layer ticker_in[0]
load net ticker_out[10] -attr @rip ticker_out[10] -pin u_parser_core ticker_out[10] -pin u_risk_layer ticker_in[10]
load net ticker_out[11] -attr @rip ticker_out[11] -pin u_parser_core ticker_out[11] -pin u_risk_layer ticker_in[11]
load net ticker_out[12] -attr @rip ticker_out[12] -pin u_parser_core ticker_out[12] -pin u_risk_layer ticker_in[12]
load net ticker_out[13] -attr @rip ticker_out[13] -pin u_parser_core ticker_out[13] -pin u_risk_layer ticker_in[13]
load net ticker_out[14] -attr @rip ticker_out[14] -pin u_parser_core ticker_out[14] -pin u_risk_layer ticker_in[14]
load net ticker_out[15] -attr @rip ticker_out[15] -pin u_parser_core ticker_out[15] -pin u_risk_layer ticker_in[15]
load net ticker_out[16] -attr @rip ticker_out[16] -pin u_parser_core ticker_out[16] -pin u_risk_layer ticker_in[16]
load net ticker_out[17] -attr @rip ticker_out[17] -pin u_parser_core ticker_out[17] -pin u_risk_layer ticker_in[17]
load net ticker_out[18] -attr @rip ticker_out[18] -pin u_parser_core ticker_out[18] -pin u_risk_layer ticker_in[18]
load net ticker_out[19] -attr @rip ticker_out[19] -pin u_parser_core ticker_out[19] -pin u_risk_layer ticker_in[19]
load net ticker_out[1] -attr @rip ticker_out[1] -pin u_parser_core ticker_out[1] -pin u_risk_layer ticker_in[1]
load net ticker_out[20] -attr @rip ticker_out[20] -pin u_parser_core ticker_out[20] -pin u_risk_layer ticker_in[20]
load net ticker_out[21] -attr @rip ticker_out[21] -pin u_parser_core ticker_out[21] -pin u_risk_layer ticker_in[21]
load net ticker_out[22] -attr @rip ticker_out[22] -pin u_parser_core ticker_out[22] -pin u_risk_layer ticker_in[22]
load net ticker_out[23] -attr @rip ticker_out[23] -pin u_parser_core ticker_out[23] -pin u_risk_layer ticker_in[23]
load net ticker_out[24] -attr @rip ticker_out[24] -pin u_parser_core ticker_out[24] -pin u_risk_layer ticker_in[24]
load net ticker_out[25] -attr @rip ticker_out[25] -pin u_parser_core ticker_out[25] -pin u_risk_layer ticker_in[25]
load net ticker_out[26] -attr @rip ticker_out[26] -pin u_parser_core ticker_out[26] -pin u_risk_layer ticker_in[26]
load net ticker_out[27] -attr @rip ticker_out[27] -pin u_parser_core ticker_out[27] -pin u_risk_layer ticker_in[27]
load net ticker_out[28] -attr @rip ticker_out[28] -pin u_parser_core ticker_out[28] -pin u_risk_layer ticker_in[28]
load net ticker_out[29] -attr @rip ticker_out[29] -pin u_parser_core ticker_out[29] -pin u_risk_layer ticker_in[29]
load net ticker_out[2] -attr @rip ticker_out[2] -pin u_parser_core ticker_out[2] -pin u_risk_layer ticker_in[2]
load net ticker_out[30] -attr @rip ticker_out[30] -pin u_parser_core ticker_out[30] -pin u_risk_layer ticker_in[30]
load net ticker_out[31] -attr @rip ticker_out[31] -pin u_parser_core ticker_out[31] -pin u_risk_layer ticker_in[31]
load net ticker_out[32] -attr @rip ticker_out[32] -pin u_parser_core ticker_out[32] -pin u_risk_layer ticker_in[32]
load net ticker_out[33] -attr @rip ticker_out[33] -pin u_parser_core ticker_out[33] -pin u_risk_layer ticker_in[33]
load net ticker_out[34] -attr @rip ticker_out[34] -pin u_parser_core ticker_out[34] -pin u_risk_layer ticker_in[34]
load net ticker_out[35] -attr @rip ticker_out[35] -pin u_parser_core ticker_out[35] -pin u_risk_layer ticker_in[35]
load net ticker_out[36] -attr @rip ticker_out[36] -pin u_parser_core ticker_out[36] -pin u_risk_layer ticker_in[36]
load net ticker_out[37] -attr @rip ticker_out[37] -pin u_parser_core ticker_out[37] -pin u_risk_layer ticker_in[37]
load net ticker_out[38] -attr @rip ticker_out[38] -pin u_parser_core ticker_out[38] -pin u_risk_layer ticker_in[38]
load net ticker_out[39] -attr @rip ticker_out[39] -pin u_parser_core ticker_out[39] -pin u_risk_layer ticker_in[39]
load net ticker_out[3] -attr @rip ticker_out[3] -pin u_parser_core ticker_out[3] -pin u_risk_layer ticker_in[3]
load net ticker_out[40] -attr @rip ticker_out[40] -pin u_parser_core ticker_out[40] -pin u_risk_layer ticker_in[40]
load net ticker_out[41] -attr @rip ticker_out[41] -pin u_parser_core ticker_out[41] -pin u_risk_layer ticker_in[41]
load net ticker_out[42] -attr @rip ticker_out[42] -pin u_parser_core ticker_out[42] -pin u_risk_layer ticker_in[42]
load net ticker_out[43] -attr @rip ticker_out[43] -pin u_parser_core ticker_out[43] -pin u_risk_layer ticker_in[43]
load net ticker_out[44] -attr @rip ticker_out[44] -pin u_parser_core ticker_out[44] -pin u_risk_layer ticker_in[44]
load net ticker_out[45] -attr @rip ticker_out[45] -pin u_parser_core ticker_out[45] -pin u_risk_layer ticker_in[45]
load net ticker_out[46] -attr @rip ticker_out[46] -pin u_parser_core ticker_out[46] -pin u_risk_layer ticker_in[46]
load net ticker_out[47] -attr @rip ticker_out[47] -pin u_parser_core ticker_out[47] -pin u_risk_layer ticker_in[47]
load net ticker_out[4] -attr @rip ticker_out[4] -pin u_parser_core ticker_out[4] -pin u_risk_layer ticker_in[4]
load net ticker_out[5] -attr @rip ticker_out[5] -pin u_parser_core ticker_out[5] -pin u_risk_layer ticker_in[5]
load net ticker_out[6] -attr @rip ticker_out[6] -pin u_parser_core ticker_out[6] -pin u_risk_layer ticker_in[6]
load net ticker_out[7] -attr @rip ticker_out[7] -pin u_parser_core ticker_out[7] -pin u_risk_layer ticker_in[7]
load net ticker_out[8] -attr @rip ticker_out[8] -pin u_parser_core ticker_out[8] -pin u_risk_layer ticker_in[8]
load net ticker_out[9] -attr @rip ticker_out[9] -pin u_parser_core ticker_out[9] -pin u_risk_layer ticker_in[9]
load netBundle @s_axis_tdata 128 s_axis_tdata[127] s_axis_tdata[126] s_axis_tdata[125] s_axis_tdata[124] s_axis_tdata[123] s_axis_tdata[122] s_axis_tdata[121] s_axis_tdata[120] s_axis_tdata[119] s_axis_tdata[118] s_axis_tdata[117] s_axis_tdata[116] s_axis_tdata[115] s_axis_tdata[114] s_axis_tdata[113] s_axis_tdata[112] s_axis_tdata[111] s_axis_tdata[110] s_axis_tdata[109] s_axis_tdata[108] s_axis_tdata[107] s_axis_tdata[106] s_axis_tdata[105] s_axis_tdata[104] s_axis_tdata[103] s_axis_tdata[102] s_axis_tdata[101] s_axis_tdata[100] s_axis_tdata[99] s_axis_tdata[98] s_axis_tdata[97] s_axis_tdata[96] s_axis_tdata[95] s_axis_tdata[94] s_axis_tdata[93] s_axis_tdata[92] s_axis_tdata[91] s_axis_tdata[90] s_axis_tdata[89] s_axis_tdata[88] s_axis_tdata[87] s_axis_tdata[86] s_axis_tdata[85] s_axis_tdata[84] s_axis_tdata[83] s_axis_tdata[82] s_axis_tdata[81] s_axis_tdata[80] s_axis_tdata[79] s_axis_tdata[78] s_axis_tdata[77] s_axis_tdata[76] s_axis_tdata[75] s_axis_tdata[74] s_axis_tdata[73] s_axis_tdata[72] s_axis_tdata[71] s_axis_tdata[70] s_axis_tdata[69] s_axis_tdata[68] s_axis_tdata[67] s_axis_tdata[66] s_axis_tdata[65] s_axis_tdata[64] s_axis_tdata[63] s_axis_tdata[62] s_axis_tdata[61] s_axis_tdata[60] s_axis_tdata[59] s_axis_tdata[58] s_axis_tdata[57] s_axis_tdata[56] s_axis_tdata[55] s_axis_tdata[54] s_axis_tdata[53] s_axis_tdata[52] s_axis_tdata[51] s_axis_tdata[50] s_axis_tdata[49] s_axis_tdata[48] s_axis_tdata[47] s_axis_tdata[46] s_axis_tdata[45] s_axis_tdata[44] s_axis_tdata[43] s_axis_tdata[42] s_axis_tdata[41] s_axis_tdata[40] s_axis_tdata[39] s_axis_tdata[38] s_axis_tdata[37] s_axis_tdata[36] s_axis_tdata[35] s_axis_tdata[34] s_axis_tdata[33] s_axis_tdata[32] s_axis_tdata[31] s_axis_tdata[30] s_axis_tdata[29] s_axis_tdata[28] s_axis_tdata[27] s_axis_tdata[26] s_axis_tdata[25] s_axis_tdata[24] s_axis_tdata[23] s_axis_tdata[22] s_axis_tdata[21] s_axis_tdata[20] s_axis_tdata[19] s_axis_tdata[18] s_axis_tdata[17] s_axis_tdata[16] s_axis_tdata[15] s_axis_tdata[14] s_axis_tdata[13] s_axis_tdata[12] s_axis_tdata[11] s_axis_tdata[10] s_axis_tdata[9] s_axis_tdata[8] s_axis_tdata[7] s_axis_tdata[6] s_axis_tdata[5] s_axis_tdata[4] s_axis_tdata[3] s_axis_tdata[2] s_axis_tdata[1] s_axis_tdata[0] -autobundled
netbloc @s_axis_tdata 1 0 2 NJ 230 NJ
load netBundle @s_cfg_addr 9 s_cfg_addr[8] s_cfg_addr[7] s_cfg_addr[6] s_cfg_addr[5] s_cfg_addr[4] s_cfg_addr[3] s_cfg_addr[2] s_cfg_addr[1] s_cfg_addr[0] -autobundled
netbloc @s_cfg_addr 1 0 1 NJ 110
load netBundle @s_cfg_data 32 s_cfg_data[31] s_cfg_data[30] s_cfg_data[29] s_cfg_data[28] s_cfg_data[27] s_cfg_data[26] s_cfg_data[25] s_cfg_data[24] s_cfg_data[23] s_cfg_data[22] s_cfg_data[21] s_cfg_data[20] s_cfg_data[19] s_cfg_data[18] s_cfg_data[17] s_cfg_data[16] s_cfg_data[15] s_cfg_data[14] s_cfg_data[13] s_cfg_data[12] s_cfg_data[11] s_cfg_data[10] s_cfg_data[9] s_cfg_data[8] s_cfg_data[7] s_cfg_data[6] s_cfg_data[5] s_cfg_data[4] s_cfg_data[3] s_cfg_data[2] s_cfg_data[1] s_cfg_data[0] -autobundled
netbloc @s_cfg_data 1 0 1 NJ 130
load netBundle @anomaly_ticker 48 anomaly_ticker[47] anomaly_ticker[46] anomaly_ticker[45] anomaly_ticker[44] anomaly_ticker[43] anomaly_ticker[42] anomaly_ticker[41] anomaly_ticker[40] anomaly_ticker[39] anomaly_ticker[38] anomaly_ticker[37] anomaly_ticker[36] anomaly_ticker[35] anomaly_ticker[34] anomaly_ticker[33] anomaly_ticker[32] anomaly_ticker[31] anomaly_ticker[30] anomaly_ticker[29] anomaly_ticker[28] anomaly_ticker[27] anomaly_ticker[26] anomaly_ticker[25] anomaly_ticker[24] anomaly_ticker[23] anomaly_ticker[22] anomaly_ticker[21] anomaly_ticker[20] anomaly_ticker[19] anomaly_ticker[18] anomaly_ticker[17] anomaly_ticker[16] anomaly_ticker[15] anomaly_ticker[14] anomaly_ticker[13] anomaly_ticker[12] anomaly_ticker[11] anomaly_ticker[10] anomaly_ticker[9] anomaly_ticker[8] anomaly_ticker[7] anomaly_ticker[6] anomaly_ticker[5] anomaly_ticker[4] anomaly_ticker[3] anomaly_ticker[2] anomaly_ticker[1] anomaly_ticker[0] -autobundled
netbloc @anomaly_ticker 1 3 1 NJ 170
load netBundle @expected_seq 16 expected_seq[15] expected_seq[14] expected_seq[13] expected_seq[12] expected_seq[11] expected_seq[10] expected_seq[9] expected_seq[8] expected_seq[7] expected_seq[6] expected_seq[5] expected_seq[4] expected_seq[3] expected_seq[2] expected_seq[1] expected_seq[0] -autobundled
netbloc @expected_seq 1 3 1 NJ 190
load netBundle @fsm_state_dbg 3 fsm_state_dbg[2] fsm_state_dbg[1] fsm_state_dbg[0] -autobundled
netbloc @fsm_state_dbg 1 2 2 930J 30 NJ
load netBundle @m_payload_data 128 m_payload_data[127] m_payload_data[126] m_payload_data[125] m_payload_data[124] m_payload_data[123] m_payload_data[122] m_payload_data[121] m_payload_data[120] m_payload_data[119] m_payload_data[118] m_payload_data[117] m_payload_data[116] m_payload_data[115] m_payload_data[114] m_payload_data[113] m_payload_data[112] m_payload_data[111] m_payload_data[110] m_payload_data[109] m_payload_data[108] m_payload_data[107] m_payload_data[106] m_payload_data[105] m_payload_data[104] m_payload_data[103] m_payload_data[102] m_payload_data[101] m_payload_data[100] m_payload_data[99] m_payload_data[98] m_payload_data[97] m_payload_data[96] m_payload_data[95] m_payload_data[94] m_payload_data[93] m_payload_data[92] m_payload_data[91] m_payload_data[90] m_payload_data[89] m_payload_data[88] m_payload_data[87] m_payload_data[86] m_payload_data[85] m_payload_data[84] m_payload_data[83] m_payload_data[82] m_payload_data[81] m_payload_data[80] m_payload_data[79] m_payload_data[78] m_payload_data[77] m_payload_data[76] m_payload_data[75] m_payload_data[74] m_payload_data[73] m_payload_data[72] m_payload_data[71] m_payload_data[70] m_payload_data[69] m_payload_data[68] m_payload_data[67] m_payload_data[66] m_payload_data[65] m_payload_data[64] m_payload_data[63] m_payload_data[62] m_payload_data[61] m_payload_data[60] m_payload_data[59] m_payload_data[58] m_payload_data[57] m_payload_data[56] m_payload_data[55] m_payload_data[54] m_payload_data[53] m_payload_data[52] m_payload_data[51] m_payload_data[50] m_payload_data[49] m_payload_data[48] m_payload_data[47] m_payload_data[46] m_payload_data[45] m_payload_data[44] m_payload_data[43] m_payload_data[42] m_payload_data[41] m_payload_data[40] m_payload_data[39] m_payload_data[38] m_payload_data[37] m_payload_data[36] m_payload_data[35] m_payload_data[34] m_payload_data[33] m_payload_data[32] m_payload_data[31] m_payload_data[30] m_payload_data[29] m_payload_data[28] m_payload_data[27] m_payload_data[26] m_payload_data[25] m_payload_data[24] m_payload_data[23] m_payload_data[22] m_payload_data[21] m_payload_data[20] m_payload_data[19] m_payload_data[18] m_payload_data[17] m_payload_data[16] m_payload_data[15] m_payload_data[14] m_payload_data[13] m_payload_data[12] m_payload_data[11] m_payload_data[10] m_payload_data[9] m_payload_data[8] m_payload_data[7] m_payload_data[6] m_payload_data[5] m_payload_data[4] m_payload_data[3] m_payload_data[2] m_payload_data[1] m_payload_data[0] -autobundled
netbloc @m_payload_data 1 2 2 810J 310 NJ
load netBundle @m_timestamp 64 m_timestamp[63] m_timestamp[62] m_timestamp[61] m_timestamp[60] m_timestamp[59] m_timestamp[58] m_timestamp[57] m_timestamp[56] m_timestamp[55] m_timestamp[54] m_timestamp[53] m_timestamp[52] m_timestamp[51] m_timestamp[50] m_timestamp[49] m_timestamp[48] m_timestamp[47] m_timestamp[46] m_timestamp[45] m_timestamp[44] m_timestamp[43] m_timestamp[42] m_timestamp[41] m_timestamp[40] m_timestamp[39] m_timestamp[38] m_timestamp[37] m_timestamp[36] m_timestamp[35] m_timestamp[34] m_timestamp[33] m_timestamp[32] m_timestamp[31] m_timestamp[30] m_timestamp[29] m_timestamp[28] m_timestamp[27] m_timestamp[26] m_timestamp[25] m_timestamp[24] m_timestamp[23] m_timestamp[22] m_timestamp[21] m_timestamp[20] m_timestamp[19] m_timestamp[18] m_timestamp[17] m_timestamp[16] m_timestamp[15] m_timestamp[14] m_timestamp[13] m_timestamp[12] m_timestamp[11] m_timestamp[10] m_timestamp[9] m_timestamp[8] m_timestamp[7] m_timestamp[6] m_timestamp[5] m_timestamp[4] m_timestamp[3] m_timestamp[2] m_timestamp[1] m_timestamp[0] -autobundled
netbloc @m_timestamp 1 3 1 NJ 430
load netBundle @received_seq 16 received_seq[15] received_seq[14] received_seq[13] received_seq[12] received_seq[11] received_seq[10] received_seq[9] received_seq[8] received_seq[7] received_seq[6] received_seq[5] received_seq[4] received_seq[3] received_seq[2] received_seq[1] received_seq[0] -autobundled
netbloc @received_seq 1 3 1 NJ 210
load netBundle @s_cfg_rd_data 32 s_cfg_rd_data[31] s_cfg_rd_data[30] s_cfg_rd_data[29] s_cfg_rd_data[28] s_cfg_rd_data[27] s_cfg_rd_data[26] s_cfg_rd_data[25] s_cfg_rd_data[24] s_cfg_rd_data[23] s_cfg_rd_data[22] s_cfg_rd_data[21] s_cfg_rd_data[20] s_cfg_rd_data[19] s_cfg_rd_data[18] s_cfg_rd_data[17] s_cfg_rd_data[16] s_cfg_rd_data[15] s_cfg_rd_data[14] s_cfg_rd_data[13] s_cfg_rd_data[12] s_cfg_rd_data[11] s_cfg_rd_data[10] s_cfg_rd_data[9] s_cfg_rd_data[8] s_cfg_rd_data[7] s_cfg_rd_data[6] s_cfg_rd_data[5] s_cfg_rd_data[4] s_cfg_rd_data[3] s_cfg_rd_data[2] s_cfg_rd_data[1] s_cfg_rd_data[0] -autobundled
netbloc @s_cfg_rd_data 1 1 3 350J 330 810J 350 NJ
load netBundle @dram_wr_addr 6 dram_wr_addr[5] dram_wr_addr[4] dram_wr_addr[3] dram_wr_addr[2] dram_wr_addr[1] dram_wr_addr[0] -autobundled
netbloc @dram_wr_addr 1 1 1 430 70n
load netBundle @dram_wr_bank 2 dram_wr_bank[1] dram_wr_bank[0] -autobundled
netbloc @dram_wr_bank 1 1 1 410 90n
load netBundle @dram_wr_data 48 dram_wr_data[47] dram_wr_data[46] dram_wr_data[45] dram_wr_data[44] dram_wr_data[43] dram_wr_data[42] dram_wr_data[41] dram_wr_data[40] dram_wr_data[39] dram_wr_data[38] dram_wr_data[37] dram_wr_data[36] dram_wr_data[35] dram_wr_data[34] dram_wr_data[33] dram_wr_data[32] dram_wr_data[31] dram_wr_data[30] dram_wr_data[29] dram_wr_data[28] dram_wr_data[27] dram_wr_data[26] dram_wr_data[25] dram_wr_data[24] dram_wr_data[23] dram_wr_data[22] dram_wr_data[21] dram_wr_data[20] dram_wr_data[19] dram_wr_data[18] dram_wr_data[17] dram_wr_data[16] dram_wr_data[15] dram_wr_data[14] dram_wr_data[13] dram_wr_data[12] dram_wr_data[11] dram_wr_data[10] dram_wr_data[9] dram_wr_data[8] dram_wr_data[7] dram_wr_data[6] dram_wr_data[5] dram_wr_data[4] dram_wr_data[3] dram_wr_data[2] dram_wr_data[1] dram_wr_data[0] -autobundled
netbloc @dram_wr_data 1 1 1 390 110n
load netBundle @hash_idx_out 6 hash_idx_out[5] hash_idx_out[4] hash_idx_out[3] hash_idx_out[2] hash_idx_out[1] hash_idx_out[0] -autobundled
netbloc @hash_idx_out 1 2 1 N 190
load netBundle @seq_num_out 16 seq_num_out[15] seq_num_out[14] seq_num_out[13] seq_num_out[12] seq_num_out[11] seq_num_out[10] seq_num_out[9] seq_num_out[8] seq_num_out[7] seq_num_out[6] seq_num_out[5] seq_num_out[4] seq_num_out[3] seq_num_out[2] seq_num_out[1] seq_num_out[0] -autobundled
netbloc @seq_num_out 1 2 1 890 250n
load netBundle @ticker_out 48 ticker_out[47] ticker_out[46] ticker_out[45] ticker_out[44] ticker_out[43] ticker_out[42] ticker_out[41] ticker_out[40] ticker_out[39] ticker_out[38] ticker_out[37] ticker_out[36] ticker_out[35] ticker_out[34] ticker_out[33] ticker_out[32] ticker_out[31] ticker_out[30] ticker_out[29] ticker_out[28] ticker_out[27] ticker_out[26] ticker_out[25] ticker_out[24] ticker_out[23] ticker_out[22] ticker_out[21] ticker_out[20] ticker_out[19] ticker_out[18] ticker_out[17] ticker_out[16] ticker_out[15] ticker_out[14] ticker_out[13] ticker_out[12] ticker_out[11] ticker_out[10] ticker_out[9] ticker_out[8] ticker_out[7] ticker_out[6] ticker_out[5] ticker_out[4] ticker_out[3] ticker_out[2] ticker_out[1] ticker_out[0] -autobundled
netbloc @ticker_out 1 2 1 930 270n
levelinfo -pg 1 0 150 590 1060 1270
pagesize -pg 1 -db -bbox -sgen -180 0 1470 490
show
fullfit
#
# initialize ictrl to current module top_level work:top_level:NOFILE
ictrl init topinfo |
