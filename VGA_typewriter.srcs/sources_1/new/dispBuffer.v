 module dispBuffer #(
    parameter POS_WIDTH = 4,
    parameter ASCII_WIDTH = 7,
    parameter BUFFER_X = 10,
    parameter BUFFER_Y = 5
    ) (
    input clk_pix,
    input clear,
    input [POS_WIDTH-1:0] chPos_x,
    input [POS_WIDTH-1:0] chPos_y,
    input [POS_WIDTH-1:0] wrPos_x,
    input [POS_WIDTH-1:0] wrPos_y,
    input writeEn,
    input [ASCII_WIDTH-1:0] ascii,
    input [3:0] colorIndexF,
    input [3:0] colorIndexB,
    output reg [15:0] bufferBundle
    ); 
    integer i;
    integer j;
    
    reg [15:0] Buffer [BUFFER_X-1:0][BUFFER_Y-1:0];
            
    initial begin        
        for(j=0;j<BUFFER_Y;j=j+1) begin
            for(i=0;i<BUFFER_X;i=i+1) begin
                Buffer[i][j] <= {8'h15,1'b1,7'd127}; 
            end
        end
    end



    reg [6:0] ascii_disp = 7'd32;
    reg [POS_WIDTH-1:0] x = 0;
    reg [POS_WIDTH-1:0] y = 0;
    always@(posedge writeEn) begin
        ascii_disp <= ascii_disp == 127 ? 32 : ascii_disp + 1;
        x <= x == BUFFER_X - 1 ? 0 : x + 1;
        y <= x == BUFFER_X - 1 ? (y == BUFFER_Y - 1 ? 0 : y + 1) : y;
        Buffer[x][y] <= {8'h15,1'b1,ascii_disp};
    end

    // always@(posedge clear) begin
    //         for(i=0;i<BUFFER_X;i=i+1) begin
    //             for(j=0;j<BUFFER_Y;j=j+1) begin
    //                Buffer[i][j] <= {8'h15,1'b1,7'd64} + i; 
    //             end
    //         Buffer[i][j] <= {8'h15,1'b1,7'd64} + j;
    //         end
    // end
    
    // always@(posedge clk_pix) begin
    //     if( chPos_x==wrPos_x && chPos_y==wrPos_y ) begin
    //         Buffer[chPos_x][chPos_y] <= {8'h15,1'b1,7'd127};
    //     end

    // end


//    always@(negedge writeEn) begin    
//        Buffer[wrPos_x][wrPos_y] <= Buffer[wrPos_x][wrPos_y][7] == 1'b0 ? {colorIndexB,colorIndexF,1'b1,ascii} : 16'b0;
//    end
    
    always@(posedge clk_pix) begin
        bufferBundle <= Buffer[chPos_x][chPos_y];
    end
    
endmodule
