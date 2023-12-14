`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/14/2023 12:21:29 PM
// Design Name: 
// Module Name: controller_tb
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


module controller_tb;
import mips_decls_p::*;

    logic clk, reset, zero;
    opcode_t opcode; 
    funct_t funct;
    logic pcen, memwrite, irwrite, regwrite, alusrca, iord, memtoreg, regdst;
    logic [1:0] alusrcb, pcsrc;
    logic [2:0] alucontrol;
    
    
    
    controller DUV(.clk, .reset, .opcode, .funct, .zero, 
    .pcen, .memwrite, .irwrite, .regwrite, .alusrca, .iord, .memtoreg, .regdst, .alusrcb, .pcsrc, .alucontrol);
    
    always begin
    clk = 1;
    #5;
    clk = 0;
    #5;
    end
        initial begin
            reset = 1;
            #50;
            reset = 0;
            zero = 0;
            opcode = OP_RTYPE;
            funct = F_ADD; 
            #50;
            funct = F_SUB; 
            #50;
            funct = F_AND; 
            #50;
            funct = F_OR; 
            #50;
            funct = F_SLT; 
            #50;
            opcode = OP_LW;
            #50
            opcode = OP_SW;
            #50
            opcode = OP_BEQ;
            #50
            opcode = OP_ADDI;
            #50
            opcode = OP_J;
            #50
        $stop;
    end
endmodule
