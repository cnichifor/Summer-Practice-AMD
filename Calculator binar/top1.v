`timescale 1ns / 1ps


module top_top(
    input [11:0]switch,
    input [3:0]bt,
    input clk,
    output a, b, c, d, e, f, g,
    output [3:0]dout
);

wire [11:0]alu_result;

wire err, zero, und_of;
reg [1:0]muxsel;
reg [11:0]muxout;
reg [3:0]earf;
wire clk_out;

reg [11:0]r0, r1;
reg [3:0]rs;

// codificator jos
always@(*) begin
    case(bt)
        1: muxsel <= 1;
        2: muxsel <= 2;
        4: muxsel <= 3;
        9: r0 <= switch;
        10: r1 <= switch;
        12: rs <= switch;
        default: muxsel <= 0;
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

//module tb();

//reg clk = 0;
//reg [3:0]bt;
//reg [11:0]switch;

//wire [3:0]dout;
//wire a, b, c, d, e, f, g;


//initial begin
//    #10;
//    bt = 12;
//    switch = 0;
//    #10;
//    bt = 9;
//    switch = 201;
//    #10;
//    bt = 10;
//    switch = 40; 
//    #10;
//    bt = 0;
//    repeat(25)
//        #10 clk = ~clk;
        
//     #10 $finish;
//end

//top_top top_top(
//    .clk(clk),
//    .bt(bt),
//    .switch(switch),
//    .a(a), .b(b), .c(c), .d(d), .e(e), .f(f), .g(g),
//    .dout(dout)
//);
//endmodule
