# Cadence Virtuoso & SPICE Netlist Library

This directory contains representative SPICE / Spectre netlist templates for simulating the 8×8 6T SRAM In-Memory Computing (IMC) architecture across **180 nm**, **90 nm**, and **45 nm** CMOS technology nodes.

## Technology Nodes & PDK Specifications

| Technology Node | Supply Voltage ($V_{DD}$) | Model Card Reference | Sense Amp Strobe Window |
| :--- | :---: | :---: | :---: |
| **180 nm CMOS** | 1.8 V | GPDK 180nm | 2.5 ns |
| **90 nm CMOS** | 1.2 V | GPDK 090nm | 0.2 ns |
| **45 nm CMOS** | 1.0 V | GPDK 045nm | 0.15 ns |

## Simulation Steps in Cadence Virtuoso ADE-L

1. Open Cadence Virtuoso Layout/Schematic Editor:
   ```bash
   virtuoso &
   ```
2. Import or reference the target PDK (`gpdk180`, `gpdk090`, or `gpdk045`).
3. Load the corresponding netlist from `spicelib/sram_8x8_<node>.sp`.
4. Open **ADE-L (Analog Design Environment - L)**:
   - Analysis: `.tran 0.1n 50n`
   - Select Outputs: `d_read_curr`, `d_read_prev`, `imc_out`, and current probe `I(VDD)`.
5. Run Spectre transient simulation and open **Visualization & Analysis Tool (Wavescan)** to plot power and delay waveforms.
