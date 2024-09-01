`timescale 1ns / 1ps

module tb_segment();

    logic clk; 
    logic but1; 
    logic but2; 
    logic [7:0] cathode;
    logic [3:0] anode;
    
    always #5 clk = ~clk;
    
    always #100 but1 = ~but1;
    
    always #240 but2 = ~but2;
    
    initial begin
        clk = 0;
        but1 = 0;
        but2 = 0;
        end

        top UUT (
            .clk(clk),
            .but1(but1),
            .but2(but2),
            .cathode(cathode),
            .anode(anode)
        );
        
        
    
    
    
endmodule
