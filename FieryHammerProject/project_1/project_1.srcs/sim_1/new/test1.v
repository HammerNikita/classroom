`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.09.2024 21:22:27
// Design Name: 
// Module Name: test1
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


module test1();
reg clk;

wire A;
reg  B;
wire [7:0]C;
reg  [7:0]D;

initial begin
    B = 8'd1;
    D = 8'd2;
    clk= 1'b1;
end

always begin
    #2 D = D+8'd1;
    #8 D = D-8'd3;
end

//initial begin
//    #2 clk = ~clk;
//    #2 clk = ~clk;
//    #2 clk = ~clk;
//    #2 clk = ~clk;
//end


always begin
    #2 clk = ~clk;
end


DZjj   
#(
    .X (7)
)
sdkjfskdjfh
(
   .A        (D    )  ,
   .B        (8'd5)  ,
   .C        (8'd8)  ,
   .E        (8'd20) ,
   .D        (2'd1)      , 
   .Summ     (    )// размерность 10 мы определили найдя на калькуляторе максимальное значение выражения
);


endmodule
