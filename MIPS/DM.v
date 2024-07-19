`timescale 1ns / 1ps

module DM(
    adress,
    wd,
    clk,
    write,
    rd
);
    input [31:0]adress;
    input [31:0]wd;
    input clk, write;
    
    output reg [31:0]rd;
    
    reg [31:0]data[31:0];
    
    always@(posedge clk)begin
        if(write) data[adress] <= wd;
        rd <= data[adress];
    end 

endmodule
