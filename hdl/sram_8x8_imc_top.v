// ============================================================================
// Module: sram_8x8_imc_top
// Description: Top-Level 8x8 6T SRAM Array with In-Memory Computing (IMC) Peripheral.
//              Integrates:
//              - 8x8 SRAM Bit-cell matrix
//              - 3-to-8 Column Decoder
//              - Precharge & Equalizer stages
//              - Write Drivers
//              - Differential Sense Amplifiers
//              - Data Latch for prior cycle storage
//              - IMC Compute Logic Block (NAND, NOR, XOR, Flush)
// ============================================================================
`timescale 1ns / 1ps

module sram_8x8_imc_top (
    input  wire       clk,          // System clock
    input  wire       rst_n,        // Active-low reset
    input  wire [7:0] row_wl,       // 8 Wordlines (Row selection)
    input  wire [2:0] col_addr,     // 3-bit Column address
    input  wire       col_dec_en,   // Column decoder enable
    input  wire       pch_en,       // Active-low precharge enable
    input  wire       we,           // Write enable
    input  wire       sa_en,        // Sense amplifier enable
    input  wire       latch_en,     // Latch update enable
    input  wire [1:0] op_sel,       // IMC operation selector [NAND, NOR, XOR, Flush]
    input  wire       din,          // Input data bit for write
    output wire       d_read_curr,  // Sensed current read bit
    output wire       d_read_prev,  // Latched previous read bit
    output wire       imc_out       // In-Memory Compute Result
);

    wire [7:0] col_sel;
    wire [7:0] bitlines;
    wire [7:0] bitlines_bar;

    // Instantiate 3-to-8 Column Decoder
    column_decoder_3to8 col_dec_inst (
        .enable(col_dec_en),
        .sel(col_addr),
        .col_sel(col_sel)
    );

    // Instantiate 8 columns of 6T SRAM Bit-Cells & Peripherals
    genvar r, c;
    generate
        for (c = 0; c < 8; c = c + 1) begin : COL
            // Precharge & Equalizer per column
            precharge_equalizer pch_inst (
                .pch_en(pch_en),
                .bl(bitlines[c]),
                .bl_bar(bitlines_bar[c])
            );

            // Write driver per column (enabled when column selected and WE active)
            write_driver wr_inst (
                .we(we & col_sel[c]),
                .din(din),
                .bl(bitlines[c]),
                .bl_bar(bitlines_bar[c])
            );

            // 8 Row cells per column
            for (r = 0; r < 8; r = r + 1) begin : ROW
                sram_6t_cell sram_cell_inst (
                    .wl(row_wl[r] & col_sel[c]),
                    .bl(bitlines[c]),
                    .bl_bar(bitlines_bar[c])
                );
            end
        end
    endgenerate

    // Selected Column Bitline Routing
    wire selected_bl     = bitlines[col_addr];
    wire selected_bl_bar = bitlines_bar[col_addr];

    // Sense Amplifier Instance
    sense_amplifier sa_inst (
        .sa_en(sa_en),
        .bl(selected_bl),
        .bl_bar(selected_bl_bar),
        .data_out(d_read_curr)
    );

    // Data Latch Instance (Holds previous cycle read)
    data_latch latch_inst (
        .clk(clk),
        .rst_n(rst_n),
        .latch_en(latch_en),
        .d_in(d_read_curr),
        .d_prev(d_read_prev)
    );

    // IMC Compute Block Instance
    imc_compute_block compute_inst (
        .d_curr(d_read_curr),
        .d_prev(d_read_prev),
        .op_sel(op_sel),
        .compute_out(imc_out)
    );

endmodule
