module dispLogic #(
    parameter GRID_ROW = 5,
    parameter GRID_COL = 10,
    parameter POS_WIDTH = 6,
    parameter ASCII_WIDTH = 7,
    parameter ADDR_WIDTH = 11,
    parameter CHARA_WIDTH = 8,  
    parameter CHARA_HEIGHT = 11,
    parameter CORDW = 16,
    parameter SCALE = 8
    )(
    input clk_pix,
    input rst,
    input clear,
    input [$clog2(GRID_COL*GRID_ROW)-1:0] bufferPos,
    input [3:0] colorIndexF,
    input [3:0] colorIndexB,
    input [6:0] asciiWrite,
    input writeEn,
    output vga_hsync,    // horizontal sync
    output vga_vsync,    // vertical sync
    output reg [11:0] vga  // 12-bit VGA color
    );
    
    wire dataEnable;
    wire frameStart;
    wire lineStart;
    wire signed [CORDW - 1:0] sx;
    wire signed [CORDW - 1:0] sy;   
    wire hsync,vsync; 
    display_480p  display_inst(
        clk_pix,
        rst,
        vga_hsync,
        vga_vsync,
        dataEnable,
        frameStart,
        lineStart,
        sx,
        sy
    );
       
    reg [POS_WIDTH-1:0] chPos_x = 0;
    reg [POS_WIDTH-1:0] chPos_y = 0;
    wire [15:0] charBundle;    
    dispBuffer  displayBuffer(
        clk_pix,
        clear,
        chPos_x,
        chPos_y,
        bufferPos,
        writeEn,
        asciiWrite,
        colorIndexF,
        colorIndexB,
        charBundle
    );
    
    wire [3:0] bitCnt;
    wire [3:0] lineCnt;
    wire x_tick;
    wire y_tick;
     
    magnifier #(
        SCALE,
        CHARA_WIDTH,
        CHARA_HEIGHT,
        GRID_ROW,
        CORDW
    ) charaMagnifier(
        rst,
        dataEnable,
        sx,
        sy,
        bitCnt,
        lineCnt,
        x_tick,
        y_tick
    );    
 
    wire [ADDR_WIDTH-1:0] charaLineAddr;
    asciiDec asciiDecLogic(
        charBundle[6:0],
        lineCnt,
        charaLineAddr
    );  
    
              
    wire [CHARA_WIDTH-1:0] charaLine;                                                               
    charaROM charrom(
        charaLineAddr,
        charaLine
    );                      
    
    wire [11:0] charColor;
    wire [11:0] backColor;
    CLUT backCLUT(charBundle[15:12],backColor);    
    CLUT charCLUT(charBundle[11:8],charColor);

    // reg [3:0] xCnt,yCnt;
    // always@(posedge x_tick) begin
        // xCnt <= xCnt == CHARA_WIDTH - 1 ? 0 : xCnt + 1;
    // end
    // always@(posedge y_tick) begin
        // yCnt <= yCnt == CHARA_HEIGHT - 1 ? 0 : yCnt + 1;
    // end    
    
    // integer i;
    // integer j;
    always@( posedge bitCnt == 0 ) begin
        if( dataEnable ) begin
            if( chPos_x == GRID_COL - 1 ) begin
                chPos_x <= 0;
            end
            else begin
                chPos_x <=  chPos_x + 1 ;             
            end
        end
        if(rst) begin
            chPos_x <= 0;
        end        
    end
    
    always@( posedge lineCnt == 0 ) begin
        if( dataEnable ) begin
            if( chPos_y == GRID_ROW - 1 ) begin
                chPos_y <= 0;
            end
            else begin
                chPos_y <=  chPos_y + 1 ;             
            end
        end
        if(rst) begin
            chPos_y <= 0;
        end            
    end   
    
           
    
    always@(posedge clk_pix) begin
        if ( dataEnable ) begin
            if ( charaLine[bitCnt] ) begin
                vga <= charColor;
            end
            else begin
                vga <= backColor;
            end
        end
        else begin
            vga <= 12'h0;
        end
    end                          
    
                    
endmodule 