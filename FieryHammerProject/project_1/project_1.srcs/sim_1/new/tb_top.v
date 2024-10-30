`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.07.2024 20:21:19
// Design Name: 
// Module Name: tb_top
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


module tb_top();
    
reg clock;
reg clock_1;
wire clock_n;
wire clock_nn;

initial begin
    clock = 1'b0;
    clock_1 = 1'b0;
end

always begin
    #10 clock = ~clock;
end

always begin
    #5 clock_1 = ~clock_1;
end

a_invertor
a_invertor_inst  
(
    .in_D (clock) ,
    .out_Q (clock_n) 
);

s_invertor
s_invertor_inst  
(
    .in_D  (clock_n ),
    .out_Q (clock_nn),
    .clk   (clock_1 )
);
    
    

endmodule



