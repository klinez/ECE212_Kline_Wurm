//--------------------------------------------------------------------
// datapath.sv - Multicycle MIPS datapath
// David_Harris@hmc.edu 23 October 2005
// David_Harris@hmc.edu 23 October 2005
// Updated to SystemVerilog dmh 12 November 2010
// Refactored into separate files & updated using additional SystemVerilog
// features by John Nestor May 2018
// Key modifications to this module:
//  1. Use enums from new package to make opcode & function codes
//     display symbolic names  during simulation
//  2. Explicitly break out and use instruction subfields (opcode, rs, rt, etc.
//
//--------------------------------------------------------------------

// The datapath unit is a structural verilog module.  That is,
// it is composed of instances of its sub-modules.  For example,
// the instruction register is instantiated as a 32-bit flopenr.
// The other submodules are likewise instantiated.

module datapath(
    input  logic        clk, reset,
    input logic         pcen, irwrite, regwrite,
    input logic         alusrca, iord, memtoreg, regdst,
    input logic [1:0]   alusrcb, pcsrc,
    input logic [2:0]   alucontrol,
    output mips_decls_p::opcode_t opcode,
    output mips_decls_p::funct_t funct,
    output logic        zero,
    output logic [31:0] adr, writedata,
    input logic [31:0]  readdata
    );


   import mips_decls_p::*;

   // instruction fields
   logic [31:0]                     instr, pcnext, pc, data, regresult, rega, regb, a, srca, srcb, aluresult, aluout, pcjump, signimm, shiftsignimm;
   logic [4:0]                      rs, rt, rd;  // register fields
   logic [15:0]                     immed;       // i-type immediate field
   logic [25:0]                     jmpimmed;    // j-type pseudo-address

  // extract instruction fields from instruction
   assign opcode = opcode_t'(instr[31:26]);
   assign funct = funct_t'(instr[5:0]);
   assign rs = instr[25:21];
   assign rt = instr[20:16];
   assign rd = instr[15:11];
   assign immed = instr[15:0];
   assign jmpimmed = instr[25:0];

    flopenr #(32) U_PC(.clk, .reset, .en(pcen), .d(pcnext), .q(pc));
    assign pcjump = {pc[31:28], (jmpimmed << 2)};
    mux2 #(32) U_IORDMUX(.d0(pc), .d1(aluout), .s(iord), .y(adr));
    
    flopenr #(32) U_IR(.clk, .reset, .en(irwrite), .d(readdata), .q(instr));
    mux2 #(5) U_REGDSTMUX(.d0(rt), .d1(rd), .s(regdst), .y(writereg));
    
    flopr #(32) U_MDR(.clk, .reset, .d(readdata), .q(data));
    signext U_signext(.a(immed), .y(signimm));
    assign shiftsignimm = signimm << 2;
    mux2 #(32) U_MEMTOREGMUX(.d0(aluout), .d1(data), .s(memtoreg), .y(regresult));
    
    regfile U_REG(.clk, .we3(regwrite), .wd3(regresult), .ra1(rs), .ra2(rt), .wa3(writereg), .rd1(rega), .rd2(regb));
    
    flopr #(32) U_A(.clk, .reset, .d(rega), .q(a));
    mux2 #(32) U_ALUSRCAMUX(.d0(pc), .d1(a), .s(alusrca), .y(srca));
    
    flopr #(32) U_B(.clk, .reset, .d(regb), .q(writedata));
    mux4 #(32) U_ALUSRCBMUX(.d0(writedata), .d1(32'd4), .d2(signimm), .d3(shiftsignimm), .s(alusrcb), .y(srcb));
    
    alu U_ALU(.a(srca), .b(srcb), .f(alucontrol), .zero, .y(aluresult));
    flopr U_ALUOUT(.clk, .reset, .d(aluresult), .q(aluout));
    
    mux3 #(32) U_PCSRCMUX(.d0(aluresult), .d1(aluout), .d2(pcjump), .s(pcsrc), .y(pcnext));

endmodule
