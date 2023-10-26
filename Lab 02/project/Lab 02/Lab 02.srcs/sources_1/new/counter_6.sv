`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/07/2023 10:53:20 AM
// Design Name: 
// Module Name: counter_6
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


module counter_6 #(parameter W=2)(

    input logic clk, rst, enb,
    output logic [W-1:0] q,
    output logic [W-1:0] Carry
    );
    
    always_ff @(posedge clk)
        if (rst)   begin   
            q <= '0; 
            Carry <= '0;
        end
        else if (enb) begin
            q <= q + 1;
        end
        else if (q >= 6) begin
            q <= '0;
            Carry = Carry +1;
        end
        
endmodule
