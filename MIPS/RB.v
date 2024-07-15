`timescale 1ns / 1ps

module RB(
    ra1, ra2,
    wa, wd,
    clk,
    write,
    rd1, rd2
);

    input [4:0]ra1, ra2, wa;
    input [31:0] wd;
    input clk, write;
    
    output reg [31:0]rd1, rd2;
    
    reg [31:0]data[31:0];
    
    always@(posedge clk)begin
        if(write) data[wa] <= wd;
        rd1 <= data[ra1];
        rd2 <= data[rd2];
    end
endmodule
