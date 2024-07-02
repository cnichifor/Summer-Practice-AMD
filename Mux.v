`timescale 1ns / 1ps


module Mux#(
    parameter WIDTH = 1
) (
    input [WIDTH-1:0] a, b,
    input s,
    output [WIDTH-1:0] o
);
//    assign o = s ? b : a;
    assign o = a & {WIDTH {~s}} | b & {WIDTH {s}};
endmodule

module tb;
    
    parameter WIDTH = 10;
    
    reg [WIDTH-1:0]a = 6; 
    reg [WIDTH-1:0]b = 5;
    reg s;
    wire [WIDTH-1:0]o;
    
    initial begin
        #10;
        s = 0;
        #10;
        s = 1;
        #10;
        s = 0;
        #10;
        s = 1;
        #10;
        $finish;
    end

    Mux #(WIDTH) uut (
        .a(a),
        .b(b),
        .s(s),
        .o(o)
    );

endmodule
