 module dispBuffer #(
    parameter POS_WIDTH = 4,
    parameter ASCII_WIDTH = 7,
    parameter GRID_ROW = 5,
    parameter GRID_COL = 10
    ) (
    input clk_pix,
    input clear,
    input [$clog2(GRID_COL)-1:0] chPos_x,
    input [$clog2(GRID_ROW)-1:0] chPos_y,
    input [$clog2(GRID_COL*GRID_ROW)-1:0] bufferPos,
    input writeEn,
    input [ASCII_WIDTH-1:0] ascii,
    input [3:0] colorIndexF,
    input [3:0] colorIndexB,
    output reg [15:0] bufferBundle
    ); 
    integer i;
    integer j;
    
    reg [15:0] Buffer [GRID_COL-1:0][GRID_ROW-1:0];

    wire [$clog2(GRID_COL)-1:0] x;
    wire [$clog2(GRID_ROW)-1:0] y;
    wire [$clog2(GRID_COL)-1:0] x_cursor;
    wire [$clog2(GRID_ROW)-1:0] y_cursor;

    initial begin
        Buffer[0][0] <= {8'h15,1'b1,7'd127};        
        for(j=0;j<GRID_ROW;j=j+1) begin
            for(i=1;i<GRID_COL;i=i+1) begin
                Buffer[i][j] <= {8'h15,1'b1,7'd0}; 
            end
        end
    end

    lineToFace posWrite(
        bufferPos,
        x,
        y
    );

    wire [$clog2(GRID_COL*GRID_ROW)-1:0] bufferNext = bufferPos<GRID_COL*GRID_ROW-1 ? bufferPos + 1 : 0; 
 
    lineToFace posNext(
        bufferNext,
        x_cursor,
        y_cursor
    );   
             
    always@(posedge writeEn or negedge clear) begin
        if(writeEn) begin
            Buffer[x][y] <= {8'h15,1'b1,ascii};
            Buffer[x_cursor][y_cursor] <= {8'h15,1'b1,7'd127};
        end
        if(clear) begin
            Buffer[0][0] <= {8'h15,1'b1,7'd127};        
            for(j=0;j<GRID_ROW;j=j+1) begin
                for(i=1;i<GRID_COL;i=i+1) begin
                    Buffer[i][j] <= {8'h15,1'b1,7'd0}; 
                end
            end
        end        
    end
    
    always@(posedge clk_pix) begin
        bufferBundle <= Buffer[chPos_x][chPos_y];
    end
    
endmodule
