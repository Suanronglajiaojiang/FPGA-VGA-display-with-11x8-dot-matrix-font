module key_board(
        input           clk,     //矩阵扫描周期不能过快
        //input           btnclk,     //20ms时钟
        input   [3:0]   col,        //列
        output reg [3:0]   row,        //行
        output  [15:0]  btnout      //按键扫描输出
    );
    
    reg [15:0] btn = 0;
    reg [15:0] btn0 = 0;
    reg [15:0] btn1 = 0;
    reg [15:0] btn2 = 0;
    reg btnclk = 0;
    reg btnclk_cnt = 0;
    
    always @(posedge clk) begin      //20MS 50M/50=1000000 50HZ
        if(btnclk_cnt==500000) begin
            btnclk <=~ btnclk;
            btnclk_cnt <= 0;
        end
        else begin
            btnclk_cnt <= btnclk_cnt+1'b1;
        end
    end
           
    initial begin
        row <= 4'b0001;
    end
    
    always @(posedge btnclk) begin
    	if (row == 4'b1000)
    	    row <= 4'b0001;
    	else
    		row <= row << 1;   		     
    end
    
    always @(negedge btnclk)
    begin
        case (row)
    	   4'b0001:btn[3:0]=col;
    	   4'b0010:btn[7:4]=col;
    	   4'b0100:btn[11:8]=col;
    	   4'b1000:btn[15:12]=col;
    	   default:btn=0;   		   
        endcase
    end
    
    always @(posedge btnclk)
    begin
        btn0<=btn;
        btn1<=btn0;
        btn2<=btn1;
    end
    
    assign btnout=(btn2&btn1&btn0)|(~btn2&btn1&btn0);
    
    
endmodule