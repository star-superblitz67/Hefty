# Ultra-Low Latency 250MHz FPGA Network Parser

## Project Overview (What I Built):
I built a hardware-accelerated, highly pipelined network packet parser targeting the Xilinx Kintex-7 FPGA architecture. Designed to sit directly in the critical path of a high-speed data network, this IP core physically processes 128-bit AXI-Stream packet data directly from an Ethernet MAC, isolates payloads, and detects sequence anomalies in real-time. 

## Features Implemented:
- **Ultra-Low Latency:** Constant 4-clock-cycle data latency from the last beat of a network packet arriving to the clean payload being forwarded.
- **Zero-Gap Processing:** Sustains back-to-back 128-bit packet bursts with zero inter-packet gaps or stalling.
- **Hardware-Accelerated Risk:** Real-time sequence regression, dropping, and gap detection flagged out-of-band to prevent bad data propagation.
- **250 MHz Timing Closure:** Fully pipelined and proven to achieve `WNS > 0` at a 4.0 ns period on a Kintex-7 (`xc7k160tffg676-2`).

## System Architecture (How I Built It):
This project was built from scratch using SystemVerilog. The parser is divided into three primary concurrent hardware pipelines:
1. **Ingress FSM (Data Plane):** A deterministic state machine that strips Ethernet/UDP headers and aligns payloads onto a clean internal AXI-Stream bus.
2. **Lookaside Table (Memory Plane):** A highly concurrent, 4-way distributed lookup table mapped to Distributed LUT-RAM. It tracks expected sequence numbers per ticker with zero pipeline stalling.
3. **Risk Layer (Control Plane):** An out-of-band anomaly detection tap utilizing a custom 4-stage arithmetic pipeline to monitor the datapath without injecting latency into the payload forwarding path.

### Schematic & Block Diagram:
 The schematic and block diagram are present inside the docs/ folder.

## Build & Synthesis (How to Deploy It):
Because this is an FPGA IP Core, "deployment" consists of Out-Of-Context (OOC) Synthesis and Place & Route (Implementation). 

To reproduce the synthesis and implementation results, run the batch script from the repository root:
```bash
vivado -mode batch -source scripts/build.tcl
```
To run the rigorous 18-scenario verification suite:
```bash
xelab -debug typical tb_top -s tb_top_sim
xsim tb_top_sim --runall
```

### Interface & I/O Pin Mappings:
As this project is a high-speed **IP Core**, the I/O ports do not map to physical copper pins on the FPGA package (like LEDs or buttons). Instead, the I/O interfaces map to standard internal FPGA buses:
- `s_axis_tdata` (128-bit): Maps internally to the output of an FPGA Ethernet MAC IP.
- `m_payload_data` (128-bit): Maps internally to the input of a PCIe DMA IP.

## What Makes It Special (Originality & Completeness):
While most network parsers are written in software (C++/Python) and process data in microseconds, this project operates entirely in hardware at the nanosecond level. 
Instead of relying on monolithic BRAM structures which introduce memory read latency, this architecture utilizes highly optimized **Distributed LUT-RAM** (`ram_style = "distributed"`). By segmenting high-fanout carry chains into a localized 4-stage pipeline, the design successfully achieves Post-Route Timing Closure (Positive Slack) at 250MHz. It is a complete, enterprise-grade hardware solution verified against 18 distinct edge-case network scenarios.
