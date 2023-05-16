module magnifier#(
    parameter SCALE = 8,
    parameter CHARA_WIDTH = 8,
    parameter CHARA_HEIGHT = 11,
    parameter CORDW = 16
    )(
    input rst_n,
    input de,
    input signed [CORDW - 1:0] sx,
    input signed [CORDW - 1:0] sy,
    output reg [3:0] bitCnt,
    output reg [3:0] lineCnt,
    output reg x_tick,
    output reg y_tick 
    );

    always@ (*) begin
        x_tick <= sx % SCALE == SCALE - 1;
        y_tick <= sy % SCALE == SCALE - 1;
    end

    always@(posedge x_tick or negedge rst_n) begin
        if(!rst_n) begin
            bitCnt <= 0;
        end                
        else if(de) begin
            bitCnt <= bitCnt == CHARA_WIDTH -1 ? 0 : bitCnt + 4'b1 ;      
        end
    end
    

    always@(posedge y_tick or negedge rst_n) begin
        if(!rst_n) begin
            lineCnt <= 0;
        end                 
        else if(de) begin   
            lineCnt <= lineCnt == CHARA_HEIGHT -1 ? 0 : lineCnt + 4'b1 ;
        end
    end
       
    
endmodule
