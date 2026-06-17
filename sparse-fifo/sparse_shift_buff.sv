//============================================================
// Module: Sparse Shift Buffer
//  Tentativa de acelerar passagem de dados 
//  relevantes para MAC (vulgo diferentes de zero)
//------------------------------------------------------------
// Author: Lucas Farias Martins
// Email:  lucas.martins@ee.ufcg.edu.br
// Date:   15/06/2026
// Update: 15/06/2026
//============================================================

module sparse_shiftbuff #(
    parameter SIZE_D = 8,
    parameter SIZE_B = 8
)(
    input  logic clk,
    input  logic rst_n,
    input  logic              enb_i,
    input  logic [SIZE_D-1:0] sbuff_i,
    output logic [SIZE_D-1:0] sbuff_o
);

    localparam LOG_SB = $clog2(SIZE_B); // nesse caso eh tres

    logic [SIZE_D-1:0] shiftbuff [SIZE_B];
    logic [SIZE_D-1:0] zero_poss [LOG_SB]; 
    logic              zero_detc [LOG_SB];

    //=====================================================
    //                  COMBINATIONAL
    //=====================================================
    always_comb begin

        zero_detc[0] = (shiftbuff[1] == '0);
        zero_detc[1] = (shiftbuff[3] == '0);
        zero_detc[2] = (shiftbuff[5] == '0);

        zero_poss[0] = (zero_detc[0]) ? shiftbuff[2] : shiftbuff[1]; 
        zero_poss[1] = (zero_detc[1]) ? shiftbuff[4] : shiftbuff[3]; 
        zero_poss[2] = (zero_detc[2]) ? shiftbuff[6] : shiftbuff[5];         
    end

    //=====================================================
    //                   SEQUENCIAL
    //=====================================================
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) 
            shiftbuff <= '{default:0};
        else if (enb_i) begin
            
            shiftbuff[7] <= sbuff_i;
            shiftbuff[6] <= shiftbuff[7];

            shiftbuff[5] <= (zero_detc[0]) ? '0 : shiftbuff[6];
            shiftbuff[3] <= (zero_detc[1]) ? '0 : shiftbuff[4];
            shiftbuff[1] <= (zero_detc[2]) ? '0 : shiftbuff[2];
            
            shiftbuff[4] <= zero_poss[2];
            shiftbuff[2] <= zero_poss[1];
            shiftbuff[0] <= zero_poss[0];

        end
    end

endmodule