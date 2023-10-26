`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/21/2023 10:53:08 AM
// Design Name: 
// Module Name: lab03_top
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


module lab03_top(
 input logic clk, rst, c_f, switch,
 input logic [12:0] temp_sub,
 output logic [7:0] an_n,
 output logic [6:0] segs_n,
 output logic dp_n,
 inout tmp_scl, 
 inout tmp_sda 
 );
 logic tmp_rdy, tmp_err, tx10_sign; 
 logic [12:0] temp, temp_sel;
 logic[3:0] thousands, hundreds, tens, ones, temp_sign;
 logic [6:0] d5, thousands_disp, hundreds_disp;
 
 always_comb begin
     if (switch) temp_sel = temp_sub;
     else temp_sel = temp;
     
     if(c_f) temp_sign = 4'hf;
     else temp_sign = 4'hc;
     
     if (tx10_sign) begin
        if(thousands) d5 = 7'b0111111;
        else d5 = 7'b1111111;
        if(thousands == 0 && hundreds) thousands_disp = 7'b0111111;
        else if(thousands == 0 && hundreds == 0) begin
            hundreds_disp = 7'b0111111;
            thousands_disp = 7'b1111111;
            end
        else begin
        thousands_disp = thousands;
        hundreds_disp = hundreds;
        end
     end
     else d5 = 7'b1111111;
     if(tx10_sign == 0) begin
        if(thousands == 0) thousands_disp = 7'b1111111;
        else thousands_disp = thousands;
        if (thousands == 0 && hundreds == 0) hundreds_disp = 7'b1111111;
        else hundreds_disp = hundreds;
     end
 end


 TempSensorCtl U_TSCTL (
 .TMP_SCL(tmp_scl), .TMP_SDA(tmp_sda), .TEMP_O(temp),
 .RDY_O(tmp_rdy), .ERR_O(tmp_err), .CLK_I(clk),
 .SRST_I(rst)
 );
 
 
 tdisplay U_display(.tc(temp_sel),.c_f,.tx10_sign,.thousands(thousands),.hundreds(hundreds),.tens(tens),.ones(ones));
 sevenseg_ctl U_segment(.clk(clk),.rst(rst),.d7(7'b1111111),.d6(7'b1111111),.d5,.d4(thousands_disp),.d3(hundreds_disp),.d2(tens),.d1(ones),.d0(temp_sign),.segs_n(segs_n),.dp_n(dp_n),.an_n(an_n));
 


endmodule
