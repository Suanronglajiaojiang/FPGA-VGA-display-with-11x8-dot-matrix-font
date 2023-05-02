module magnifier#(
    parameter SCALE = 8,
    parameter CHARA_WIDTH = 8,
    parameter CHARA_HEIGHT = 11,
    parameter GRID_ROW = 5,
    parameter CORDW = 16
    )(
    input rst,
    input de,
    input signed [CORDW - 1:0] sx,
    input signed [CORDW - 1:0] sy,
    output reg [3:0] bitCnt = 0,
    output reg [3:0] lineCnt = 0,
    output reg x_tick = 0,
    output reg y_tick = 0 
    );

    always@ * begin
        x_tick <= sx % SCALE == 7;
        y_tick <= sy % SCALE == 7;
    end

    always@(posedge x_tick) begin
        if(de) begin
            bitCnt <= bitCnt == CHARA_WIDTH -1 ? 0 : bitCnt + 4'b1 ;      
        end
        else if(rst) begin
            bitCnt <= 0;
        end        
    end
    

    always@(posedge y_tick) begin
        if(de) begin   
            lineCnt <= lineCnt == CHARA_HEIGHT -1 ? 0 : lineCnt + 4'b1;
        end
        else if(rst) begin
            lineCnt <= 0;
        end         
    end
       
    
endmodule
