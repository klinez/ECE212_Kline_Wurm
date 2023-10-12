`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/21/2023 10:27:50 AM
// Design Name: 
// Module Name: tconvert_tb
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


module tconvert_tb;
    logic [12:0] tc;
    logic c_f;
    logic [17:0] tx10;
    tconvert DUV(.tc,.c_f,.tx10);
    
    initial begin
        $timeformat(-9,2," ns");
        tc = 1023.125;
        c_f = 0;
        #10;
        tc = -123.637;
        c_f = 1;
        #10;
        tc = 1049.20;
        c_f = 0;
        #10;
        tc = -3000;
        c_f = 1;
        #10;
        tc = 4095.204;
        c_f = 0;
        #10;
        tc = -8000;
        c_f = 1;
        #10;
        tc = 8191.301;
        c_f = 0;
        #10;
        $stop;
        end
endmodule
