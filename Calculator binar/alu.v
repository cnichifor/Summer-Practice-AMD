`timescale 1ns / 1ps  


module ALU(
    input [11:0] a,
    input [11:0] b,
    input [3:0] s,
    output reg [11:0] o,
    output reg err,
    output reg l,
    output reg und_of
);

    always @(*) begin
        o = 0;
        err = 0;
        l = 0;
        und_of = 0;
        case(s)
            0: begin
                o = a + b;
                und_of = (o < a) || (o < b);
            end
            1: begin
                o = a - b;
                und_of = (o > a) || (o > b);
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
            default: o = 0;
        endcase
    end

endmodule
