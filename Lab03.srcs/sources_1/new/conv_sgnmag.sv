`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/21/2023 09:24:36 AM
// Design Name: 
// Module Name: conv_sgnmag
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


module conv_sgnmag(
        input logic [17:0] tx10,
        
        output logic [16:0] tx10_mag,
        output logic [6:0] tx10_sign
    );
  always_comb  
    begin
        if( tx10[17] == 0)
            begin
                tx10_mag = tx10[16:0];
                tx10_sign = tx10[17];
            end
        else
            begin   
                tx10_mag = ~tx10[16:0] + 1;
                tx10_sign = tx10[17];
            end
    end
endmodule
