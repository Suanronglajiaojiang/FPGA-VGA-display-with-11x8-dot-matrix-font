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
    input writeEn,
    input ctrlEn,
    input [ASCII_WIDTH-1:0] ascii,
    input [3:0] colorIndexF,
    input [3:0] colorIndexB,
    output reg [15:0] bufferBundle
    ); 
    integer i;

    reg [15:0] Buffer [GRID_COL*GRID_ROW-1:0];

    reg [$clog2(GRID_COL*GRID_ROW)-1:0] wrPos;
    wire [$clog2(GRID_COL*GRID_ROW)-1:0] cursorPos;
    assign cursorPos = wrPos<=GRID_COL*GRID_ROW-2 ? wrPos + 1 : 0; 
    reg writeEn_in;
    reg [2:0] temp;
    reg [15:0] cursorTemp;     

    initial begin           
        for(i=1; i<GRID_COL*GRID_ROW; i=i+1) begin
            Buffer[i] <= {8'h15,1'b1,7'd0}; 
        end 
        Buffer[0] <= {8'h15,1'b1,7'd127};       
        wrPos <= 0;
        writeEn_in <= 0;
        temp <= 0;
        cursorTemp <= 0;
    end

    always@(posedge clk_pix) begin
        temp[0] <= writeEn;
        temp[1] <= temp[0];
        temp[2] <= temp[1];
        writeEn_in <= temp[2];
    end
       
    
    // always@(posedge writeEn) begin        
        // if(ctrl[0]) begin
            // wrPos <= wrPos<(GRID_ROW-1)*GRID_COL ? (wrPos/GRID_COL)*GRID_COL + GRID_COL : 0;
            // Buffer[cursorPos] <= {8'h15,1'b1,7'd127};
        // end
        // if(ctrl[1]) begin
            // for(i=1; i<GRID_COL*GRID_ROW; i=i+1) begin
                // Buffer[i] <= {8'h15,1'b1,7'd0}; 
            // end
            // wrPos <= 49;
            // Buffer[cursorPos] <= {8'h15,1'b1,7'd127};
        // end
        // if(ctrl[2]) begin
            // wrPos <= wrPos<GRID_COL*GRID_ROW-1 ? wrPos + 1 : 0;
            // Buffer[wrPos] <= {8'h15,1'b1,7'd127};
        // end
        // if(ctrl[3]) begin
            // wrPos <= wrPos>0 ? wrPos - 1 : GRID_COL*GRID_ROW-1;
            // Buffer[cursorPos] <= {8'h15,1'b1,7'd127};
        // end
        // else begin
            // Buffer[wrPos] <= {8'h15,1'b1,ascii};
            // Buffer[cursorPos] <= {8'h15,1'b1,7'd127};
            // wrPos <= wrPos<GRID_COL*GRID_ROW-1 ? wrPos + 1 : 0;
        // end
    // end
    always@(posedge writeEn_in) begin
            Buffer[wrPos] <= {8'h15,1'b1,ascii};
            Buffer[cursorPos] <= {8'h15,1'b1,7'd127};
            // wrPos <= wrPos<GRID_COL*GRID_ROW-1 ? wrPos + 1 : 0;
            wrPos <= wrPos + 1;
    end

    
    always@(posedge clk_pix) begin
        bufferBundle <= Buffer[chPos_x + GRID_COL*chPos_y];
    end
    
endmodule
