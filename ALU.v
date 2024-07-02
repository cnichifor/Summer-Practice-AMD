`timescale 1ns / 1ps


module ALU#(
    parameter WIDTH = 1
)(
    input [WIDTH-1:0]a, b,
    input [3:0]s,
    output [WIDTH-1:0]o,
    output err,
    output l,
    output und, of
);

reg [WIDTH-1:0]o;
reg err;
reg l; 
reg und;
reg of;

always @(*)begin  
        und = 0; 
        err = 0;
        l = 0;
        of = 0;
        o = 0;
        case(s)
            0: begin 
                    o = a + b;
                    of = o < a || o < b;
                end 
            1: begin 
                    o = a - b;
                    und = o > a || o > b;
                end
            2: begin 
                    o = a << b;
                end
            3: begin 
                    o = a >> b;
                end
            4: begin 
                    l = a == b;
                end
            5: begin 
                    l = a > b;
                end
            6: begin 
                    l = a < b;
                end
            7: begin 
                    err = 1;
                end
        endcase
    end
    
endmodule


module tb;
    
    parameter WIDTH = 3;
    
    reg [WIDTH-1:0]a = 5; 
    reg [WIDTH-1:0]b = 5;
    reg [3:0]s;
    wire [WIDTH-1:0]o;
    wire err, l, und, of;
    initial begin
        #10;
        s = 0;
        #10;
        s = 1;
        #10;
        s = 2;
        #10;
        s = 3;
        #10;
        s = 4;
        #10;
        s = 5;
        #10;
        s = 6;
        #10;
        s = 7;
        #10;
        $finish;
    end

    ALU #(WIDTH) uut (
        .a(a),
        .b(b),
        .s(s),
        .o(o),
        .err(err),
        .l(l),
        .und(und),
        .of(of)
    );

endmodule
