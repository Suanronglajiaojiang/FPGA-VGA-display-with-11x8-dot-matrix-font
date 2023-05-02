module typeLogic #(
        parameter xKeyNum = 17,
        parameter GRID_COL = 10,
        parameter GRID_ROW = 5
    )(            
        input [2:0] shift, 
        input [15:0] btn,      
        output reg [6:0] asciiWrite,
        output writeEn
    ); 

    
    assign writeEn = btn[15:0] != 15'b0; 
        
    always @ (posedge writeEn) begin
        if(writeEn) begin
            if(shift==3'b000) begin
                case (btn[15:4])
                    12'h001: begin asciiWrite <= 7'd32; end // ' '
                    12'h002: begin asciiWrite <= 7'd33; end // ' '
                    12'h004: begin asciiWrite <= 7'd34; end // ' '
                    12'h008: begin asciiWrite <= 7'd35; end // ' '
                    12'h010: begin asciiWrite <= 7'd36; end // ' '
                    12'h020: begin asciiWrite <= 7'd37; end // ' '
                    12'h040: begin asciiWrite <= 7'd38; end // ' '
                    12'h080: begin asciiWrite <= 7'd39; end // ' '
                    12'h100: begin asciiWrite <= 7'd40; end // ' ' 
                    12'h200: begin asciiWrite <= 7'd41; end // ' '
                    12'h400: begin asciiWrite <= 7'd42; end // ' '
                    12'h800: begin asciiWrite <= 7'd43; end // ' '
                    default : asciiWrite <= 7'h00 ;// 'N
                endcase
            end
            if(shift==3'b001) begin
                case (btn[15:4])
                    12'h001: begin asciiWrite <= 7'd44; end // ' '
                    12'h002: begin asciiWrite <= 7'd45; end // ' '
                    12'h004: begin asciiWrite <= 7'd46; end // ' '
                    12'h008: begin asciiWrite <= 7'd47; end // ' '
                    12'h010: begin asciiWrite <= 7'd48; end // ' '
                    12'h020: begin asciiWrite <= 7'd49; end // ' '
                    12'h040: begin asciiWrite <= 7'd50; end // ' '
                    12'h080: begin asciiWrite <= 7'd51; end // ' '
                    12'h100: begin asciiWrite <= 7'd52; end // ' ' 
                    12'h200: begin asciiWrite <= 7'd53; end // ' '
                    12'h400: begin asciiWrite <= 7'd54; end // ' '
                    12'h800: begin asciiWrite <= 7'd55; end // ' '
                    default : asciiWrite <= 7'h00 ;// 'N
                endcase
            end
            if(shift==3'b010) begin
                case (btn[15:4])
                    12'h001: begin asciiWrite <= 7'd56; end // ' '
                    12'h002: begin asciiWrite <= 7'd57; end // ' '
                    12'h004: begin asciiWrite <= 7'd58; end // ' '
                    12'h008: begin asciiWrite <= 7'd59; end // ' '
                    12'h010: begin asciiWrite <= 7'd60; end // ' '
                    12'h020: begin asciiWrite <= 7'd61; end // ' '
                    12'h040: begin asciiWrite <= 7'd62; end // ' '
                    12'h080: begin asciiWrite <= 7'd63; end // ' '
                    12'h100: begin asciiWrite <= 7'd64; end // ' ' 
                    12'h200: begin asciiWrite <= 7'd65; end // ' '
                    12'h400: begin asciiWrite <= 7'd66; end // ' '
                    12'h800: begin asciiWrite <= 7'd67; end // ' '
                    default : asciiWrite <= 7'h00 ;// 'N
                endcase
            end
            if(shift==3'b011) begin
                case (btn[15:4])
                    12'h001: begin asciiWrite <= 7'd68; end // ' '
                    12'h002: begin asciiWrite <= 7'd69; end // ' '
                    12'h004: begin asciiWrite <= 7'd70; end // ' '
                    12'h008: begin asciiWrite <= 7'd71; end // ' '
                    12'h010: begin asciiWrite <= 7'd72; end // ' '
                    12'h020: begin asciiWrite <= 7'd73; end // ' '
                    12'h040: begin asciiWrite <= 7'd74; end // ' '
                    12'h080: begin asciiWrite <= 7'd75; end // ' '
                    12'h100: begin asciiWrite <= 7'd76; end // ' ' 
                    12'h200: begin asciiWrite <= 7'd77; end // ' '
                    12'h400: begin asciiWrite <= 7'd78; end // ' '
                    12'h800: begin asciiWrite <= 7'd79; end // ' '
                    default : asciiWrite <= 7'h00 ;// 'N
                endcase
            end
            if(shift==3'b100) begin
                case (btn[15:4])
                    12'h001: begin asciiWrite <= 7'd80; end // ' '
                    12'h002: begin asciiWrite <= 7'd81; end // ' '
                    12'h004: begin asciiWrite <= 7'd82; end // ' '
                    12'h008: begin asciiWrite <= 7'd83; end // ' '
                    12'h010: begin asciiWrite <= 7'd84; end // ' '
                    12'h020: begin asciiWrite <= 7'd85; end // ' '
                    12'h040: begin asciiWrite <= 7'd86; end // ' '
                    12'h080: begin asciiWrite <= 7'd87; end // ' '
                    12'h100: begin asciiWrite <= 7'd88; end // ' ' 
                    12'h200: begin asciiWrite <= 7'd89; end // ' '
                    12'h400: begin asciiWrite <= 7'd90; end // ' '
                    12'h800: begin asciiWrite <= 7'd91; end // ' '
                    default : asciiWrite <= 7'h00 ;// 'N
                endcase
            end
            if(shift==3'b101) begin
                case (btn[15:4])
                    12'h001: begin asciiWrite <= 7'd92; end // ' '
                    12'h002: begin asciiWrite <= 7'd93; end // ' '
                    12'h004: begin asciiWrite <= 7'd94; end // ' '
                    12'h008: begin asciiWrite <= 7'd95; end // ' '
                    12'h010: begin asciiWrite <= 7'd96; end // ' '
                    12'h020: begin asciiWrite <= 7'd97; end // ' '
                    12'h040: begin asciiWrite <= 7'd98; end // ' '
                    12'h080: begin asciiWrite <= 7'd99; end // ' '
                    12'h100: begin asciiWrite <= 7'd100; end // ' ' 
                    12'h200: begin asciiWrite <= 7'd101; end // ' '
                    12'h400: begin asciiWrite <= 7'd102; end // ' '
                    12'h800: begin asciiWrite <= 7'd103; end // ' '
                    default : asciiWrite <= 7'h00 ;// 'N
                endcase
            end
            if(shift==3'b110) begin
                case (btn[15:4])
                    12'h001: begin asciiWrite <= 7'd104; end // ' '
                    12'h002: begin asciiWrite <= 7'd105; end // ' '
                    12'h004: begin asciiWrite <= 7'd106; end // ' '
                    12'h008: begin asciiWrite <= 7'd107; end // ' '
                    12'h010: begin asciiWrite <= 7'd108; end // ' '
                    12'h020: begin asciiWrite <= 7'd109; end // ' '
                    12'h040: begin asciiWrite <= 7'd110; end // ' '
                    12'h080: begin asciiWrite <= 7'd111; end // ' '
                    12'h100: begin asciiWrite <= 7'd112; end // ' ' 
                    12'h200: begin asciiWrite <= 7'd113; end // ' '
                    12'h400: begin asciiWrite <= 7'd114; end // ' '
                    12'h800: begin asciiWrite <= 7'd115; end // ' '
                    default : asciiWrite <= 7'h00 ;// 'N
                endcase
            end
            if(shift==3'b111) begin
                case (btn[15:4])
                    12'h001: begin asciiWrite <= 7'd116; end // ' '
                    12'h002: begin asciiWrite <= 7'd117; end // ' '
                    12'h004: begin asciiWrite <= 7'd118; end // ' '
                    12'h008: begin asciiWrite <= 7'd119; end // ' '
                    12'h010: begin asciiWrite <= 7'd120; end // ' '
                    12'h020: begin asciiWrite <= 7'd121; end // ' '
                    12'h040: begin asciiWrite <= 7'd122; end // ' '
                    12'h080: begin asciiWrite <= 7'd123; end // ' '
                    12'h100: begin asciiWrite <= 7'd124; end // ' ' 
                    12'h200: begin asciiWrite <= 7'd125; end // ' '
                    12'h400: begin asciiWrite <= 7'd126; end // ' '
                    12'h800: begin asciiWrite <= 7'd127; end // ' '
                    default : asciiWrite <= 7'h00 ;// 'N
                endcase
            end
        end  
    end          
    
endmodule