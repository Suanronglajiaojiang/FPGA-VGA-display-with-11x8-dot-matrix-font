module exKeyIn #(
    parameter ASCII_WIDTH = 8
    )(
    input [ASCII_WIDTH-1:0] keyCode,
    output [ASCII_WIDTH-1:0] ascii
    );

    reg [ASCII_WIDTH-1:0] keyMap [255:0];
    initial begin
        $readmemb("keymap.mem",keyMap,0,255);
    end
// 
    // always@(posedge dataReady or negedge rst_n) begin
        // if(!rst_n)
            // ascii <= 7'b0;
        // else
            // ascii <= keyMap[keyCode];
    // end
    assign ascii = keyMap[keyCode];

endmodule
