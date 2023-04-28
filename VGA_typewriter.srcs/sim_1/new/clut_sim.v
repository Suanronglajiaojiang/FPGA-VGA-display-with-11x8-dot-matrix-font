module clut_tb;
    reg [3:0] index = 0;
    wire [11:0] color;
    
    CLUT clut(
        index,
        color
    );
    
    always #10 index = index + 1;
    
endmodule
    