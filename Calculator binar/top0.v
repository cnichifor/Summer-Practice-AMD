`timescale 1ns / 1ps

module digdec(
   input [3:0]in,
   output reg a, b, c, d, e, f, g
);

always @(*) begin
    a = 0;
    b = 0;
    c = 0;
    d = 0;
    e = 0;
    f = 0;
    g = 0;   
    case (in) 
         0: begin
            a = 1;            
            b = 1;
            c = 1;
            d = 1;
            e = 1;
            f = 1;  
         end
         
         1: begin
            c = 1; 
            b = 1;  
         end
         
         2: begin
            a = 1; 
            b = 1;  
            d = 1; 
            e = 1;  
            g = 1; 
         end
         
         3: begin
            a = 1; 
            b = 1; 
            c = 1; 
            d = 1;  
            g = 1; 
         end
         
         4: begin 
            b = 1; 
            c = 1;  
            f = 1; 
            g = 1; 
         end
         
         5: begin
            a = 1;  
            c = 1; 
            d = 1;  
            f = 1; 
            g = 1; 
         end
         
         6: begin
            a = 1; 
            c = 1; 
            d = 1; 
            e = 1; 
            f = 1; 
            g = 1; 
         end
         
         7: begin
            a = 1; 
            b = 1; 
            c = 1; 
         end
         
         8: begin
            a = 1; 
            b = 1; 
            c = 1; 
            d = 1; 
            e = 1; 
            f = 1; 
            g = 1; 
         end
         
         9: begin
            a = 1; 
            b = 1; 
            c = 1; 
            d = 1;  
            f = 1; 
            g = 1; 
         end
         
         10: begin
            a = 1; 
            b = 1; 
            c = 1; 
            e = 1; 
            f = 1; 
            g = 1; 
         end
         
         11: begin 
            c = 1; 
            d = 1; 
            e = 1; 
            f = 1; 
            g = 1; 
         end
         
         12: begin
            a = 1;  
            d = 1; 
            e = 1; 
            f = 1;  
         end
         
         13: begin 
            b = 1; 
            c = 1; 
            d = 1; 
            e = 1; 
            g = 1;   
         end
         
         14: begin
            a = 1; 
            d = 1; 
            e = 1; 
            f = 1; 
            g = 1; 
         end
         
         15: begin
            a = 1;  
            e = 1; 
            f = 1; 
            g = 1; 
         end
         
         default: begin
            a = 1;
            d = 1;
            e = 1;
            f = 1;
            g = 1;
         end
    endcase  
    a = ~a;
    b = ~b;
    c = ~c;
    d = ~d;
    e = ~e;
    f = ~f;
    g = ~g;     
end

endmodule 

module dec(
    input [1:0]a,
    output reg [3:0]b
);
    always @(*) begin
        b = 0;
        case (a)
            0: b = 1;
            1: b = 2;
            2: b = 4;
            3: b = 8;
            default: b = 15; 
        endcase
        b = ~b;
     end
endmodule

module cnt(
    input clk,
    output reg [1:0] o
);

initial o = 0;

always @(posedge clk)
    o = o + 1;
    
endmodule

//topmodule
module top(
    input [3:0]in0, in1, in2, in3,
    input clk,
    output [3:0]dout,
    output a, b, c, d, e, f, g
);

reg [3:0]muxout;
wire [1:0]cntout;

always @(posedge clk) begin
    case (cntout)
        0: muxout = in0;
        1: muxout = in1;
        2: muxout = in2;
        3: muxout = in3;
        default: muxout = 0;
    endcase
end

digdec digdec(
 .in(muxout),
 .a(a),
 .b(b),
 .c(c),
 .d(d),
 .e(e),
 .f(f),
 .g(g)
);

dec dec(
 .a(cntout),
 .b(dout)
);

cnt cnt(
    .clk(clk),
    .o(cntout)
);
endmodule
