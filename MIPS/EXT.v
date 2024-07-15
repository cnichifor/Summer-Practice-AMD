`timescale 1ns / 1ps

module EXT(
    in,
    extop,
    out
);

input [15:0]in;
input extop;

output [31:0]out;

assign out = in[15] & extop ? 32'd4294901760 + in : in;

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
