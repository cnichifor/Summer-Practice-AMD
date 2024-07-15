`timescale 1ns / 1ps

module MAIN(
    opcode,
    func, 
    zero,
    regdst, extop, alusrc, aluop, mem2reg, memwrite, regwrite
);
input [5:0]opcode, func;
input zero;

output reg [3:0]aluop;
output reg regdst, extop, alusrc, mem2reg, memwrite, regwrite;

always@(*)begin
    if(!opcode)begin
        regdst <= 1; 
        extop <= 0;
        alusrc <= 0; 
        mem2reg <= 1;
        memwrite <= 0; 
        regwrite <= 1;
        
        case(func)
            32: aluop = 2;
            34: aluop = 3;
            36: aluop = 0;
            37: aluop = 1;
            42: aluop = 4;
            default: aluop = 5;
        endcase
    end
    
    else begin
        regdst <= 0; 
        extop <= 1;
        alusrc <= 1; 
        mem2reg <= 0;
        memwrite <= 1; 
        regwrite <= 1;
    end 
end

endmodule
