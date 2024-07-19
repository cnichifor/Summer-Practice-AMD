`timescale 1ns / 1ps

module IM(
    adress,
    instruction
);

    input [31:0]adress;

    output [31:0]instruction;
    
    reg [7:0]data[31:0];
    
    initial $readmemh ("data.mem", data);

    assign instruction = {data[adress], data[adress + 1], data[adress + 2], data[adress + 3]};
endmodule


//module tb();
//    reg [31:0]adress = 0;
//    wire [31:0]instruction;
    
//    initial begin 
//        repeat(20)begin
//            #10 adress =  adress + 1;
//        end
//    end
    
//    IM IM(
//        .adress(adress),
//        .instruction(instruction)
//    );
//endmoduleendmodule
