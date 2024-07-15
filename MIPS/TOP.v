`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.07.2024 12:26:13
// Design Name: 
// Module Name: TOP
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module TOP(
    clk, wd, rd1, rd2
);

    input clk;
    output [31:0] wd, rd1, rd2;
    
    wire [31:0]adress;
    wire [31:0]instruction;
    wire [4:0]wa;

PC PC(
    .out(adress),
    .clk(clk)
);

IM IM(
    .adress(adress),
    .instruction(instruction)
);

MUX #(5) MUX(
    .in0(instruction[20:16]),
    .in1(instruction[15:11]),
//    .s(regdst),
    .out(wa)
);

RB RB(
    .ra1(instruction[25:21]),
    .ra2(instruction[20:16]),
    .wa(wa),
//    .wd(m2r)
);



endmodule
