 module dispBuffer #(
    parameter BUFFER_WIDTH = 16,
    parameter ASCII_WIDTH = 8,
    parameter GRID_ROW = 5,
    parameter GRID_COL = 10
    ) (
    input clk_pix,
    input rst_n,
    // input [15:0] btn,
    // input [2:0] shift,
    input [$clog2(GRID_COL)-1:0] chPos_x,
    input [$clog2(GRID_ROW)-1:0] chPos_y,
    // input writeEn,
    input dataReady,
    input [ASCII_WIDTH-1:0] ascii,
    input [(BUFFER_WIDTH-ASCII_WIDTH)/2-1:0] colorIndexF,
    input [(BUFFER_WIDTH-ASCII_WIDTH)/2-1:0] colorIndexB,
    output reg [BUFFER_WIDTH-1:0] bufferBundle
    ); 
    integer i;

    reg [BUFFER_WIDTH-1:0] Buffer [GRID_COL*GRID_ROW-1:0];
    reg [BUFFER_WIDTH-1:0] cursorTemp = 0; 
    reg [$clog2(GRID_COL*GRID_ROW)-1:0] wrPos;

    // wire [$clog2(GRID_COL*GRID_ROW)-1:0] cursorPos = wrPos<=GRID_COL*GRID_ROW-2 ? wrPos + 1 : 0; 
    
    always@(posedge dataReady or negedge rst_n) begin
        if(!rst_n) begin
            for(i=1; i<GRID_COL*GRID_ROW; i=i+1) begin
                 Buffer[i] <= {colorIndexB,colorIndexF,8'd0};  
            end
            wrPos <= 0; 
            Buffer[wrPos] <= {colorIndexB,colorIndexF,8'd127}; 
            cursorTemp <= {colorIndexB,colorIndexF,8'd0};     
        end
        else if(ascii==8'b00010001) begin  //left
            Buffer[wrPos] <= cursorTemp;
            cursorTemp <= Buffer[wrPos==0 ? GRID_COL*GRID_ROW-1 : wrPos-1];        
            Buffer[wrPos==0 ? GRID_COL*GRID_ROW-1 : wrPos-1] <= {colorIndexB,colorIndexF,8'd127};
            wrPos <= wrPos==0 ? GRID_COL*GRID_ROW-1 : wrPos-1 ;            
        end
        else if(ascii==8'b00010100) begin  //right
            Buffer[wrPos] <= cursorTemp;
            cursorTemp <= Buffer[wrPos==GRID_COL*GRID_ROW-1 ? 0 : wrPos+1];        
            Buffer[wrPos==GRID_COL*GRID_ROW-1 ? 0 : wrPos+1] <= {colorIndexB,colorIndexF,8'd127};
            wrPos <= wrPos==GRID_COL*GRID_ROW-1 ? 0 : wrPos+1;            
        end
        else if(ascii==8'b00010010) begin  //up
            Buffer[wrPos] <= cursorTemp;
            cursorTemp <= Buffer[wrPos>=GRID_COL ? wrPos-GRID_COL : wrPos+(GRID_ROW-1)*GRID_COL];        
            Buffer[wrPos>=GRID_COL ? wrPos-GRID_COL : wrPos+(GRID_ROW-1)*GRID_COL] <= {colorIndexB,colorIndexF,8'd127};
            wrPos <= wrPos>=GRID_COL ? wrPos-GRID_COL : wrPos+(GRID_ROW-1)*GRID_COL;            
        end
        else if(ascii==8'b00010011) begin  //down
            Buffer[wrPos] <= cursorTemp;
            cursorTemp <= Buffer[wrPos<(GRID_ROW-1)*GRID_COL ? wrPos+GRID_COL : wrPos-(GRID_ROW-1)*GRID_COL];        
            Buffer[wrPos<(GRID_ROW-1)*GRID_COL ? wrPos+GRID_COL : wrPos-(GRID_ROW-1)*GRID_COL] <= {colorIndexB,colorIndexF,8'd127};
            wrPos <= wrPos<(GRID_ROW-1)*GRID_COL ? wrPos+GRID_COL : wrPos-(GRID_ROW-1)*GRID_COL;            
        end 
        else if(ascii==8'b00001101) begin  //enter
            Buffer[wrPos] <= cursorTemp;
            cursorTemp <= Buffer[ wrPos<(GRID_ROW-1)*GRID_COL ? ((wrPos/GRID_COL)+1)*GRID_COL : 0 ];        
            Buffer[ wrPos<(GRID_ROW-1)*GRID_COL ? ((wrPos/GRID_COL)+1)*GRID_COL : 0 ] <= {colorIndexB,colorIndexF,8'd127};
            wrPos <= wrPos<(GRID_ROW-1)*GRID_COL ? ((wrPos/GRID_COL)+1)*GRID_COL : 0 ;            
        end 
        else if(ascii==8'b01111111) begin //backSpace
            Buffer[wrPos] <= {colorIndexB,colorIndexF,8'd0};
            cursorTemp <= {colorIndexB,colorIndexF,8'd0};        
            Buffer[wrPos==0 ? GRID_COL*GRID_ROW-1 : wrPos-1] <= {colorIndexB,colorIndexF,8'd127};
            wrPos <= wrPos==0 ? GRID_COL*GRID_ROW-1 : wrPos-1 ;                        
        end        
        else begin
            Buffer[wrPos] <= {colorIndexB,colorIndexF,ascii};
            wrPos <= wrPos<GRID_COL*GRID_ROW-1 ? wrPos + 1 : 0;
            Buffer[ wrPos==GRID_COL*GRID_ROW-1 ? 0 : wrPos+1 ] <= {colorIndexB,colorIndexF,8'd127};
        end
    end                  

    always@(posedge clk_pix or negedge rst_n) begin
        if(!rst_n) begin
            bufferBundle <= 16'b0;
        end
        else begin
            bufferBundle <= Buffer[chPos_x + GRID_COL*chPos_y];
        end
    end
    
endmodule
