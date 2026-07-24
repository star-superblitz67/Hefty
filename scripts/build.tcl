# build.tcl - Automates Vivado OOC Synthesis + Timing Analysis
# Run from the root of the project repository:
#   vivado -mode batch -source scripts/build.tcl
#
# Out-of-Context (OOC) mode is used because:
#  1. No physical board or pin assignment file exists.
#  2. This is an IP core — in real HFT deployments it is integrated into
#     a larger system. OOC is the correct way to measure internal logic
#     timing without I/O pad placement errors.
#  3. OOC skips OBUF/IBUF insertion, so the placer sees only real logic
#     and timing numbers reflect pure internal combinatorial/register paths.

set part_num    "xc7k160tffg676-2"
set project_name "fpga_parser_synth"
set top_module   "top_level"

# -------------------------------------------------------
# Clean up any existing run directory
# -------------------------------------------------------
if {[file exists $project_name]} {
    file delete -force $project_name
}
file mkdir $project_name

# -------------------------------------------------------
# Collect source files
# -------------------------------------------------------
set sv_files [glob -nocomplain ./rtl/*.sv]
set hex_files [glob -nocomplain ./mem/*.hex]

# -------------------------------------------------------
# Out-of-Context Synthesis
# Synthesizes the core logic without I/O buffers.
# -mode out_of_context tells Vivado to treat all ports as
# internal signals — no IBUF/OBUF instantiated, no pin
# assignment required.
# -------------------------------------------------------
puts "=========================================================="
puts "  Running Out-of-Context Synthesis on $part_num"
puts "=========================================================="

# -------------------------------------------------------
# Read sources into Vivado (non-project batch flow)
# -------------------------------------------------------
foreach f $sv_files {
    read_verilog -sv $f
}
# Add hex files to the file list so $readmemh resolves
foreach f $hex_files {
    add_files $f
}

# -------------------------------------------------------
# Out-of-Context Synthesis
# Synthesizes the core logic without I/O buffers.
# -mode out_of_context tells Vivado to treat all ports as
# internal signals — no IBUF/OBUF instantiated, no pin
# assignment required.
# -------------------------------------------------------
synth_design \
    -top  $top_module \
    -part $part_num   \
    -mode out_of_context

# -------------------------------------------------------
# Report: Post-Synthesis Utilization
# -------------------------------------------------------
report_utilization -file ./$project_name/synth_utilization.rpt
puts "  Utilization report  -> ./$project_name/synth_utilization.rpt"

# -------------------------------------------------------
# Apply Clock Constraint (250 MHz = 4 ns period)
# In OOC mode the XDC is applied after synth_design.
# We create the clock on the synthesized clock net directly.
# -------------------------------------------------------
create_clock -period 4.000 -name clk [get_ports clk]

# -------------------------------------------------------
# Report: Post-Synthesis Timing Summary
# WNS >= 0 means the design MEETS 250 MHz timing.
# WNS <  0 shows how many nanoseconds short we are and
# which path is the bottleneck.
# -------------------------------------------------------
report_timing_summary \
    -delay_type min_max \
    -report_unconstrained \
    -check_timing_verbose \
    -max_paths 10 \
    -input_pins \
    -file ./$project_name/post_synth_timing.rpt
puts "  Timing report       -> ./$project_name/post_synth_timing.rpt"

# -------------------------------------------------------
# Report: Critical path details (top 5 worst paths)
# -------------------------------------------------------
report_timing \
    -sort_by group \
    -max_paths 5 \
    -path_type summary \
    -file ./$project_name/critical_paths.rpt
puts "  Critical paths      -> ./$project_name/critical_paths.rpt"

# -------------------------------------------------------
# Final summary
# -------------------------------------------------------
puts ""
puts "=========================================================="
puts "  OOC Synthesis + Timing Analysis Complete!"
puts "  Reports in: ./$project_name/"
puts "  Timing : post_synth_timing.rpt  (check WNS >= 0)"
puts "  Util   : synth_utilization.rpt  (LUTs, FFs, BRAM)"
puts "  Paths  : critical_paths.rpt     (top 5 worst paths)"
puts "=========================================================="
exit
