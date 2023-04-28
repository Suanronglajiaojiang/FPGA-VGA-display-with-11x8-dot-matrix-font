module charrom_tb;
    reg [10:0] addr = 0;
    wire [7:0] line;
    
    charaROM charrom (
        addr,
        line
    );
    
    always #10 addr = addr + 1;
    

    
endmodule
       