//-----------------------------------------------------------------------------
// Module Name   : dbl_dabble_ext_tb - testbench for ext. binar-bcd conv.
// Project       : RTL Hardware Design and Verification using SystemVerilog
//-----------------------------------------------------------------------------
// Author        : John Nestor  <nestorj@lafayette.edu>
// Created       : Feb 2021
//-----------------------------------------------------------------------------
// Description   : Self-checking testbench for the extended double-dabble
// binary-bcd converter.  Exhaustively tests all possble values and reports
// errors
//-----------------------------------------------------------------------------

module dbl_dabble_tb;
    logic  [12:0] tx10_mag_r;
    logic [3:0] thousands, hundreds, tens, ones;
    logic [3:0] thousands_exp, hundreds_exp, tens_exp, ones_exp;
    dbl_dabble_ext DUV (.tx10_mag_r, .thousands, .hundreds, .tens, .ones);
    int err_ct;

    initial begin
        $timeformat(-9,2," ns");
        err_ct = 0;
        tx10_mag_r = 1023;
        #10;
        tx10_mag_r = 123;
        #10;
        tx10_mag_r = 1049;
        #10;
        tx10_mag_r = 3000;
        #10;
        tx10_mag_r = 4095;
        #10;
        tx10_mag_r = 8000;
        #10;
        tx10_mag_r = 8191;
        #10;
        $stop;
        for (int i=0; i<8191; i++) begin
            tx10_mag_r = i;
            ones_exp = tx10_mag_r % 10;
            tens_exp = (tx10_mag_r / 10) % 10;
            hundreds_exp = tx10_mag_r / 100 % 10;
            thousands_exp = tx10_mag_r / 1000;
            #10;
            if ( (thousands_exp != thousands) || (hundreds_exp != hundreds)
              || (tens_exp != tens) || (ones_exp != ones) ) begin
                  $display("time=%t, expected %1d %1d %1d %1d actual %1d %1d %1d %1d",
                            $time, thousands_exp, hundreds_exp, tens_exp, ones_exp,
                            thousands, hundreds, tens, ones);
                  err_ct++;
              end
        end
        $display("%d errors", err_ct );
        $stop;
    end
endmodule
