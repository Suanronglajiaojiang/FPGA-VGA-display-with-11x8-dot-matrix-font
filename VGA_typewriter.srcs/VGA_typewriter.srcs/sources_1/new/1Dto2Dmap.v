module lineToFace#(
    parameter GRID_COL = 10,
    parameter GRID_ROW = 5
    )(
        input [$clog2(GRID_COL*GRID_ROW)-1:0] bufferPos,
        output reg [$clog2(GRID_COL)-1:0] wrPos_x = 0,
        output reg [$clog2(GRID_ROW)-1:0] wrPos_y = 0
    );

    always@(bufferPos) begin
        wrPos_x <= bufferPos % GRID_COL;
        wrPos_y <= bufferPos / GRID_COL;
    end

endmodule
