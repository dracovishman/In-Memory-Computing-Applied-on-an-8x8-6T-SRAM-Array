// ============================================================================
// Module: tb_sram_8x8_imc
// Description: Verilog Testbench for 8x8 6T SRAM Array with In-Memory Computing.
//              Tests memory write, memory read, data latching, and all 4 IMC
//              operations: NAND (00), NOR (01), XOR (10), and Flush (11).
// ============================================================================
`timescale 1ns / 1ps

module tb_sram_8x8_imc;

    reg        clk;
    reg        rst_n;
    reg  [7:0] row_wl;
    reg  [2:0] col_addr;
    reg        col_dec_en;
    reg        pch_en;
    reg        we;
    reg        sa_en;
    reg        latch_en;
    reg  [1:0] op_sel;
    reg        din;

    wire       d_read_curr;
    wire       d_read_prev;
    wire       imc_out;

    // Instantiate Unit Under Test (UUT)
    sram_8x8_imc_top uut (
        .clk(clk),
        .rst_n(rst_n),
        .row_wl(row_wl),
        .col_addr(col_addr),
        .col_dec_en(col_dec_en),
        .pch_en(pch_en),
        .we(we),
        .sa_en(sa_en),
        .latch_en(latch_en),
        .op_sel(op_sel),
        .din(din),
        .d_read_curr(d_read_curr),
        .d_read_prev(d_read_prev),
        .imc_out(imc_out)
    );

    // Clock Generator (100 MHz)
    always #5 clk = ~clk;

    initial begin
        $display("=== STARTING 8x8 SRAM IN-MEMORY COMPUTING (IMC) SIMULATION ===");
        clk        = 0;
        rst_n      = 0;
        row_wl     = 8'b0;
        col_addr   = 3'b0;
        col_dec_en = 0;
        pch_en     = 1; // Inactive high
        we         = 0;
        sa_en      = 0;
        latch_en   = 0;
        op_sel     = 2'b00;
        din        = 0;

        #20 rst_n = 1;

        // Step 1: Write logic '1' to Row 0, Column 0
        $display("\n[Cycle 1] Writing '1' to Cell (Row 0, Col 0)...");
        col_addr   = 3'b000;
        col_dec_en = 1;
        row_wl     = 8'b0000_0001;
        din        = 1'b1;
        we         = 1'b1;
        #10;
        we         = 1'b0;

        // Step 2: Read Cell (Row 0, Col 0) -> Expect D_curr = 1
        $display("[Cycle 2] Precharging and Sensing Cell (Row 0, Col 0)...");
        pch_en     = 1'b0; #5; pch_en = 1'b1; // Precharge pulse
        sa_en      = 1'b1; #5;
        latch_en   = 1'b1; #10; latch_en = 1'b0; sa_en = 1'b0;
        $display("   -> Sensed D_curr = %b, Sensed D_prev = %b", d_read_curr, d_read_prev);

        // Step 3: Write logic '0' to Row 1, Column 0
        $display("\n[Cycle 3] Writing '0' to Cell (Row 1, Col 0)...");
        row_wl     = 8'b0000_0010;
        din        = 1'b0;
        we         = 1'b1;
        #10;
        we         = 1'b0;

        // Step 4: Read Cell (Row 1, Col 0) -> Expect D_curr = 0, D_prev = 1
        $display("[Cycle 4] Precharging and Sensing Cell (Row 1, Col 0)...");
        pch_en     = 1'b0; #5; pch_en = 1'b1;
        sa_en      = 1'b1; #5;
        $display("   -> Sensed D_curr = %b, Latched D_prev = %b", d_read_curr, d_read_prev);

        // Step 5: Test In-Memory Computing Operations on (D_curr=0, D_prev=1)
        $display("\n[Cycle 5] Testing IMC Operations (D_curr = 0, D_prev = 1):");
        
        op_sel = 2'b00; #5; // NAND
        $display("   [Mode 00 - NAND]: NAND(0, 1) = %b (Expected: 1)", imc_out);

        op_sel = 2'b01; #5; // NOR
        $display("   [Mode 01 - NOR] : NOR(0, 1)  = %b (Expected: 0)", imc_out);

        op_sel = 2'b10; #5; // XOR
        $display("   [Mode 10 - XOR] : XOR(0, 1)  = %b (Expected: 1)", imc_out);

        op_sel = 2'b11; #5; // Flush
        $display("   [Mode 11 - FLUSH]: FLUSH     = %b (Expected: 0)", imc_out);

        $display("\n=== 8x8 SRAM IMC SIMULATION COMPLETED SUCCESSFULLY ===");
        $finish;
    end

endmodule
