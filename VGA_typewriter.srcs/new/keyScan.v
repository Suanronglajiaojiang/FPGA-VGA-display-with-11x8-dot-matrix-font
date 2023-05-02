module key_board#(
        parameter xKeyNum = 17
    )(
        input           clk,     //矩阵扫描周期不能过快
        //input           btnclk,     //20ms时钟
        // input [xKeyNum-1:0] xKeys,
        input   [3:0]   col,        //列
        output reg [3:0]   row,        //行
        output  [15:0]  btnout      //按键扫描输出
    );
    
    reg [15:0] btn = 0;
    reg [15:0] btn0 = 0;
    reg [15:0] btn1 = 0;
    reg [15:0] btn2 = 0;
    reg[31:0] cnt1 = 0;             
    reg[31:0] btnclk_cnt = 0;
    reg clk_ms = 0;
    reg btnclk = 0;
    
     always@(posedge clk) //把系统时钟分频 50M/1000=50000 1000HZ
     begin
         if(cnt1==26'd25000)
         begin
             clk_ms =~ clk_ms;
             cnt1 = 0;
         end
         else
         begin
              cnt1 = cnt1+1'b1;
         end
     end
     always@(posedge clk) //20MS 50M/50=1000000 50HZ
     begin
         if(btnclk_cnt==500000)
         begin
             btnclk =~ btnclk;
             btnclk_cnt = 0;
         end
         else
         begin
              btnclk_cnt = btnclk_cnt+1'b1;
         end
     end
           
    initial begin
        row <= 4'b0001;
    end
    
    always @(posedge clk_ms) begin
    	if (row == 4'b1000)
    	    row <= 4'b0001;
    	else
    		row <= row << 1;   		     
    end
    
    always @(negedge clk_ms) begin
        case (row)
    	   4'b0001:begin btn[3:0] <= col; end
    	   4'b0010:begin btn[7:4] <= col; end
    	   4'b0100:begin btn[11:8] <= col; end
    	   4'b1000:begin btn[15:12] <= col; end
    	   default:btn=0;   		   
        endcase
        // btn[xKeyNum+15:16] <= xKeys[xKeyNum-1:0];
    end
    
    always @(posedge btnclk)
    begin
        btn0<=btn;
        btn1<=btn0;
        btn2<=btn1;
    end
    
    assign btnout=(btn2&btn1&btn0)|(~btn2&btn1&btn0);
    
    
endmodule