* ============================================================================
* SPICE Netlist Template: 8x8 6T SRAM with In-Memory Computing (180nm CMOS)
* Technology Library: Cadence GPDK 180nm (Vdd = 1.8V, Temp = 27C)
* ============================================================================

.include "gpdk180.scs"
.option scale=180n

* Supply Voltages
Vdd vdd 0 DC 1.8V
Vss vss 0 DC 0V

* 6T SRAM Bit-Cell Subcircuit (180nm Sizing: W_n=360n, W_p=180n, W_ax=270n)
.subckt sram_6t_cell wl bl blb vdd vss
M1 q  qb vss vss NMOS L=180n W=360n
M2 qb q  vss vss NMOS L=180n W=360n
M3 q  qb vdd vdd PMOS L=180n W=180n
M4 qb q  vdd vdd PMOS L=180n W=180n
M5 q  wl bl  vss NMOS L=180n W=270n
M6 qb wl blb vss NMOS L=180n W=270n
.ends sram_6t_cell

* Compute Block Logic Subcircuit (NAND, NOR, XOR, Flush)
.subckt compute_block d_curr d_prev s0 s1 compute_out vdd vss
* Selection Logic Implementation
.ends compute_block

* Transient Analysis Setup
.tran 0.05n 50n
.measure tran avg_power AVG p(Vdd) from=0n to=50n
.measure tran compute_delay TRIG v(sa_en)=0.9V VAL=0.9V RISE=1 TARG v(compute_out)=0.9V VAL=0.9V RISE=1

.end
