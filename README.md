# High-Frequency Trading (HFT) FPGA Network Parser

An ultra-low latency, 250 MHz network packet parser targeting the Xilinx Kintex-7 FPGA architecture. Designed to sit directly in the critical path of an HFT trading system, this IP core processes 128-bit AXI-Stream market data directly from an Ethernet MAC, isolates payloads, and detects sequence anomalies in real-time.

## Project Structure
- `rtl/`: SystemVerilog source code for the parser, FSM, risk layer, and lookaside tables.
- `tb/`: SystemVerilog testbenches, including 18 rigorous edge-case scenarios.
- `scripts/`: Tcl scripts for automated Vivado Out-Of-Context (OOC) synthesis and implementation.
- `mem/`: Hex files for initial memory state configurations.

## System Architecture
The parser is divided into three primary concurrent pipelines:
1. **Ingress FSM & Parser Core (Data Plane):** State machine designed for deterministic 4-clock-cycle payload extraction. Strips Ethernet/UDP headers and aligns market payloads onto a clean internal AXI-Stream bus.
2. **Lookaside Table (Memory Plane):** A highly concurrent, 4-way distributed lookup table mapped to Distributed LUT-RAM. Tracks expected sequence numbers per ticker with zero pipeline stalling.
3. **Risk Layer (Control Plane):** An out-of-band anomaly detection tap utilizing a 4-stage arithmetic pipeline. Monitors the datapath for packet regressions, drops, or sequence gaps without injecting latency into the payload forwarding path.

### Schematic & Block Diagram
[Link to Schematic Image] *(Insert schematic.png from Vivado here)*

## Performance & Implementation
- **Clock Target:** 250 MHz (4.000 ns)
- **Data Path Latency:** 4 clock cycles (Constant)
- **Worst Negative Slack (WNS):** +0.700 ns (Post-Route)
- **Device:** Xilinx Kintex-7 (`xc7k160tffg676-2`)

### Build Instructions
To reproduce the synthesis and implementation results, run the batch script from the repository root:
```bash
vivado -mode batch -source scripts/build.tcl
```
To run the verification suite:
```bash
xelab -debug typical tb_top -s tb_top_sim
xsim tb_top_sim --runall
```

### Interface & I/O Pin Mappings
Because this project is a high-speed **IP Core** (an internal silicon component) rather than a physical board-level project, the I/O ports do not map to physical copper pins on the FPGA package. 
Instead, the I/O interfaces map to standard internal FPGA buses:
- `s_axis_tdata` (128-bit): Maps internally to the output of an FPGA Ethernet MAC IP.
- `m_payload_data` (128-bit): Maps internally to the input of a PCIe DMA IP or Trading Strategy IP.
- `clk` / `reset_n`: Maps to the global clock routing network (BUFG).

Synthesizing this core Out-Of-Context (OOC) on a Kintex-7 at 250MHz proves the RTL logic is physically sound and ready for integration into a top-level HFT system.

## Project Demo
[Link to Demo Video] *(Insert YouTube/Drive link here)*
