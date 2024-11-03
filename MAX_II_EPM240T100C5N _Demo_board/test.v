a/* 
есть некоторый провод "A"
есть некоторый провод "B"

хотим получить следующие результаты:
C = A + B
D = A - B
E = Если A > B то 1, иначе 0
*/

module test_0 
(
    input wire       A        ,
    input wire [3:0] A_vector ,
    input wire       B        ,
    input wire [4:0] B_vector ,

    output wire C ,
    output wire D ,
    output wire E ,
    output wire [5:0] E_vector,
    output wire [5:0] F_vector
);

assign C = A + B ;
assign D = A - B ;
assign E        = (A > B) ? (A_vector) : (B_vector) ; 
assign E_vector = (A > B) ? (A_vector) : (B_vector) ; 
assign F_vector = A_vector + B_vector ; 

endmodule

























module test_1 
(
    input wire [6:0] H,
    output wire J,
);

wire 

test_0 hotet_inst  
(
    .A        (5'd6) ,
    .A_vector (5'd6) ,
    .B        (5'd6) ,
    .B_vector (H   ) ,

    .C        (J) ,
    .D        () ,
    .E        () ,
    .E_vector () ,
    .F_vector () 
);


endmodule






