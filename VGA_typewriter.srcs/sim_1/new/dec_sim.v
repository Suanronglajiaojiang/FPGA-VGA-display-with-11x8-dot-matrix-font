module dec_tb;
    reg [6:0] ascii = 0;
    reg [3:0] line = 0;
    wire [10:0] addr;
    
    asciiDec dec(
        ascii,
        line,
        addr
    );
    
    always #10 line =( (line == 10) ? 0 : line + 1);
    
    always@( negedge line == 10 )
         ascii = line == 10 ? ascii : ascii + 1;
    
    

endmodule
