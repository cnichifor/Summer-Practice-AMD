`timescale 1ns / 1ps

module PC(
    out,
    clk
);

input clk;

output reg [31:0]out = 0;

always@(posedge clk)begin
    out = out + 4;
end

endmodule

//module tb();
//    reg clk = 0;
//    wire [31:0]out;
    
//    initial begin
//    repeat(25)
//        #10 clk = ~clk;
//    #10 $finish;
//    end
    
//    PC PC(
//        .clk(clk),
//        .out(out)
//    );   

//endmodule

