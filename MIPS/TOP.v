`timescale 1ns / 1ps

module TOP(
    clk, result, rd1, rd2
);

    input clk;
    output [31:0] result, rd1, rd2;
    
    wire zero;
    wire regwrite, regdst, alusrc, extop, memwrite, mem2reg, pcsrc, jump, varadd;
    wire [3:0] aluop;
    
    wire [31:0]adress;
    wire [31:0]instruction;
    wire [4:0]wa;
    wire [31:0] rd1, rd2, wd;
    wire [31:0] extidata;
    wire [31:0] alub;
    wire [31:0] rd;
    wire [31:0] nextadd;
    wire [31:0] shifteddata;
    wire [31:0] PCBranch;
    wire [31:0] PCin, PCb;
    wire [31:0] jadress;
    wire [4:0] saout, ra1;

MUX #(32) MUX0(
    .in0(nextadd),
    .in1(PCBranch),
    .s(pcsrc),
    .out(PCb)
);

PC PC(
    .out(adress),
    .clk(clk),
    .in(PCin)
);

plus4 plus4(
    .in(adress),
    .out(nextadd)
);

IM IM(
    .adress(adress),
    .instruction(instruction)
);

MUX #(5) MUX1(
    .in0(instruction[20:16]),
    .in1(instruction[15:11]),
    .s(regdst),
    .out(wa)
);

RB RB(
    .ra1(ra1),
    .ra2(instruction[20:16]),
    .wa(wa),
    .wd(wd),
    .clk(clk),
    .rd1(rd1),
    .rd2(rd2),
    .write(regwrite)
);

EXT EXT(
    .extop(extop),
    .in(instruction[15:0]),
    .out(extidata)
);

lshift2 lshift2(
    .in(extidata),
    .out(shifteddata)
);

SUM SUM(
    .a(shifteddata),
    .b(nextadd),
    .out(PCBranch)
);

MUX #(32) MUX2(
    .in0(rd2),
    .in1(extidata),
    .s(alusrc),
    .out(alub)
);

ALU ALU(
    .a(rd1),
    .b(alub),
    .s(aluop),
    .out(result),
    .zero(zero)
);

DM DM(
    .adress(result),
    .wd(rd2),
    .clk(clk),
    .write(memwrite),
    .rd(rd)
);

MUX #(32) MUX3(
    .in0(rd),
    .in1(result),
    .s(mem2reg),
    .out(wd)
);

MAIN MAIN(
    .opcode(instruction[31:26]),
    .func(instruction[5:0]) ,
    .zero(zero),
    .regdst(regdst), .extop(extop), .alusrc(alusrc), .aluop(aluop), .mem2reg(mem2reg), .memwrite(memwrite), .regwrite(regwrite), .pcsrc(pcsrc), .jump(jump),
    .varadd(varadd)
);

lshift2 lshift2j(
    .in(instruction[25:0]),
    .out(jadress)
);

MUX #(32) MUXj(
    .in0(PCb),
    .in1({nextadd[31:28], jadress[27:0]}),
    .s(jump),
    .out(PCin)
);

SA SA(
    .clk(clk),
    .in(rd1),
    .out(saout)
);

MUX #(5) MUXa(
    .in0(instruction[25:21]),
    .in1(saout),
    .s(varadd),
    .out(ra1)
);
endmodule