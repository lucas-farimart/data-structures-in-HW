//============================================================
// Testbench - sparse_shiftbuff
//------------------------------------------------------------
// Author: Lucas Farias Martins
// Email:  lucas.martins@ee.ufcg.edu.br
// Date:   15/06/2026
// Update: 16/06/2026
//============================================================

`timescale 1ns/1ns

module tb_sparseFIFO;

    localparam SIZE_D = 8;
    localparam SIZE_B = 8;

    logic clk;
    logic rst_n;

    logic              enb_i;
    logic [SIZE_D-1:0] sbuff_i;
    logic [SIZE_D-1:0] sbuff_o;

    //===========================================
    //  DUT INSTANCE
    //===========================================
    sparse_shiftbuff #(
        .SIZE_D   ( SIZE_D    ),
        .SIZE_B   ( SIZE_B    )
    ) dut (
        .clk      ( clk       ),
        .rst_n    ( rst_n     ),
        .enb_i    ( enb_i     ),
        .sbuff_i  ( sbuff_i   ),
        .sbuff_o  ( sbuff_o   )
    );

    //===========================================
    // Clock
    //===========================================
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    //===========================================
    // Stimulus vector
    //===========================================
    logic [7:0] data_vec [32];

    initial begin
        // aproximadamente 50% zeros
        data_vec = '{
             0, 11,  0, 25,
            33,  0,  0, 14,
             9,  0, 77,  0,
             0, 52,  0, 88,
            17,  0,  0, 23,
            91,  0,  0,  7,
             5,  0, 61,  0,
             0, 42,  0, 13
        };

        data_vec = '{ 0, 11, 0, 25,33, 0, 0, 14, 9, 0, 77, 0, 0, 52, 0, 88,17, 0, 0, 23,91, 0, 0, 7, 5, 0, 61, 0, 0, 42, 0, 13};

        // data_vec = '{
        //      0,  0,  0, 11,
        //      0,  0,  0, 22,
        //      0,  0,  0, 33,
        //      0,  0,  0, 44,
        //      0,  0,  0, 55,
        //      0,  0,  0, 66,
        //      0,  0,  0, 77,
        //      0,  0,  0, 88
        // };

    end

    //===========================================
    //                  Dump
    //===========================================
    task print_buffer();
        $write("[%0t] IN=%0d | ", $time, sbuff_i);
        for(int i=0;i<SIZE_B;i++)
            $write("%0d ", dut.shiftbuff[i]);
        $display("");
    endtask

    //===========================================
    //                  Main
    //===========================================

    initial begin

        $display("  ___                          ___ ___ ___ ___    _____       _        ");
        $display(" / __|_ __  __ _ _ _ ___ ___  | __|_ _| __/ _ \\  |_   _|__ __| |_     ");
        $display(" \\__ \\ '_ \\/ _` | '_(_-</ -_) | _| | || _| (_) |   | |/ -_|_-<  _|  ");
        $display(" |___/ .__/\\__,_|_| /__/\\___| |_| |___|_| \\___/    |_|\\___/__/\\__|");
        $display("     |_|                                                               ");

        rst_n   = 0;
        enb_i   = 0;
        sbuff_i = 0;

        repeat(5) @(posedge clk);
        rst_n = 1;

        repeat(2) @(posedge clk);
        enb_i = 1;

        for(int k=0; k<32; k++) begin
            sbuff_i = data_vec[k];
            @(posedge clk);
            print_buffer();
        end

        repeat(10) begin
            sbuff_i = 0;
            @(posedge clk);
            print_buffer();
        end

        #1us  $finish;

    end

endmodule