`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/19/2023 08:33:49 AM
// Design Name: 
// Module Name: Lab04_top
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


module Lab04_top(
    input logic clk, sw1, sw0, rst, btn_l, btn_r,
    output logic [7:0] an_n,
    output logic [6:0] segs_n,
    output logic dp_n,
    inout tmp_scl, 
    inout tmp_sda
    );
    logic temp_f, temp_c, enb_disp, enb_switch, tmp_rdy, tmp_err, dp_disp;
    logic state0, state1, state2, state3;
    logic[6:0] d7_disp, d6_disp, d5_disp, d4_disp, d3_disp, d2_disp, d1_disp, d0_disp, c_f, am_pm, tx10_sign; 
    logic[6:0] h1, h0, m1, m0, s1, s0;
    logic[3:0] disp_switch, thousands, hundreds, tens, ones;
    logic[12:0] temp;
    
    period_enb #(.PERIOD_MS(1000)) U_startSwitch(.clk, .rst(rst), .enb_out(enb_disp));
    counter #(.MOD(3)) U_pisplaySwitch(.clk,.rst(rst),.enb(enb_disp),.q(),.Carry(enb_switch));

    
    always_comb begin
        if(sw0) temp_c = 1'b1;
        else temp_c = 1'b0;
        if(sw1) temp_f = 1'b1;
        else temp_f = 1'b0;
    end
    
    always_comb begin
        
        if(enb_switch) disp_switch = disp_switch + 1'd1;
        
        if(!temp_f && !temp_c) begin
            dp_disp = 1'b0;
            d7_disp = h1;
            d6_disp = h0;
            d5_disp = m1;
            d4_disp = m0;
            d3_disp = s1;
            d2_disp = s0;
            d1_disp = 7'b1111111;
            d0_disp = am_pm;
        end
        if(temp_f && !temp_c) begin
            if(disp_switch >= 2'd2) disp_switch = 0;
            else if(disp_switch == 1'd0) begin
                d7_disp = h1;
                d6_disp = h0;
                d5_disp = m1;
                d4_disp = m0;
                d3_disp = s1;
                d2_disp = s0;
                d1_disp = 7'b1111111;
                d0_disp = am_pm;
                d6_disp[5] = 1'b1;
                d4_disp[5] = 1'b1;
            end
            if(disp_switch == 1'd1) begin
                c_f = 1'd1;
                d7_disp = 7'b1111111;
                d6_disp = 7'b1111111;
                d5_disp = tx10_sign;
                d4_disp = thousands;
                d3_disp = hundreds;
                d2_disp = tens;
                d1_disp = ones;
                d0_disp = 4'hf;
                d2_disp[5] = 1'b1;
                
                if (tx10_sign) begin
                    if(thousands) d5_disp = 7'b0111111;
                    else d5_disp = 7'b1111111;
                    if(thousands == 0 && hundreds) d4_disp = 7'b0111111;
                    else if(thousands == 0 && hundreds == 0) begin
                        d3_disp = 7'b0111111;
                        d4_disp = 7'b1111111;
                    end
                    else begin
                        d4_disp = thousands;
                        d3_disp = hundreds;
                    end
                end
                else d5_disp = 7'b1111111;
                if(tx10_sign == 0) begin
                    if(thousands == 0) d4_disp = 7'b1111111;
                    else d4_disp = thousands;
                    if (thousands == 0 && hundreds == 0) d3_disp = 7'b1111111;
                    else d3_disp = hundreds;
                end
            end
        end
        if(!temp_f && temp_c) begin
            if(disp_switch >= 2'd2) disp_switch = 0;
            else if(disp_switch == 1'd0) begin
                d7_disp = h1;
                d6_disp = h0;
                d5_disp = m1;
                d4_disp = m0;                                                                                                                                                            
                d3_disp = s1;
                d2_disp = s0;
                d1_disp = 7'b1111111;
                d0_disp = am_pm;
                d6_disp[5] = 1'b1;
                d4_disp[5] = 1'b1;
            end
            else if(disp_switch == 1'd1) begin
                c_f = 1'd0;
                d7_disp = 7'b1111111;
                d6_disp = 7'b1111111;
                d5_disp = tx10_sign;
                d4_disp = thousands;
                d3_disp = hundreds;
                d2_disp = tens;
                d1_disp = ones;
                d0_disp = 4'hc;
                d2_disp[5] = 1'b1;
                if (tx10_sign) begin
                    if(thousands) d5_disp = 7'b0111111;
                    else d5_disp = 7'b1111111;
                    if(thousands == 0 && hundreds) d4_disp = 7'b0111111;
                    else if(thousands == 0 && hundreds == 0) begin
                        d3_disp = 7'b0111111;
                        d4_disp = 7'b1111111;
                    end
                    else begin
                        d4_disp = thousands;
                        d3_disp = hundreds;
                    end
                end
                else d5_disp = 7'b1111111;
                if(tx10_sign == 0) begin
                    if(thousands == 0) d4_disp = 7'b1111111;
                    else d4_disp = thousands;
                    if (thousands == 0 && hundreds == 0) d3_disp = 7'b1111111;
                    else d3_disp = hundreds;
                end
            end
        end
        else if(temp_f && temp_c) begin
            if(disp_switch >= 3'd3) disp_switch = 0;
            else if(disp_switch == 1'd0) begin
                d7_disp = h1;
                d6_disp = h0;
                d5_disp = m1;
                d4_disp = m0;
                d3_disp = s1;
                d2_disp = s0;
                d1_disp = 7'b1111111;
                d0_disp = am_pm;
                d6_disp[5] = 1'b1;
                d4_disp[5] = 1'b1;
            end
            else if(disp_switch == 1'd1) begin
                c_f = 1'd0;
                d7_disp = 7'b1111111;
                d6_disp = 7'b1111111;
                d5_disp = tx10_sign;
                d4_disp = thousands;
                d3_disp = hundreds;
                d2_disp = tens;
                d1_disp = ones;
                d0_disp = 4'hc;
                d2_disp[5] = 1'b1;
                if (tx10_sign) begin
                    if(thousands) d5_disp = 7'b0111111;
                    else d5_disp = 7'b1111111;
                    if(thousands == 0 && hundreds) d4_disp = 7'b0111111;
                    else if(thousands == 0 && hundreds == 0) begin
                        d3_disp = 7'b0111111;
                        d4_disp = 7'b1111111;
                    end
                    else begin
                        d4_disp = thousands;
                        d3_disp = hundreds;
                    end
                end
                else d5_disp = 7'b1111111;
                if(tx10_sign == 0) begin
                    if(thousands == 0) d4_disp = 7'b1111111;
                    else d4_disp = thousands;
                    if (thousands == 0 && hundreds == 0) d3_disp = 7'b1111111;
                    else d3_disp = hundreds;
                end
            end
            else if(disp_switch == 2'd2) begin
                c_f = 1'd1;
                d7_disp = 7'b1111111;
                d6_disp = 7'b1111111;
                d5_disp = tx10_sign;
                d4_disp = thousands;
                d3_disp = hundreds;
                d2_disp = tens;
                d1_disp = ones;
                d0_disp = 4'hf;
                d2_disp[5] = 1'b1;
                if (tx10_sign) begin
                    if(thousands) d5_disp = 7'b0111111;
                    else d5_disp = 7'b1111111;
                    if(thousands == 0 && hundreds) d4_disp = 7'b0111111;
                    else if(thousands == 0 && hundreds == 0) begin
                        d3_disp = 7'b0111111;
                        d4_disp = 7'b1111111;
                    end
                    else begin
                        d4_disp = thousands;
                        d3_disp = hundreds;
                    end
                end
                else d5_disp = 7'b1111111;
                if(tx10_sign == 0) begin
                    if(thousands == 0) d4_disp = 7'b1111111;
                    else d4_disp = thousands;
                    if (thousands == 0 && hundreds == 0) d3_disp = 7'b1111111;
                    else d3_disp = hundreds;
                end
            end
        end
    end
    
    
    dig_clock U_clock(.clk, .rst(rst), .adv_hr(btn_l), .adv_min(btn_r),.am_pm(am_pm), .h1(h1), .h0(h0), .m1(m1), .m0(m0), .s1(s1), .s0(s0));
    
    sevenseg_ctl U_sevseg(.clk, .rst(rst), .d7(d7_disp), .d6(d6_disp), .d5(d5_disp), .d4(d4_disp), .d3(d3_disp), .d2(d2_disp), .d1(d1_disp), .d0(d0_disp), .segs_n, .an_n, .dp_n);
    
    tdisplay U_display(.tc(temp),.c_f(c_f),.tx10_sign,.thousands(thousands),.hundreds(hundreds),.tens(tens),.ones(ones));
    
    TempSensorCtl U_TSCTL ( .TMP_SCL(tmp_scl), .TMP_SDA(tmp_sda), .TEMP_O(temp), .RDY_O(tmp_rdy), .ERR_O(tmp_err), .CLK_I(clk), .SRST_I(rst) );
        
endmodule