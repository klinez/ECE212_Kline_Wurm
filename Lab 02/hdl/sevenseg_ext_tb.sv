`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/31/2023 09:09:51 AM
// Design Name: 
// Module Name: sevenseg_ext_tb
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


module sevenseg_ext_tb;
logic [6:0] d, segs_n;
logic dp_n ;
    
    sevenseg_ext_n DUV(.d, .segs_n, .dp_n);
    
 initial begin
    d = 7'd64;
    #10
    d = 7'd0;   
    #10
    d = 7'd1;
    #10
    d = 7'd2;
    #10
    d = 7'd3;
    #10
    d = 7'd4;
    #10
    d = 7'd5;
    #10
    d = 7'd6;
    #10
    d = 7'd7;
    #10
    d = 7'd8;
    #10
    d = 7'd9;
    #10
    d = 7'd10;
    #10
    d = 7'd11;
    #10
    d = 7'd12;
    #10
    d = 7'd32;
    #10
    d = 7'd15;
    #10
    d = 7'd16;
    #10
    d = 7'd70;
    #10
    d = 7'd18;
    #10
    d = 7'd40;
    #10
    $stop;
    end
endmodule
