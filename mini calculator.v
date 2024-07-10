`timescale 1ns / 1ps
module div(
    input clk,
    output reg clk_out
);

reg [3:0]c;    
    
initial begin 
    clk_out = clk;
    c = 0;
end    
    
always@(clk)begin
    c = c + 1;
    if(c == 2)begin 
        clk_out = ~clk_out;
        c = 0;
    end
end

endmodule

module digdec(
   input [3:0]in,
   output reg a, b, c, d, e, f, g
);

always @(*) begin
    a = 0;
    b = 0;
    c = 0;
    d = 0;
    e = 0;
    f = 0;
    g = 0;   
    case (in) 
         0: begin
            a = 1;            
            b = 1;
            c = 1;
            d = 1;
            e = 1;
            f = 1;  
         end
         
         1: begin
            c = 1; 
            b = 1;  
         end
         
         2: begin
            a = 1; 
            b = 1;  
            d = 1; 
            e = 1;  
            g = 1; 
         end
         
         3: begin
            a = 1; 
            b = 1; 
            c = 1; 
            d = 1;  
            g = 1; 
         end
         
         4: begin 
            b = 1; 
            c = 1;  
            f = 1; 
            g = 1; 
         end
         
         5: begin
            a = 1;  
            c = 1; 
            d = 1;  
            f = 1; 
            g = 1; 
         end
         
         6: begin
            a = 1; 
            c = 1; 
            d = 1; 
            e = 1; 
            f = 1; 
            g = 1; 
         end
         
         7: begin
            a = 1; 
            b = 1; 
            c = 1; 
         end
         
         8: begin
            a = 1; 
            b = 1; 
            c = 1; 
            d = 1; 
            e = 1; 
            f = 1; 
            g = 1; 
         end
         
         9: begin
            a = 1; 
            b = 1; 
            c = 1; 
            d = 1;  
            f = 1; 
            g = 1; 
         end
         
         default: begin
            a = 1;
            d = 1;
            e = 1;
            f = 1;
            g = 1;
         end
    endcase  
    a = ~a;
    b = ~b;
    c = ~c;
    d = ~d;
    e = ~e;
    f = ~f;
    g = ~g;     
end

endmodule 

module dec(
    input [1:0]a,
    output reg [3:0]b
);
    always @(*) begin
        b = 0;
        case (a)
            0: b = 1;
            1: b = 2;
            2: b = 4;
            3: b = 8;
            default: b = 15; 
        endcase
        b = ~b;
     end
endmodule

module cnt(
    input clk,
    output reg [1:0] o
);

initial o = 0;

always @(posedge clk)
    o = o + 1;
    
endmodule

module top(
    input [3:0]in0, in1, in2, in3,
    input clk,
    output [3:0]dout,
    output a, b, c, d, e, f, g
);

reg [3:0]muxout;
wire [1:0]cntout;

always @(posedge clk) begin
    case (cntout)
        0: muxout = in0;
        1: muxout = in1;
        2: muxout = in2;
        3: muxout = in3;
        default: muxout = 0;
    endcase
end

digdec digdec(
 .in(muxout),
 .a(a),
 .b(b),
 .c(c),
 .d(d),
 .e(e),
 .f(f),
 .g(g)
);

dec dec(
 .a(cntout),
 .b(dout)
);

cnt cnt(
    .clk(clk),
    .o(cntout)
);
endmodule

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

module top_top(
    input [11:0]r0, r1,
    input [3:0]rs,
    input [2:0]bt,
    input clk,
    output a, b, c, d, e, f, g,
    output [3:0]dout,
    output [11:0]alu_result
);

wire err, zero, und_of;
reg [1:0]muxsel;
reg [11:0]muxout;
reg [3:0]earf;
wire clk_out;

// codificator jos
always@(*) begin
    case(bt)
        1: muxsel <= 1;
        2: muxsel <= 2;
        4: muxsel <= 3;
        default: muxsel = 0;
    endcase
end 

// mux
always@(*) begin
    case(muxsel)
        0: muxout <= alu_result;
        1: muxout <= r0;
        2: muxout <= r1;
        3: muxout <= rs;
    endcase
end

//dec sus
always@(*) begin
    if(err)
        earf <= 10;
    else if(zero)
        earf <= 2;
    else if(und_of)
        earf <= 8;
    else earf = 0;
end

top top(
    .clk(clk_out),
    .in0(muxout[3:0]),
    .in1(muxout[7:4]),
    .in2(muxout[11:8]),
    .in3(earf),
    .a(a), .b(b), .c(c), .d(d), .e(e), .f(f), .g(g),
    .dout(dout)
);  

ALU  ALU(
        .a(r0),
        .b(r1),
        .s(rs),
        .o(alu_result),
        .err(err),
        .l(zero),
        .und_of(und_of)
);  

div div(
    .clk(clk),
    .clk_out(clk_out)
);
    
endmodule

module tb();

reg clk = 0;
reg [2:0]bt;
reg [11:0]r0, r1;
reg [3:0]rs;

wire [3:0]dout;
wire a, b, c, d, e, f, g;

wire [11:0]alu_result;

initial begin
    r0 = 11;
    r1 = 8;
    rs = 0;
    bt = 0;
    repeat(25)
        #10 clk = ~clk;
        
     #10 $finish;
end

top_top top_top(
    .clk(clk),
    .bt(bt),
    .r0(r0),
    .r1(r1),
    .rs(rs),
    .a(a), .b(b), .c(c), .d(d), .e(e), .f(f), .g(g),
    .dout(dout),
    
    .alu_result(alu_result)
);
endmodule
