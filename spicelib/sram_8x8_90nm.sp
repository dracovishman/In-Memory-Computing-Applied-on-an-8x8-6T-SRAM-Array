* ============================================================================
* SPICE Netlist Template: 8x8 6T SRAM with In-Memory Computing (90nm CMOS)
* Technology Library: Cadence GPDK 090nm (Vdd = 1.2V, Temp = 27C)
* ============================================================================

.include "gpdk090.scs"
.option scale=90n

* Supply Voltages
Vdd vdd 0 DC 1.2V
Vss vss 0 DC 0V

* 6T SRAM Bit-Cell Subcircuit (90nm Sizing: W_n=180n, W_p=100n, W_ax=140n)
.subckt sram_6t_cell wl bl blb vdd vss
M1 q  qb vss vss NMOS L=90n W=180n
M2 qb q  vss vss NMOS L=90n W=180n
M3 q  qb vdd vdd PMOS L=90n W=100n
M4 qb q  vdd vdd PMOS L=90n W=100n
M5 q  wl bl  vss NMOS L=90n W=140n
M6 qb wl blb vss NMOS L=90n W=140n
.ends sram_6t_cell

* Transient Analysis Setup
.tran 0.01n 20n
.measure tran avg_power AVG p(Vdd) from=0n to=20n
.measure tran compute_delay TRIG v(sa_en)=0.6V VAL=0.6V RISE=1 TARG v(compute_out)=0.6V VAL=0.6V RISE=1

.end
