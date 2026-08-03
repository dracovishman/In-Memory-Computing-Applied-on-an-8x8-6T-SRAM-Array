// ============================================================================
// Module: sram_6t_cell
// Description: Behavioral model of a 6-Transistor (6T) SRAM Bit-Cell.
//              Contains cross-coupled inverters for bi-stable storage
//              and two access transistors controlled by the Wordline (WL).
// ============================================================================
`timescale 1ns / 1ps

module sram_6t_cell (
    input  wire wl,         // Wordline activation signal
    inout  wire bl,         // Bitline
    inout  wire bl_bar      // Complementary Bitline
);
    reg storage_q;
    reg storage_qb;

    initial begin
        storage_q  = 1'b0;
        storage_qb = 1'b1;
    end

    // Read / Write operation over bitlines when WL is active
    assign bl     = (wl) ? storage_q  : 1'bz; // High impedance when unselected
    assign bl_bar = (wl) ? storage_qb : 1'bz;

    // Write behavior: when WL is high and bitlines are strongly driven
    always @(wl or bl or bl_bar) begin
        if (wl) begin
            if (bl === 1'b1 && bl_bar === 1'b0) begin
                storage_q  <= 1'b1;
                storage_qb <= 1'b0;
            end else if (bl === 1'b0 && bl_bar === 1'b1) begin
                storage_q  <= 1'b0;
                storage_qb <= 1'b1;
            end
        end
    end
endmodule
