`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/07/2023 10:15:16 AM
// Design Name: 
// Module Name: dig_clock
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


module dig_clock(
input logic clk, rst, adv_hr, adv_min,
output logic [6:0] am_pm, h1, h0, m1, m0, s1, s0

    );
    
    logic adv_hr_db, adv_min_db, adv_hr_pulsed, adv_min_pulsed;
    
    debounce hr (.clk, .rst, .pb(adv_hr), .pb_debounced(adv_hr_db));
    debounce min (.clk, .rst, .pb(adv_min), .pb_debounced(adv_min_db));

    single_pulser hr_pulse (.clk, .din(adv_hr_db), .d_pulse(adv_hr_pulsed));
    single_pulser min_pulse (.clk, .din(adv_min_db), .d_pulse(adv_min_pulsed));
    
    
    logic enb_s0, enb_s1, enb_m0, enb_m1, enb_h0;
    
    period_enb #(.PERIOD_MS(1000)) U_per(.clk, .rst(rst), .enb_out(enb_s0));
    counter #(.MOD(10)) U_sec0(.clk,.rst(rst),.enb(enb_s0),.q(s0[3:0]),.Carry(enb_s1));
    counter #(.MOD(6)) U_sec1(.clk,.rst(rst),.enb(enb_s1),.q(s1[3:0]),.Carry(enb_m0));
    counter #(.MOD(10)) U_min0(.clk,.rst(rst),.enb(enb_m0 || adv_min_pulsed),.q(m0[3:0]),.Carry(enb_m1));
    counter #(.MOD(6)) U_min1(.clk,.rst(rst),.enb(enb_m1),.q(m1[3:0]),.Carry(enb_h0));
    hr_ctr(.clk, .rst(rst), .enb(enb_h0 || adv_hr_pulsed), .h1, .h0(h0[3:0]), .am_pm);
    
    assign s0[6:4] = 3'b000;
    assign s1[6:4] = 3'b000;
    assign m0[6:4] = 3'b010;
    assign m1[6:4] = 3'b000;
    assign h0[6:4] = 3'b010;
    
    
   
 
endmodule
