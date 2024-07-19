`timescale 1ns / 1ps

module tb;

    reg clk = 0;
    wire [31:0] rd1_reg, rd2_reg;
    wire [31:0] result;
    
    initial begin
        
        repeat(16)
            #10 clk = ~clk;
            
        #10 $finish;
    end

    TOP TOP(
        .clk(clk), 
        .result(result), 
        .rd1(rd1_reg), 
        .rd2(rd2_reg)
    );
endmodule