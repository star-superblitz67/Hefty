# timing.xdc - Xilinx Design Constraints for FPGA Parser

# Create a 250 MHz clock (4 ns period)
create_clock -period 4.000 -name clk [get_ports clk]

# Tell Vivado OOC synthesis to assume the clock comes from a global clock buffer
# This fixes the [Timing 38-242] HD.CLK_SRC warning
set_property HD.CLK_SRC BUFGCTRL_X0Y0 [get_ports clk]

# No physical board targeted — downgrade unplaced-IO errors to warnings so
# implementation and bitstream generation can complete without pin assignments.
set_property SEVERITY {Warning} [get_drc_checks NSTD-1]
set_property SEVERITY {Warning} [get_drc_checks UCIO-1]
