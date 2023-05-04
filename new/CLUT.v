module CLUT(
    input [3:0] index,
    output [11:0] color
    );
    
    reg [11:0] CLUT [15:0];
    
    assign color = CLUT [index];
    
    initial begin
        $readmemh("sweetie16_4b.mem", CLUT);
    end
    
endmodule