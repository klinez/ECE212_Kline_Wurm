`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/14/2023 09:46:16 AM
// Design Name: 
// Module Name: dig_clock_top
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


module dig_clock_top(
    input logic btn_l, btn_r, btn_d, clk,
    output logic [7:0] an_n,
    output logic [6:0] segs_n,
    output logic dp_n
    );
    

    
    logic [6:0] h1, h0, m1, m0, s1, s0, am_pm;
    
    dig_clock U_clock(.clk, .rst(btn_d), .adv_hr(btn_l), .adv_min(btn_r),.am_pm, .h1(h1), .h0(h0), .m1(m1), .m0(m0), .s1(s1), .s0(s0));
    sevenseg_ctl U_sevseg(.clk, .rst(btn_d), .d7(h1), .d6(h0), .d5(m1), .d4(m0), .d3(s1), .d2(s0), .d1(7'b1111111), .d0(am_pm), .segs_n, .an_n, .dp_n);
endmodule
