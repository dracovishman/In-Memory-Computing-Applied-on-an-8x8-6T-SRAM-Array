# Contributing Guidelines

Thank you for your interest in contributing to the **In-Memory Computing (8x8 6T SRAM)** project!

## How to Contribute

1. **Bug Reports & Feature Requests**: Open an issue describing the bug or proposed enhancement in circuit architecture, Verilog models, or Cadence simulation setups.
2. **Circuit / HDL Updates**:
   - Keep Verilog code compliant with IEEE 1364-2001 / IEEE 1800 standards.
   - Maintain clear signal naming conventions (`clk`, `rst_n`, `wordline`, `bitline`, `bitline_bar`, `sa_enable`, `op_sel`).
   - Include testbench assertions when adding new compute functions or peripheral stages.
3. **Cadence Virtuoso / SPICE Netlists**:
   - Store SPICE netlist templates in `spicelib/`.
   - Specify transistor technology library node parameters (180 nm, 90 nm, 45 nm GPDK).
   - Document ADE-L simulation stimuli and transient time steps.

## Citation

If you use this repository or research report in your work, please cite:
```bibtex
@article{gupta2026imc_sram,
  title={Comparative Study of In-Memory Computing in an 8x8 6T SRAM Array across 180 nm, 90 nm and 45 nm CMOS Technology Libraries},
  author={Gupta, Subham Prasad and Solomon, Jairus S. and Salunke, Vinayak S.},
  institution={VIT Chennai},
  year={2026}
}
```
