`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/07/2023 08:55:27 AM
// Design Name: 
// Module Name: sevenseg_ctl_top
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


module sevenseg_ctl_top(
    input logic clk, rst,
    input logic [6:0] d7, d6, d5, d4, d3, d2, d1, d0,
    output logic [6:0] segs_n,
    output logic dp_n,
    output logic [7:0] an_n
    );
    sevenseg_ctl U_PS(.clk, .rst, .d7, .d6, .d5, .d4, .d3, .d2, .d1, .d0, .segs_n, .dp_n);
endmodule
