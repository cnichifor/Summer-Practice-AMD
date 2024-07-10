`timescale 1ns / 1ps

module div(
    input clk,
    output reg clk_out
);

reg [3:0]c;    
    
initial begin 
    clk_out = clk;
    c = 0;
end    
    
always@(clk)begin
    c = c + 1;
    if(c == 2)begin 
        clk_out = ~clk_out;
        c = 0;
    end
end

endmodule
