`timescale 1ns / 1ps

module ram(
    input clk,
    input write,
    input [6:0]adress,
    input [31:0]in,
    output reg [31:0]out
);

reg [32:0]data[126:0];

always @(*)begin
    if(write)begin
       data[adress] = in;
    end
end

always @(posedge clk) begin 
    out <= data[adress];
end

endmodule

module tc();

reg clk = 0;
reg write = 0;
reg [6:0]adress;
reg [31:0]in;

wire [31:0]out;

initial begin
    
    #10; 
    in = 5;
    write = 1;
    adress = 24;
    
    #10;
    in = 12;
    write = 1;
    adress = 1;
    
    #10 write = 0;
    
    repeat(64) begin
        repeat(2) begin
        #10;
        clk = ~clk;
        end
        
        adress = adress + 1;
    end

    #10 $finish;
end

ram ram(
    .clk(clk),
    .in(in),
    .write(write),
    .out(out),
    .adress(adress)
);
endmodule
