# build.tcl — One-click script to synthesize and implement the parser on Kintex-7
# Run from the project root:
#   vivado -mode batch -source scripts/build.tcl
#
# We use Out-of-Context (OOC) mode because this is an IP core, not a full
# board design. OOC skips I/O pad buffers so we get pure internal timing numbers.

set part_num    "xc7k160tffg676-2"
set project_name "fpga_parser_synth"
set top_module   "top_level"

# -------------------------------------------------------
# Wipe any previous run so we start fresh
# -------------------------------------------------------
if {[file exists $project_name]} {
    file delete -force $project_name
}
file mkdir $project_name

# -------------------------------------------------------
# Grab all our source files
# -------------------------------------------------------
set sv_files [glob -nocomplain ./rtl/*.sv]
set hex_files [glob -nocomplain ./mem/*.hex]

# -------------------------------------------------------
# Run synthesis in OOC mode (no I/O buffers, just raw logic)
# -------------------------------------------------------
puts "=========================================================="
puts "  Running Out-of-Context Synthesis on $part_num"
puts "=========================================================="

# -------------------------------------------------------
# Feed all our .sv and .hex files to Vivado
# -------------------------------------------------------
foreach f $sv_files {
    read_verilog -sv $f
}
# The hex files are needed so the ticker table gets loaded
foreach f $hex_files {
    add_files $f
}

# -------------------------------------------------------
# Synthesize!
# -------------------------------------------------------
synth_design \
    -top  $top_module \
    -part $part_num   \
    -mode out_of_context

# -------------------------------------------------------
# How much of the chip are we using?
# -------------------------------------------------------
report_utilization -file ./$project_name/synth_utilization.rpt
puts "  Utilization report  -> ./$project_name/synth_utilization.rpt"

# -------------------------------------------------------
# Tell Vivado our target clock speed: 250 MHz = 4ns period
# -------------------------------------------------------
create_clock -period 4.000 -name clk [get_ports clk]

# -------------------------------------------------------
# Now physically place and route the design on the chip
# -------------------------------------------------------
puts "=========================================================="
puts "  Running Implementation (Place and Route)"
puts "=========================================================="
opt_design
place_design
route_design

# -------------------------------------------------------
# Generate the final timing and utilization reports
# -------------------------------------------------------
report_utilization -file ./$project_name/impl_utilization.rpt
puts "  Utilization report  -> ./$project_name/impl_utilization.rpt"

report_timing_summary \
    -delay_type min_max \
    -report_unconstrained \
    -check_timing_verbose \
    -max_paths 10 \
    -input_pins \
    -file ./$project_name/post_impl_timing.rpt
puts "  Timing report       -> ./$project_name/post_impl_timing.rpt"

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
puts "  OOC Synthesis + Implementation Complete!"
puts "  Reports in: ./$project_name/"
puts "  Timing : post_impl_timing.rpt   (check WNS >= 0)"
puts "  Util   : impl_utilization.rpt   (LUTs, FFs, BRAM)"
puts "=========================================================="
exit
