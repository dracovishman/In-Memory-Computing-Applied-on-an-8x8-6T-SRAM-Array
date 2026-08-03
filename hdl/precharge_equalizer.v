// ============================================================================
// Module: precharge_equalizer
// Description: Precharge and Equalization circuit for SRAM bitlines.
//              Pulls both BL and BL_bar to VDD (1'b1) and equalizes voltage
//              when precharge enable (pch_en) signal is active low.
// ============================================================================
`timescale 1ns / 1ps

module precharge_equalizer (
    input  wire pch_en,     // Active-low precharge enable
    inout  wire bl,         // Bitline
    inout  wire bl_bar      // Complementary Bitline
);
    // Active low PMOS precharge pull-up to VDD
    assign bl     = (!pch_en) ? 1'b1 : 1'bz;
    assign bl_bar = (!pch_en) ? 1'b1 : 1'bz;
endmodule
