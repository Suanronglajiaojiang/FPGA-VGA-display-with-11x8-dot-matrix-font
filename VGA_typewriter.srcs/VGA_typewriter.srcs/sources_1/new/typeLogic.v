module typeLogic #(
        parameter xKeyNum = 17,
        parameter GRID_COL = 10,
        parameter GRID_ROW = 5
    )(            
        input shift,        
        input [xKeyNum+14:0] btn,      
        output reg [$clog2(GRID_COL*GRID_ROW)-1:0] bufferPos = 0,
        output reg [6:0] asciiWrite,
        output writeEn
    ); 
    

    
    assign writeEn = btn != 32'b0;
        
    always @ (posedge writeEn) begin
        if(writeEn) begin
            if(!btn[31] && !btn[30]) begin
                bufferPos <= bufferPos<GRID_COL*GRID_ROW-1 ? bufferPos + 1 : 0;
            end
            if(shift) begin
                case (btn[31:0])
                    32'h00000001 : asciiWrite <= 7'd32;// '0' 
                    32'h00000002 : asciiWrite <= 7'd33;// '9'
                    32'h00000004 : asciiWrite <= 7'd34;// '8'
                    32'h00000008 : asciiWrite <= 7'd35;// '7'
                    32'h00000010 : asciiWrite <= 7'd36;// ')'
                    32'h00000020 : asciiWrite <= 7'd37;// '6'
                    32'h00000040 : asciiWrite <= 7'd38;// '5'
                    32'h00000080 : asciiWrite <= 7'd39;// '4'
                    32'h00000100 : asciiWrite <= 7'd40;// '('
                    32'h00000200 : asciiWrite <= 7'd41;// '3'
                    32'h00000400 : asciiWrite <= 7'd42;// '2'
                    32'h00000800 : asciiWrite <= 7'd43;// '1'
                    32'h00001000 : asciiWrite <= 7'd44;// '/' 
                    32'h00002000 : asciiWrite <= 7'd45;// '*'
                    32'h00004000 : asciiWrite <= 7'd46;// '-'
                    32'h00008000 : asciiWrite <= 7'd47;// '+'
                    32'h00010000 : asciiWrite <= 7'd48;// '0'
                    32'h00020000 : asciiWrite <= 7'd49;// '9'
                    32'h00040000 : asciiWrite <= 7'd50;// '8'
                    32'h00080000 : asciiWrite <= 7'd51;// '7'
                    32'h00100000 : asciiWrite <= 7'd52;// ')'
                    32'h00200000 : asciiWrite <= 7'd53;// '6'
                    32'h00400000 : asciiWrite <= 7'd54;// '5'
                    32'h00800000 : asciiWrite <= 7'd55;// '4'
                    32'h01000000 : asciiWrite <= 7'd56;// '('
                    32'h02000000 : asciiWrite <= 7'd57;// '3'
                    32'h04000000 : asciiWrite <= 7'd58;// '2'
                    32'h08000000 : asciiWrite <= 7'd59;// '1'
                    32'h10000000 : asciiWrite <= 7'd60;// '/'
                    32'h20000000 : asciiWrite <= 7'd61;// '*'
                    32'h40000000 : bufferPos <= bufferPos>0 ? bufferPos - 1 : GRID_COL*GRID_ROW-1;
                    32'h80000000 : bufferPos <= bufferPos<GRID_COL*GRID_ROW-1 ? bufferPos + 1 : 0;
                    default : asciiWrite <= 7'h00 ;// 'NULL'
                endcase
            end
            else if(!shift) begin
                case (btn[31:0])
                    32'h00000001 : asciiWrite <= 7'd62;// ' ' 
                    32'h00000002 : asciiWrite <= 7'd63;// ' '
                    32'h00000004 : asciiWrite <= 7'd64;// ' '
                    32'h00000008 : asciiWrite <= 7'd65;// ' '
                    32'h00000010 : asciiWrite <= 7'd66;// ' '
                    32'h00000020 : asciiWrite <= 7'd67;// ' '
                    32'h00000040 : asciiWrite <= 7'd68;// ' '
                    32'h00000080 : asciiWrite <= 7'd69;// ' '
                    32'h00000100 : asciiWrite <= 7'd70;// ' '
                    32'h00000200 : asciiWrite <= 7'd71;// ' '
                    32'h00000400 : asciiWrite <= 7'd72;// ' '
                    32'h00000800 : asciiWrite <= 7'd73;// ' '
                    32'h00001000 : asciiWrite <= 7'd74;// ' ' 
                    32'h00002000 : asciiWrite <= 7'd75;// ' '
                    32'h00004000 : asciiWrite <= 7'd76;// ' '
                    32'h00008000 : asciiWrite <= 7'd77;// ' '
                    32'h00010000 : asciiWrite <= 7'd78;// ' '
                    32'h00020000 : asciiWrite <= 7'd79;// ' '
                    32'h00040000 : asciiWrite <= 7'd80;// ' '
                    32'h00080000 : asciiWrite <= 7'd81;// ' '
                    32'h00100000 : asciiWrite <= 7'd82;// ' '
                    32'h00200000 : asciiWrite <= 7'd83;// ' '
                    32'h00400000 : asciiWrite <= 7'd84;// ' '
                    32'h00800000 : asciiWrite <= 7'd85;// ' '
                    32'h01000000 : asciiWrite <= 7'd86;// ' '
                    32'h02000000 : asciiWrite <= 7'd87;// ' '
                    32'h04000000 : asciiWrite <= 7'd88;// ' '
                    32'h08000000 : asciiWrite <= 7'd89;// ' '
                    32'h10000000 : asciiWrite <= 7'd90;// ' '
                    32'h20000000 : asciiWrite <= 7'd91;// ' '
                    32'h40000000 : bufferPos <= bufferPos>0 ? bufferPos - 1 : GRID_COL*GRID_ROW-1;
                    32'h80000000 : bufferPos <= bufferPos<GRID_COL*GRID_ROW-1 ? bufferPos + 1 : 0;
                    default : asciiWrite <= 7'h00 ;// 'NULL'
                endcase
            end
        end  
    end          
    
endmodule