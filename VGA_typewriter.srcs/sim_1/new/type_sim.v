module type_sim;
    reg [15:0] btn;
    wire [5:0] wrPos_x;
    wire [5:0] wrPos_y;
    wire [6:0] asciiWrite;
    wire writeEn;    
    
    typeLogic Typer(
        btn,
        wrPos_x,
        wrPos_y,
        asciiWrite,
        writeEn
    );
    
    reg [15:0] shifter;
    reg clk = 0;
    
    always #10 clk = ~clk;
    
    initial begin
        btn <= 0;
        shifter <= 16'b1;
    end
    
    always@ (posedge clk) begin
        if (btn == 0) begin
            btn <= shifter;
            shifter <= {shifter[14:0],shifter[15]};
        end
        else begin
            btn <= 0;
        end
    end
  
    
endmodule
