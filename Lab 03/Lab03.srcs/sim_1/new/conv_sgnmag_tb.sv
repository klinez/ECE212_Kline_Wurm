`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/21/2023 10:21:53 AM
// Design Name: 
// Module Name: conv_sgnmag_tb
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


module conv_sgnmag_tb;
        logic [17:0] tx10;
        logic [16:0] tx10_mag;
        logic tx10_sign;
        
        conv_sgnmag DUV (.tx10, .tx10_mag, .tx10_sign);
        
        initial begin
        $timeformat(-9,2," ns");
        tx10 = 1023.125;
        #10;
        tx10 = -123.637;
        #10;
        tx10 = 1049.20;
        #10;
        tx10 = -3000;
        #10;
        tx10 = 4095.204;
        #10;
        tx10 = -8000;
        #10;
        tx10 = 8191.301;
        #10;
        $stop;
        end
        

endmodule
