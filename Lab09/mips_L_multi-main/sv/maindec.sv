//-------------------------------------------------------
// maindec.sv - Multicyle MIPS contoroller FSM
// David_Harris@hmc.edu 8 November 2005
// Update to SystemVerilog 17 Nov 2010 DMH
// Refactord and updated by John Nestor June 2018
// Key changes to this module:
//  1. replace state code parameters with enum
//     (simulator will display symbolic state names)
//  2. import opcodes from mips_decls_p package
//  3. set control signals individually in state machine
//     instead of as a bitvector (easier to understand
//     and follows state diagram in Fig. 7.42)
//------------------------------------------------

module maindec(
    input  logic       clk, reset,
    input  mips_decls_p::opcode_t  opcode,
    output logic       pcwrite, memwrite, irwrite, regwrite,
    output logic       alusrca, branch, iord, memtoreg, regdst,
    output logic [1:0] alusrcb, pcsrc,
    output logic [1:0] aluop
    );

   import mips_decls_p::*;

   enum logic [3:0] {
     FETCH   = 4'd0,
     DECODE  = 4'd1,
     MEMADR  = 4'd2,
     MEMRD   = 4'd3,
     MEMWB   = 4'd4,
     MEMWR   = 4'd5,
     RTYPEEX = 4'd6,
     RTYPEWB = 4'd7,
     BEQEX   = 4'd8,
     ADDIEX  = 4'd9,
     ADDIWB  = 4'd10,
     JEX     = 4'd11,
     ERROR   = 4'd12
  } state, next;

  // state register
  always_ff @(posedge clk)
    if(reset) state = FETCH;
    else state = next;


  // next state logic
  always_comb begin
      next = FETCH;
      case(state)
          FETCH:   next = DECODE;
          DECODE:  begin
              case(opcode)
                  OP_LW:      next = MEMADR;
                  OP_SW:      next = MEMADR;
                  OP_RTYPE:   next = RTYPEEX;
                  OP_BEQ:     next = BEQEX;
                  OP_ADDI:    next = ADDIEX;
                  OP_J:       next = JEX;
                  default:     next = ERROR; // should never happen
              endcase
          end
      
      MEMADR: begin
        case(opcode)
            OP_LW: next = MEMRD;
            OP_SW: next = MEMWR;
        endcase
      end
      
      MEMRD: begin
        next = MEMWB;
      end
      
      MEMWB: begin
        next = FETCH;
      end
      
      MEMWR: begin
        next = FETCH;
      end
      
      RTYPEEX: begin
        next = RTYPEWB;
      end
      
      RTYPEWB: begin
        next = FETCH;
      end
      
      BEQEX: begin
        next = FETCH;
      end
      
      ADDIEX: begin
        next = ADDIWB;
      end
      
      ADDIWB: begin
        next = FETCH;
      end
      
      JEX: begin
        next = FETCH;
      end
      
      ERROR:   next = ERROR;  // stay in ERROR state until reset
      default: next = ERROR;  // should never happen but go to ERROR if it does
  endcase
end
  // output logic

  always_comb begin
      // default output values
      pcwrite = 0;
      memwrite = 0;
      irwrite = 0;
      regwrite = 0;
      alusrca = 0;
      branch = 0;
      iord = 0;
      memtoreg = 0;
      regdst = 0;
      alusrcb = 2'b00;
      pcsrc = 2'b00;
      aluop = 2'b00;
      case(state)
          FETCH: begin
              iord = 0;
              alusrca = 0;
              alusrcb = 2'b01;
              aluop = 2'b00;
              pcsrc = 2'b00;
              irwrite = 1'b1;
              pcwrite = 1'b1;
          end
          DECODE: begin
              alusrca = 0;
              alusrcb = 2'b11;
              aluop = 2'b00;
          end

          MEMADR: begin
            alusrca = 1'b1;
            alusrcb = 2'b10;
            aluop = 2'b00;
          end
          
          MEMRD: begin
            iord = 1'b1;
          end
          
          MEMWB: begin
            regdst = 0;
            memtoreg = 1'b1;
            regwrite = 1'b1;
          end
          
          MEMWR: begin
            iord = 1'b1;
            memwrite = 1'b1;
          end
          
          RTYPEEX: begin
            alusrca = 1'b1;
            alusrcb = 2'b00;
            aluop = 2'b10;
          end
          
          RTYPEWB: begin
            regdst = 1'b1;
            memtoreg = 0;
            regwrite = 1'b1;
          end
          
          BEQEX: begin
            alusrca = 1'b1;
            alusrcb = 2'b00;
            aluop = 2'b01;
            pcsrc = 2'b01;
            branch = 1'b1;
          end
          
          ADDIEX: begin
            alusrca = 1'b1;
            alusrcb = 2'b10;
            aluop = 2'b00;
          end
          
          ADDIWB: begin
            regdst = 0;
            memtoreg = 0;
            regwrite = 1'b1;
          end
          
          JEX: begin
            pcsrc = 2'b10;
            pcwrite = 1'b1;
          end

      endcase // case (state)
  end

endmodule
