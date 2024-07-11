`timescale 1ns / 1ps

module div(
    clk,
    clk_out
);
input clk;
reg [31:0]c = 0; 
output reg clk_out = 0;
    
always@(posedge clk)begin
    c = c + 1;
    if(c == 50000)begin 
        clk_out = ~clk_out;
        c = 0;
    end
end

endmodule
