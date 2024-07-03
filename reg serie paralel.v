`timescale 1ns / 1ps

module serial (
    input D,
    input CLK,
    output reg Q0, Q1, Q2
);
 
    always @(posedge CLK)begin
        Q0 <= D;
        Q1 <= Q0;
        Q2 <= Q1;
    end

endmodule

module paralel (
    input A, B, C,
    input CLK,
    output reg Q0, Q1, Q2
);
    always @(posedge CLK)begin
        Q0 <= A;
        Q1 <= B;
        Q2 <= C;
    end
endmodule


module tb();
//    reg D;
    reg A, B, C;
    reg CLK;
    wire Q0, Q1, Q2;
    initial begin
//        D = 0;
        A = 0; B = 1; C = 0;
        CLK = 0;
        repeat(20) begin
//            #10 D = ~D;
            #10 A = ~A;
            #10 B = ~B;
            #10 C = ~C;
            repeat(2) begin
                #10 CLK = ~CLK;
            end
        end
    end
    
//    serial serial(
//        .D(D),
//        .CLK(CLK),
//        .Q0(Q0),
//        .Q1(Q1),
//        .Q2(Q2)
//    );
    
    paralel paralel(
        .A(A),
        .B(B),
        .C(C),
        .CLK(CLK),
        .Q0(Q0),
        .Q1(Q1),
        .Q2(Q2)
    );

endmodule
