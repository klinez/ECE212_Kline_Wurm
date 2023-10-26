`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/31/2023 08:50:36 AM
// Design Name: 
// Module Name: sevenseg_ext_n
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


module sevenseg_ext_n(
    input logic [6:0] d,
    output logic [6:0] segs_n,
    output logic dp_n
    );
    
    always_comb begin
    
        if (d[6]) begin
            segs_n = 7'b1111111;
            dp_n = 1;
        end
   
        else begin
            dp_n = !d[5];
            if(d[4]) segs_n = 7'b0111111;
        
        else case (d[3:0])     //  gfedcba
            7'd0: segs_n = 7'b1000000;
            7'd1: segs_n = 7'b1111001;
            7'd2: segs_n = 7'b0100100;
            7'd3: segs_n = 7'b0110000;
            7'd4: segs_n = 7'b0011001;
            7'd5: segs_n = 7'b0010010;
            7'd6: segs_n = 7'b0000010;
            7'd7: segs_n = 7'b1111000;
            7'd8: segs_n = 7'b0000000;
            7'd9: segs_n = 7'b0010000;
            7'd10: segs_n = 7'b0001000;
            7'd11: segs_n = 7'b0001100;
            7'd12: segs_n = 7'b1000110;
            7'd15: segs_n = 7'b0001110;
            default: segs_n = 7'b1111111;
        endcase
        end
     end
    
endmodule
