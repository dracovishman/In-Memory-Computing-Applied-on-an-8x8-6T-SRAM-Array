// ============================================================================
// Module: column_decoder_3to8
// Description: 3-to-8 active-high Column Decoder for selecting 1 of 8 SRAM columns.
// ============================================================================
`timescale 1ns / 1ps

module column_decoder_3to8 (
    input  wire       enable,    // Decoder enable
    input  wire [2:0] sel,       // 3-bit column select address
    output reg  [7:0] col_sel    // 8-bit column selection lines
);
    always @(*) begin
        if (enable) begin
            col_sel = 8'b0000_0001 << sel;
        end else begin
            col_sel = 8'b0000_0000;
        end
    end
endmodule
