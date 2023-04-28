`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/25 21:21:20
// Design Name: 
// Module Name: mag_sim
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


module mag_sim;
    reg rst;
    reg de;
    reg [15:0] sx=0;
    reg [15:0] sy=0;
    wire [3:0] bc;
    wire [3:0] lc;
    wire xt;
    wire yt;
    
    magnifier mag(
        rst,
        de,
        sx,
        sy,
        bc,
        lc,
        xt,
        yt
    );
    
    initial begin
        rst = 1; #22 rst = 0;de = 1;
    end
    
    
    always #10 sx <= sx == 640-1 ? 0 : sx + 1;

endmodule
