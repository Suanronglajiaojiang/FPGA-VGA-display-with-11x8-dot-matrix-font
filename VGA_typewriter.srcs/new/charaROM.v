module charaROM #(
    parameter CHARA_WIDTH = 8,
    parameter ADDR_WIDTH = 11
    )(
    input [ADDR_WIDTH-1:0] addr,
    output [CHARA_WIDTH-1:0] charaLine
    );
    
    reg [CHARA_WIDTH-1:0] charaROM [1044:0];
   
    initial
        $readmemh("ascii.mem", charaROM,0,1044);
        
    assign charaLine = charaROM [addr];
    
endmodule
