`timescale 1ns / 1ps

module rom(
    clk,
    adress,
    out
);

reg [31:0]data[127:0];

input clk;
input [6:0]adress;
output reg [31:0]out;

always@(posedge clk)begin
    out = data[adress];
end
endmodule

module ram(
    clk,
    in,
    rw,
    adress,
    out
);

reg [31:0]data[127:0];

input rw;
input [31:0]in;
input clk;
input [6:0]adress;
output reg [31:0]out;

always@(posedge clk)begin
    out = data[adress];
    
    if(rw)begin
        data[adress] = in;
    end
end
endmodule
