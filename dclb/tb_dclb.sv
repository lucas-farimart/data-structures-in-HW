//=====================================================================
// Testbench: Stack de neuronios
//---------------------------------------------------------------------
// Author: Lucas Farias Martins
// Email:  lucas.martins@ee.ufcg.edu.br
// Date:   07/05/2026
//=====================================================================

`timescale 1ns/1ns

module tb_dclb;

    localparam WORD_W = 8;
    localparam DEPTH  = 16;
    localparam ADDR_W = $clog2(DEPTH+1);

    //========================================================
    // Sinais
    //========================================================
    logic clk;
    logic rst_n;
    logic push;
    logic pop;
    logic recirc_push;
    logic recirc_pop;
    logic full;
    logic empty;

    logic signed [WORD_W-1:0] data_in;
    logic signed [WORD_W-1:0] data_head;
    logic signed [WORD_W-1:0] data_tail;

    //========================================================
    // DUT
    //========================================================
    dcl_buffer #(
        .WORD_W        ( WORD_W       ),
        .DEPTH         ( DEPTH        )
    ) dclb_u (
        .clk           ( clk          ),
        .rst_n         ( rst_n        ),
        //-----------------------------
        .push_i        ( push         ),
        .pop_i         ( pop          ),
        .recirc_push_i ( recirc_push  ),
        .recirc_pop_i  ( recirc_pop   ),
        .data_i        ( data_in      ),
        .data_head_o   ( data_head    ),
        .data_tail_o   ( data_tail    ),
        .full_o        ( full         ),
        .empty_o       ( empty        )
    );

    //========================================================
    // Clock
    //========================================================
    initial clk = 0;
    always #10 clk = ~clk;

    //========================================================
    // Tasks
    //========================================================
    task do_push(input logic signed [WORD_W-1:0] value);
        @(posedge clk);
        push    <= 1'b1;
        pop     <= 1'b0;
        data_in <= value;

        @(posedge clk);
        push    <= 1'b0;
        data_in <= '0;
    endtask

    task do_pop;
        @(posedge clk);
        push <= 1'b0;
        pop  <= 1'b1;

        @(posedge clk);
        pop <= 1'b0;
    endtask

    task do_recirc_push(int num_cycles);
        repeat(num_cycles) begin
            @(posedge clk);
            recirc_push <= 1'b1;
        end
        @(posedge clk);
        recirc_push <= 1'b0;
    endtask

    task do_recirc_pop(int num_cycles);
        repeat(num_cycles) begin
            @(posedge clk);
            recirc_pop <= 1'b1;
        end
        @(posedge clk);
        recirc_pop <= 1'b0;
    endtask

    initial begin
        forever begin
            if (recirc_pop)  $monitor("[%0t] data_head = %0d", $time, data_head);
            if (recirc_push) $monitor("[%0t] data_tail = %0d", $time, data_tail);
            @(posedge clk);
        end
    end

    initial begin

        $display("\n================================================================================ ");
        $display("     _  _                         ___ _           _     _____       _              ");
        $display("    | \\| |___ _  _ _ _ ___ _ _   / __| |_ __ _ __| |__ |_   _|__ __| |_           ");
        $display("    | .` / -_) || | '_/ _ \\ ' \\  \\__ \\  _/ _` / _| / /   | |/ -_|_-<  _|       ");
        $display("    |_|\\_\\___|\\_,_|_| \\___/_||_| |___/\\__\\__,_\\__|_\\_\\   |_|\\___/__/\\__|");
        $display("================================================================================\n ");

        rst_n = 1;

        #20ns;

        rst_n   = 0;
        data_in = 0;

        push    = 0;    recirc_push = 0;
        pop     = 0;    recirc_pop  = 0;

        repeat(5) @(posedge clk);
        rst_n = 1;

        $display("\n========================================");
        $display(" Push de alguns valores                   ");
        $display("========================================\n");

        do_push(10);
        do_push(20);
        do_push(30);
        do_push(40);
        do_push(0);
        do_push(-15);

        $display("\n========================================");
        $display(" Pop de alguns valores                    ");
        $display("========================================\n");

        do_pop();
        do_pop();

        $display("\n========================================");
        $display(" Encher/Esvaziar a stack                  ");
        $display("========================================\n");
        #500ns;

        rst_n = 0;
        rst_n = 1;

        repeat(2) begin
            while (!full)  do_push($urandom_range(-128,127));
            while (!empty) do_pop();
        end

        $display("\n========================================");
        $display(" Encher um pouco e Recircular             ");
        $display("========================================\n");
        #500ns;

        do_push(1); do_push(2);   do_push(3);   
        do_push(4); do_push(5);   do_push(6);   
        do_push(7); do_push(8);     

        repeat(2) begin
            do_recirc_pop(8);
            do_recirc_push(8);
        end

        //------------------------------------------
        // Reset do controle (Push + Pop)
        //------------------------------------------
        repeat(20) @(posedge clk);

        push <= 1'b1; pop <= 1'b1;
        @(posedge clk);
        push <= 1'b0; pop <= 1'b0;

        repeat(20) @(posedge clk);
        //------------------------------------------
        // Estado final
        //------------------------------------------
        #500ns;
        $display("\n========================================");
        $display(" Estado final");
        $display("========================================");
        $display("full       = %0b", full);
        $display("empty      = %0b", empty);
        $display("s_ptr      = %0d", stack_u.s_ptr);
        $display("========================================\n");

        #20;
        $finish;
    end

endmodule
