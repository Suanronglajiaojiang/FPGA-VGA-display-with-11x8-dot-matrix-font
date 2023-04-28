`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module disp_sim;
    reg clk = 0;
    reg rst ;
    wire vga_hsync;
    wire vga_vsync; 
    wire [3:0] vga_r;
    wire [3:0] vga_g;
    wire [3:0] vga_b;
    
    dispLogic disp(
        clk,
        rst,
        0,
        9,
        4,
        ,
        ,
        ,
        ,
        vga_hsync, 
        vga_vsync, 
        vga_r,
        vga_g,
        vga_b
    );
    
    always #10 clk = ~clk;
    
     initial
        begin
           rst <= 1; # 22; rst <= 0;
        end       

endmodule
