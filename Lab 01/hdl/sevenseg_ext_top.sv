`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/31/2023 10:25:43 AM
// Design Name: 
// Module Name: sevenseg_ext_top
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


module sevenseg_ext_top(
    input logic [6:0] d,
    output logic [6:0] segs_n,
    output logic dp_n,
    output logic [7:0] an_n
    );
    
    sevenseg_ext_n U_PS(.d, .segs_n, .dp_n);
    assign an_n = 8'b11111110;
endmodule
