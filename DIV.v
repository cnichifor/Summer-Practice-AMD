module div(
    input [3:0]a,
    input clk,
    input pl,
    output reg clk_out,
    output reg [3:0]c
);

    reg [3:0]din;
    always @(posedge pl)begin
        din = a;
        
    end
    always @(a)begin
        c = 0;
        clk_out = 0;
    end

    
    always@(clk)begin
        c = c + 1;
        if(din <= c)begin 
            clk_out = ~clk_out;
            c = 0;
        end
    end

endmodule

module tb();

    reg clk;
    reg pl;
    reg [3:0]a = 2;
    wire clk_out;
    wire [3:0]c;
 
    initial begin
        #0 clk = 0;
        repeat(100) begin
            #10 clk = ~clk;
        end
    end
    
    div d(
        .clk(clk),
        .a(a),
        .clk_out(clk_out),
        .c(c),
        .pl(pl)
    );

endmodule
