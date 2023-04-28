`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/07 16:08:23
// Design Name: 
// Module Name: VGA_typewriter
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


module VGA_typewriter(
    input  clk_50m,     // 50 MHz clock
    input  btn_rst_n,    // reset button
    input [3:0] colorIndexF,
    input [3:0] colorIndexB,
    input [3:0] col,
    output [3:0] row,
    output vga_hsync,    // horizontal sync
    output vga_vsync,    // vertical sync
    output [3:0] vga_r,  // 4-bit VGA red
    output [3:0] vga_g,  // 4-bit VGA green
    output [3:0] vga_b,   // 4-bit VGA blue
    input clear,
    output led
    );
    
    // generate pixel clock
    wire clk_pix;
    wire clk_pix_locked;
    wire [5:0] wrPos;
    wire [6:0] asciiWrite;
    wire writeEn;
    
    clk_wiz_0 clock_pix_inst (
       clk_pix,
       btn_rst_n,  // reset button is active low
       clk_pix_locked,
       clk_50m  // not used for VGA output
    );
    wire rst_pix;
    assign led = clk_pix;
    assign rst_pix = !clk_pix_locked;  // wait for clock lock
//    assign writeEn = 0;
    assign wrPos = 25;
    wire [11:0] vga;
    assign vga = {vga_r,vga_g,vga_b};
    wire wrPos_x;
    wire wrPos_y;       
    dispLogic Display (
        clk_pix,
        rst_pix,
        clear,
        wrPos_x,
        wrPos_y,
        colorIndexF,
        colorIndexB,
        asciiWrite,
        writeEn,
        vga_hsync,  
        vga_vsync,  
        vga
    );
    
   wire [15:0] btn;
   typeLogic Typer(
       btn,
       wrPos_x,
       wrPos_y,
       asciiWrite,
       writeEn
   );
    
   key_board key(
       clk_50m,
       col,
       row,
       btn
   );
    
     
    
endmodule


