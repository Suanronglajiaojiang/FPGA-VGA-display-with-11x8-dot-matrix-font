 module dispBuffer #(
    parameter POS_WIDTH = 4,
    parameter ASCII_WIDTH = 7,
    parameter GRID_ROW = 5,
    parameter GRID_COL = 10
    ) (
    input clk_pix,
    input rst,
    input [3:0] ctrl,
    input [$clog2(GRID_COL)-1:0] chPos_x,
    input [$clog2(GRID_ROW)-1:0] chPos_y,
    input writeEn_in,
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

    reg [$clog2(GRID_COL*GRID_ROW)-1:0] bufferPos = 0;
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

    initial begin
        Buffer[x_cursor][y_cursor] <= {8'h15,1'b1,7'd127};        
        for(j=0;j<GRID_ROW;j=j+1) begin
            for(i=1;i<GRID_COL;i=i+1) begin
                Buffer[i][j] <= {8'h15,1'b1,7'd0}; 
            end
        end
        for(j=1;j<GRID_ROW;j=j+1) begin
            Buffer[0][j] <= {8'h15,1'b1,7'd0};
        end
    end

    reg writeEn = 0;
    reg [2:0] temp = 0;
    always@(posedge clk_pix) begin
        temp[0] <= writeEn_in;
        temp[1] <= temp[0];
        temp[2] <= temp[1];
        writeEn <= temp[2];
    end
       
    reg [15:0] cursorTemp = 0;         
    always@(posedge writeEn) begin   //control bufferPos


        if(ctrl[0]) begin   //turn to next line
            bufferPos <= bufferPos>=40 ? 0 : bufferPos/GRID_COL+1;
        end

        if(ctrl[1]) begin   //clear
            bufferPos <= 0;
        end

        if(ctrl[2]) begin   //left shift by 1
            bufferPos <= bufferPos>0 ? bufferPos-1 : GRID_COL*GRID_ROW-1;
        end

        if(ctrl[3]) begin   //right shift by 1
            bufferPos <= bufferPos<GRID_COL*GRID_ROW-1 ? bufferPos+1 : 0;
        end

        else begin      
            // Buffer[x][y] <= {8'h15,1'b1,ascii};
            // Buffer[x_cursor][y_cursor] <= {8'h15,1'b1,7'd127};
            bufferPos <= bufferPos<GRID_COL*GRID_ROW-1 ? bufferPos+1 : 0;
        end
    end

    always@(posedge writeEn_in) begin  //control Buffer
        Buffer[x_cursor][y_cursor] <= {8'h15,1'b1,7'd127};

        if(ctrl[0]) begin
            cursorTemp <= Buffer[x_cursor][y_cursor];
        end

        if(ctrl[1]) begin  
            for(j=0;j<GRID_ROW;j=j+1) begin
                for(i=1;i<GRID_COL;i=i+1) begin
                    Buffer[i][j] <= {8'h15,1'b1,7'd0}; 
                end
            end
            for(j=1;j<GRID_ROW;j=j+1) begin
                Buffer[0][j] <= {8'h15,1'b1,7'd0}; 
            end
        end

    end
    
    always@(posedge clk_pix) begin
        bufferBundle <= Buffer[chPos_x][chPos_y];
    end
    
endmodule
