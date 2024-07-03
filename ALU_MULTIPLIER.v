`timescale 1ns / 1ps

module ALU #(
    parameter length = 1
)(
    input [length-1:0] a,
    input [length-1:0] b,
    input [3:0] s,
    output reg [length-1:0] o,
    output reg err,
    output reg l,
    output reg und,
    output reg of
);

    always @(*) begin
        case(s)
            0: begin
                o = a + b;
                of = (o < a) || (o < b);
            end
            1: begin
                o = a - b;
                und = (o > a) || (o > b);
            end
            2: begin
                o = a << b;
            end
            3: begin
                o = a >> b;
            end
            4: begin
                l = (a == b);
            end
            5: begin
                l = (a > b);
            end
            6: begin
                l = (a < b);
            end
            7: begin
                err = 1;
            end
        endcase
    end

endmodule

module MLT #(
    parameter length = 1
)(
    input [length-1:0] a,
    input [length-1:0] b,
    output [length-1:0] o
);

    reg [length-1:0] sum;
    reg [length-1:0] alua;
    reg [length-1:0] alub;
    reg [3:0] s;
    wire [length-1:0] alu_result;
    wire err, l, und, of;
    integer i;

    ALU #(length) alu (
        .a(alua),
        .b(alub),
        .s(s),
        .o(alu_result),
        .err(err),
        .l(l),
        .und(und),
        .of(of)
    );

    always @(*) begin
        sum = 0;
        for (i = 0; i < length; i = i + 1) begin
            if (b[i]) begin
                #10;
                alua = a;
                alub = i;
                s = 2;
                #10;
                alua = sum;
                alub = alu_result;
                s = 0;
                #10;
                sum = alu_result;
            end
        end
    end

    assign o = sum;
endmodule

module tb;

    parameter length = 32;

    reg [length-1:0] a;
    reg [length-1:0] b;
    wire [length-1:0] o;

    initial begin
        #10;
        a = 3;
        b = 12;
    end

    MLT #(length) mlt (
        .a(a),
        .b(b),
        .o(o)
    );

endmodule
