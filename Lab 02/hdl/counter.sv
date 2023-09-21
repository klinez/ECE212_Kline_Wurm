//-----------------------------------------------------------------------------
// Module Name   : counter
// Project       : RTL Hardware Design and Verification using SystemVerilog
//-----------------------------------------------------------------------------
// Author        : John Nestor  <nestorj@lafayette.edu>
// Created       : Jun 2020
//-----------------------------------------------------------------------------
// Description   : Basic binary counter with enable & sync. reset
//-----------------------------------------------------------------------------

module  counter (
    input logic clk, rst, enb,
    output logic [3:0] q,
    output logic Carry
    );

    parameter MOD = 4'd10;

    assign Carry = (q == MOD-1) && enb;

    always_ff @(posedge clk) begin
        if (rst || Carry) q <= 0;
        else if (enb) q <= q + 1;
    end
       
 //: counter
endmodule
