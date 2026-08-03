// ============================================================================
// Module: imc_compute_block
// Description: In-Memory Computing (IMC) Logic Compute Block.
//              Executes 2-input bitwise logic operations between current
//              read data (d_curr) and latched previous read data (d_prev)
//              based on 2-bit operation selection input op_sel[1:0]:
//                00 -> NAND (d_curr, d_prev)
//                01 -> NOR  (d_curr, d_prev)
//                10 -> XOR  (d_curr, d_prev)
//                11 -> Flush (Reset / Clear to 1'b0)
// ============================================================================
`timescale 1ns / 1ps

module imc_compute_block (
    input  wire       d_curr,     // Current cycle read value
    input  wire       d_prev,     // Latched previous cycle read value
    input  wire [1:0] op_sel,     // 2-bit Operation Selector S[1:0]
    output reg        compute_out // In-Memory Compute Result
);
    always @(*) begin
        case (op_sel)
            2'b00: compute_out = ~(d_curr & d_prev); // NAND mode
            2'b01: compute_out = ~(d_curr | d_prev); // NOR mode
            2'b10: compute_out =  (d_curr ^ d_prev); // XOR mode
            2'b11: compute_out = 1'b0;               // Flush mode (Reset output)
            default: compute_out = 1'b0;
        endcase
    end
endmodule
