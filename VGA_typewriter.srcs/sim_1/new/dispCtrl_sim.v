`timescale 1ns / 1ps


module dispCtrl_tb;
    
    reg clk = 0;
    reg rst = 0;   
    wire hsync;
    wire vsync;
    wire de;
    wire frame;
    wire line;
    wire [15:0] sx;
    wire [15:0] sy;
    
    
display_480p disp480p(
            clk,
            rst,
            hsync,
            vsync,
            de,
            frame,
            line,
            sx,
            sy
    );  
         initial
             begin
                rst <= 1; # 22; rst <= 0;
             end
    
    always #10 clk = ~clk;
      
    
endmodule
