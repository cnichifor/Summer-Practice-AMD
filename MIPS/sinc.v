`timescale 1ns / 1ps

module SA(
    in, out, clk
);

    input [31:0] in;
    input clk;
    output reg [4:0] out;
    
    always@(posedge clk) begin
        out <= in[4:0];
    end
endmodule
