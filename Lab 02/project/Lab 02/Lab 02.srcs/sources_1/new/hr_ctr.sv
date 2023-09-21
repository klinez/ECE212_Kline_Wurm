`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/14/2023 10:18:31 AM
// Design Name: 
// Module Name: hr_ctr
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


module hr_ctr(
    input logic clk, rst, enb,
    output logic [6:0] h1, h0, am_pm
    );
    
    logic [3:0] hrct;
    
    always_ff @(posedge clk) begin
        if(rst) begin
            h1 = 1;
            h0 = 2;
            am_pm = 7'd10;
        end
        else if (enb) begin
            if(h1 == 1 && h0 == 2)begin
                h1 = 0;
                h0 = 1;
            end
            else if(h1 == 0 && h0 == 1)begin
                h0 = 2;
            end
            else if(h1 == 0 && h0 == 2)begin
                h0 = 3;
            end
            else if(h1 == 0 && h0 == 2)begin
                h0 = 3;
            end
            else if(h1 == 0 && h0 == 3)begin
                h0 = 4;
            end
            else if(h1 == 0 && h0 == 4)begin
                h0 = 5;
            end
            else if(h1 == 0 && h0 == 5)begin
                h0 = 6;
            end
            else if(h1 == 0 && h0 == 6)begin
                h0 = 7;
            end
            else if(h1 == 0 && h0 == 7)begin
                h0 = 8;
            end
            else if(h1 == 0 && h0 == 8)begin
                h0 = 9;
            end
            else if(h1 == 0 && h0 == 9)begin
                h1 = 1;
                h0 = 0;
            end
            else if(h1 == 1 && h0 == 0)begin
                h1 = 1;
                h0 = 1;
            end
            else if(h1 == 1 && h0 == 1 && am_pm == 7'd10)begin
                h1 = 1;
                h0 = 2;
                am_pm = 7'd11;
            end
            else if(h1 == 1 && h0 == 1 && am_pm == 7'd11)begin
                h1 = 1;
                h0 = 2;
                am_pm = 7'd10;
            end
        end
    end
    
endmodule
