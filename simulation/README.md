# Cadence Virtuoso Simulation Results & Analysis

This directory contains the timing, power, and technology scaling metrics extracted from Cadence Virtuoso ADE-L Spectre simulations for the 8×8 6T SRAM In-Memory Computing macro across **180 nm**, **90 nm**, and **45 nm** CMOS technology libraries.

## Summary Results Table

| Technology Node | $V_{DD}$ (V) | Average Power (mW) | Read & Compute Delay (ns) | Power Reduction (%) | Speedup Factor vs 180nm |
| :--- | :---: | :---: | :---: | :---: | :---: |
| **180 nm CMOS** | 1.8 V | 35.69 mW | 10.690 ns | Baseline (0.0%) | 1.00× |
| **90 nm CMOS** | 1.2 V | 16.81 mW | 0.397 ns | **52.90%** | **26.93×** |
| **45 nm CMOS** | 1.0 V | 0.185 mW | 0.510 ns | **99.48%** | **20.96×** |

## Scaling Observations & Key Findings

1. **Power Efficiency**:
   - Shrinking node size from 180 nm to 45 nm yields a **99.48% reduction in total average power** (from 35.69 mW down to 0.185 mW).
   - This massive reduction stems from reduced supply voltage ($1.8\text{V} \rightarrow 1.0\text{V}$), smaller gate capacitances, and scaled transistor widths.

2. **Compute Latency & Speed**:
   - The latched-to-computed output delay improves drastically from **10.69 ns at 180 nm** to **0.397 ns at 90 nm** ($>26\times$ speedup) due to faster transistor switching and reduced parasitics.
   - At 45 nm, delay exhibits a slight increase to **0.510 ns**. This behavior is driven by increased interconnect resistance-capacitance (RC) overheads, higher subthreshold leakage currents, and reduced gate overdrive ($V_{GS} - V_{TH}$) headroom in deep-submicron nodes.
