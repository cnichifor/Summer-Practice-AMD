`timescale 1ns / 1ps

module ALU(
    a, b,
    s,
    out, zero
);
input [31:0]a, b;
input [3:0]s;
output reg [31:0]out;
output reg zero;

always@(*)begin
    case(s)
        0: out <= a & b;
        1: out <= a | b;
        2: out <= a + b;
        3: out <= a - b;
        4: out <= a < b;
        5: out <= !(a | b);
    endcase
    zero <= out && 1;
end
endmodule