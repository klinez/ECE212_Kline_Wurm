`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/21/2023 10:09:28 AM
// Design Name: 
// Module Name: round_tb
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


module round_tb;
        logic [16:0] tx10_mag;
        
        logic [12:0] tx10_mag_r;
        round DUV (.tx10_mag, .tx10_mag_r);
        initial begin
        $timeformat(-9,2," ns");
        tx10_mag = 1023.125;
        #10;
        tx10_mag = 123.602;
        #10;
        tx10_mag = 1049.032;
        #10;
        tx10_mag = 3000.1;
        #10;
        tx10_mag = 409.55;
        #10;
        tx10_mag = 8000.5;
        #10;
        tx10_mag = 8191.125;
        #10;
        $stop;
        end
endmodule
