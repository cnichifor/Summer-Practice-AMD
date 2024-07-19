`timescale 1ns / 1ps

module EXT(
    in,
    extop,
    out
);

input [15:0]in;
input extop;

output [31:0]out;

assign out = {{16{in[15]}}, in[15:0]};

endmodule

//module tb();
//    reg [15:0]in;
//    wire [31:0]out;
    
//    initial begin
//        #10 in = 32767;
//        #10 in = 32768;
//    end
    
//    EXT EXT(
//        .in(in),
//        .out(out)
//    );
//endmodule