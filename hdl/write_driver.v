// ============================================================================
// Module: write_driver
// Description: Write driver module that pulls down one of the bitlines
//              (BL or BL_bar) based on input data (din) when write enable (we)
//              is asserted.
// ============================================================================
`timescale 1ns / 1ps

module write_driver (
    input  wire we,         // Active-high Write Enable
    input  wire din,        // Input data to write
    inout  wire bl,         // Bitline
    inout  wire bl_bar      // Complementary Bitline
);
    assign bl     = (we) ?  din  : 1'bz;
    assign bl_bar = (we) ? ~din  : 1'bz;
endmodule
