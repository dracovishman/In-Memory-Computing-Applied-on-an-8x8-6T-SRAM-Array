* ============================================================================
* SPICE Netlist Template: 8x8 6T SRAM with In-Memory Computing (45nm CMOS)
* Technology Library: Cadence GPDK 045nm (Vdd = 1.0V, Temp = 27C)
* ============================================================================

.include "gpdk045.scs"
.option scale=45n

* Supply Voltages
Vdd vdd 0 DC 1.0V
Vss vss 0 DC 0V

* 6T SRAM Bit-Cell Subcircuit (45nm Sizing: W_n=90n, W_p=50n, W_ax=65n)
.subckt sram_6t_cell wl bl blb vdd vss
M1 q  qb vss vss NMOS L=45n W=90n
M2 qb q  vss vss NMOS L=45n W=90n
M3 q  qb vdd vdd PMOS L=45n W=50n
M4 qb q  vdd vdd PMOS L=45n W=50n
M5 q  wl bl  vss NMOS L=45n W=65n
M6 qb wl blb vss NMOS L=45n W=65n
.ends sram_6t_cell

* Transient Analysis Setup
.tran 0.005n 10n
.measure tran avg_power AVG p(Vdd) from=0n to=10n
.measure tran compute_delay TRIG v(sa_en)=0.5V VAL=0.5V RISE=1 TARG v(compute_out)=0.5V VAL=0.5V RISE=1

.end
