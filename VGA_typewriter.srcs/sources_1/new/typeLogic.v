module typeLogic// #()
    (   
    //   input clk,
    //     input  [3:0]   col,         
    //     output [3:0]   row,        
        input [15:0] btn,      
        output reg [5:0] wrPos_x = 0,
        output reg [5:0] wrPos_y = 0,
        output reg [6:0] asciiWrite,
        output writeEn
    ); 
    

    
    assign writeEn = btn != 16'b0;
    
    always @ (posedge writeEn) begin
        wrPos_x <= wrPos_x == 9 ? 0 : wrPos_x + 1;
        wrPos_y <= wrPos_x == 9 ? (wrPos_y == 4 ? 0 : wrPos_y + 1) : wrPos_y ;
        case (btn)
            16'h0001 : asciiWrite <= 7'h30;// '0' 
            16'h0002 : asciiWrite <= 7'h39;// '9'
            16'h0004 : asciiWrite <= 7'h38;// '8'
            16'h0008 : asciiWrite <= 7'h37;// '7'
            16'h0010 : asciiWrite <= 7'h29;// ')'
            16'h0020 : asciiWrite <= 7'h36;// '6'
            16'h0040 : asciiWrite <= 7'h35;// '5'
            16'h0080 : asciiWrite <= 7'h34;// '4'
            16'h0100 : asciiWrite <= 7'h28;// '('
            16'h0200 : asciiWrite <= 7'h33;// '3'
            16'h0400 : asciiWrite <= 7'h32;// '2'
            16'h0800 : asciiWrite <= 7'h32;// '1'
            16'h1000 : asciiWrite <= 7'h2F;// '/' 
            16'h2000 : asciiWrite <= 7'h2A;// '*'
            16'h4000 : asciiWrite <= 7'h2D;// '-'
            16'h8000 : asciiWrite <= 7'h2B;// '+'
            default : ;// 'NULL'
        endcase  
    end          
    
endmodule