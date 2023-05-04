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


module VGA_typewriter #(
        parameter xKeyNum = 17,
        parameter GRID_COL = 10,
        parameter GRID_ROW = 5
    )(
        input  clk_50m,     // 50 MHz clock
        input  rst_n,    // reset button
        input [3:0] colorIndexF,
        input [3:0] colorIndexB,
        // input [xKeyNum-1:0] xKeys,
        input [3:0] col,
        output [3:0] row,
        output vga_hsync,    // horizontal sync
        output vga_vsync,    // vertical sync
        output [3:0] vga_r,  // 4-bit VGA red
        output [3:0] vga_g,  // 4-bit VGA green
        output [3:0] vga_b,   // 4-bit VGA blue
        input [2:0] shift,
        output [11:0] led
    );
    
    // generate pixel clock
    wire clk_pix;
    wire clk_pix_locked;
    wire [6:0] asciiWrite;
    wire writeEn;
    assign led[0] = clk_pix;
    assign led[3:1] = shift;
    assign led[7:4] = colorIndexF;
    assign led[11:8] = colorIndexB;
    
    clk_wiz_0 clock_pix_inst (
       clk_pix,
       rst_n,  // reset button is active low
       clk_pix_locked,
       clk_50m  // not used for VGA output
    );
    wire rst_pix;
    assign rst_pix = !clk_pix_locked;  // wait for clock lock

    wire [11:0] vga;
    assign vga = {vga_r,vga_g,vga_b};
    wire ctrlEn;
    wire [15:0] btn;  
    
    dispLogic Display (
        clk_pix,
        rst_pix,
        btn[3:0],
        colorIndexF,
        colorIndexB,
        asciiWrite,
        writeEn,
        ctrlEn,
        vga_hsync,  
        vga_vsync,  
        vga
    );
    
   typeLogic #(xKeyNum)
   Typer(
       clk_pix,
       shift,
       btn,
       asciiWrite,
       writeEn,
       ctrlEn
   );
    
   key_board #(xKeyNum)
   key(
       clk_50m,
       col,
       row,
       btn
   );
   
    
    
endmodule


