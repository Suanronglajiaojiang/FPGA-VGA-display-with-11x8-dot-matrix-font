module asciiDec #(
    parameter ASCII_WIDTH = 7,
    parameter ADDR_WIDTH = 11
    )(
    input [ASCII_WIDTH-1:0] ascii,
    input [3:0] lineCnt,
    output reg [ADDR_WIDTH-1:0] charaLineAddr
    );
    
    always@(*) begin
        if(ascii <= 31 || ascii > 127) begin
            charaLineAddr <= 11'b0;
        end
        else begin
            charaLineAddr <= (ascii - 32) * 11 + lineCnt;
        end
    end
    
    
endmodule
