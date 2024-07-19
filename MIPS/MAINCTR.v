`timescale 1ns / 1ps

module MAIN(
    opcode,
    func, 
    zero,
    regdst, extop, alusrc, aluop, mem2reg, memwrite, regwrite, pcsrc, jump
);
input [5:0]opcode, func;
input zero;

output reg [3:0]aluop;
output reg regdst, extop, alusrc, mem2reg, memwrite, regwrite, pcsrc, jump;

always@(*)begin
    if(opcode == 0)begin
        jump <= 0;
        pcsrc <= 0;
        regdst <= 1; 
        extop <= 0;
        alusrc <= 0; 
        mem2reg <= 1;
        memwrite <= 0; 
        regwrite <= 1;
        
        case(func)
            32: aluop <= 2;
            34: aluop <= 3;
            36: aluop <= 0;
            37: aluop <= 1;
            42: aluop <= 4;
            default: aluop <= 5;
        endcase
    end
    
    else if(opcode == 8)begin
        jump <= 0;
        pcsrc <= 0;
        regdst <= 0; 
        extop <= 1;
        alusrc <= 1; 
        mem2reg <= 1;
        memwrite <= 0; 
        regwrite <= 1;
        aluop <= 2;
    end
    
    else if(opcode == 35) begin
        jump <= 0;
        pcsrc <= 0;
        regdst <= 0; 
        extop <= 1;
        alusrc <= 1; 
        mem2reg <= 0;
        memwrite <= 0; 
        regwrite <= 1;
        aluop <= 2;
    end
    
    else if(opcode == 43) begin
        jump <= 0;
        pcsrc <= 0;
        regdst <= 0; 
        extop <= 1;
        alusrc <= 1; 
        mem2reg <= 0;
        memwrite <= 1; 
        regwrite <= 0;
        aluop <= 2;
    end
    
    else if(opcode == 4) begin
        jump <= 0;
        pcsrc <= zero;
        regdst <= 0; 
        extop <= 1;
        alusrc <= 1; 
        mem2reg <= 1;
        memwrite <= 0; 
        regwrite <= 0;
        aluop <= 3;
    end
    
    else if(opcode == 2) begin
        jump <= 1;
        pcsrc <= 0;
        regdst <= 0; 
        extop <= 0;
        alusrc <= 0; 
        mem2reg <= 0;
        memwrite <= 0; 
        regwrite <= 0;
        aluop <= 0;
    end
    
    else begin
        jump <= 0;
        pcsrc <= 0;
        regdst <= 0; 
        extop <= 0;
        alusrc <= 0; 
        mem2reg <= 0;
        memwrite <= 0; 
        regwrite <= 0;
    end 
end

endmodule