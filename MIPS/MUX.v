`timescale 1ns / 1ps

module MUX#(parameter l = 1)(
    in0,
    in1,
    s,
    out
);
    input [l - 1:0]in0, in1;
    input s;
    output [l - 1:0]out;
    
    
    assign out = s ? in1 : in0;
endmodule
