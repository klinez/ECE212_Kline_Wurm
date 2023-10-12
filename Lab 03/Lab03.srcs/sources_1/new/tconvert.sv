`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/21/2023 09:24:36 AM
// Design Name: 
// Module Name: tconvert
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tconvert(
    input logic signed [12:0] tc,
    input logic [6:0]c_f,
    output logic signed [17:0] tx10
    );
    
    logic signed [17:0] tx16, tx2;
    logic [14:0] temp_display;
    
    
    always_comb
        begin

                if (c_f == 0)
                begin
                    tx10 = ((tc << 3) + (tc << 1));
                end

                else
                begin
                    tx16 = tc << 4;
                    tx2 = tc << 1;
                    tx10 = tx16 + tx2 + {14'd320, 4'b0000};
                end
        end  
endmodule
