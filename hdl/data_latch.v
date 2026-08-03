// ============================================================================
// Module: data_latch
// Description: D-Latch connected to sense amplifier output to retain
//              the previous read value (D_prev) across read cycles for IMC.
// ============================================================================
`timescale 1ns / 1ps

module data_latch (
    input  wire clk,        // Latch clock / strobe
    input  wire rst_n,      // Active-low reset
    input  wire latch_en,   // Latch enable
    input  wire d_in,       // Current sense amplifier output (D_curr)
    output reg  d_prev      // Retained previous cycle read value
);
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            d_prev <= 1'b0;
        end else if (latch_en) begin
            d_prev <= d_in;
        end
    end
endmodule
