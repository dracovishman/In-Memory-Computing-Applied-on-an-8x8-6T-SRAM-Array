// ============================================================================
// Module: sense_amplifier
// Description: Voltage-differential Sense Amplifier module.
//              Senses differential voltage between BL and BL_bar when
//              sense amplifier enable (sa_en) is active high, outputting
//              resolved bit logic (data_out).
// ============================================================================
`timescale 1ns / 1ps

module sense_amplifier (
    input  wire sa_en,      // Active-high Sense Amplifier Enable
    input  wire bl,         // Bitline signal
    input  wire bl_bar,     // Complementary Bitline signal
    output reg  data_out    // Sensed digital output
);
    always @(*) begin
        if (sa_en) begin
            if (bl > bl_bar)
                data_out = 1'b1;
            else if (bl < bl_bar)
                data_out = 1'b0;
            else
                data_out = 1'b0; // Default when equal
        end
    end
endmodule
