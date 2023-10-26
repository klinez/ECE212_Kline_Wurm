`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/21/2023 10:41:44 AM
// Design Name: 
// Module Name: tdisplay
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


module tdisplay(
    input logic [12:0] tc,
    input logic [6:0] c_f,
    output logic [6:0] tx10_sign,
    output logic [3:0] thousands, hundreds, tens, ones
    );
    logic [17:0] tx10;
    logic [16:0] tx10_mag;
    logic [12:0] tx10_mag_r;
    
    tconvert U_convert(.tc,.c_f,.tx10(tx10)); 
    conv_sgnmag U_signmag(.tx10(tx10),.tx10_sign,.tx10_mag(tx10_mag));
    round U_round(.tx10_mag(tx10_mag),.tx10_mag_r(tx10_mag_r));
    dbl_dabble_ext U_dabble(.tx10_mag_r(tx10_mag_r),.thousands,.hundreds,.tens,.ones);

endmodule
