module HY_207 (
output wire pin2, //7сегментник
output wire pin3,
output wire pin4,

inout wire pin5, // ПРОСТО ПИН

inout wire pin6, // PS/2
inout wire pin7, 

inout wire pin8, // ПРОСТО ПИН

input wire clk,

output wire pin14, //лампы
output wire pin15,
output wire pin16,
output wire pin17,
output wire pin18,
output wire pin19,
output wire pin20,
output wire pin21,

input wire pin26, //реле Sw(красное)
input wire pin27,
input wire pin28,
input wire pin29,
input wire pin30,
input wire pin33,
input wire pin34,
input wire pin35,

output wire pin36, //пищалка(Buzzer)

inout wire pin37,  // ПРОСТО ПИН

output wire pin38, // обещанный монитор
output wire pin39,
output wire pin40,
output wire pin41,
output wire pin42,
output wire pin43,
output wire pin44,
output wire pin47,
output wire pin48,
output wire pin49,
output wire pin50,

output wire pin51,  //кнопки выхода
output wire pin52,
output wire pin53,

input wire pin54,  //кнопки входа-выхода
input wire pin55,
input wire pin56,
input wire pin57,

output wire pin58,  // RS232
input wire pin61,

input wire pin62, //кнопка S

inout wire pin64,  // ПРОСТО ПИН

output wire pin66, //лампы компаса 
output wire pin67,
output wire pin68,
output wire pin69,

input wire pin70, //лампы компаса входы
input wire pin71,
input wire pin72,

output wire pin73, //LED 8x8
output wire pin74,
output wire pin75,
output wire pin76,
output wire pin77,
output wire pin78,
output wire pin81,
output wire pin82,

output wire pin83, // резюки к LED 8x8
output wire pin84,
output wire pin85,
output wire pin86,
output wire pin87,
output wire pin88,
output wire pin89,
output wire pin90,

output wire pin91, //7сегментник
output wire pin92,
output wire pin95,
output wire pin96,
output wire pin97,
output wire pin98,
output wire pin99,
output wire pin100,
output wire pin1
);

assign pin2 = 1'b1;  //output
assign pin3 = 1'b1;
assign pin3 = 1'b1;
//assign pin14 = 1'b1;
//assign pin15 = 1'b1;
//assign pin16 = 1'b1;
//assign pin17 = 1'b1;
//assign pin18 = 1'b1;
//assign pin19 = 1'b1;
//assign pin20 = 1'b1; 
//assign pin21 = 1'b1; 
//assign pin36 = 1'b1; 
assign pin38 = 1'b1;   
assign pin39 = 1'b1;  
assign pin40 = 1'b1;  
assign pin41 = 1'b1;  
assign pin42 = 1'b1;  
assign pin43 = 1'b1;  
assign pin44 = 1'b1;  
assign pin47 = 1'b1; 
assign pin48 = 1'b1; 
assign pin49 = 1'b1; 
assign pin50 = 1'b1; 
assign pin51 = 1'b1; 
assign pin52 = 1'b1; 
assign pin53 = 1'b1; 
assign pin58 = 1'b1; 
assign pin66 = 1'b0; 
assign pin67 = 1'b0;
assign pin68 = 1'b0;
assign pin69 = 1'b0;
assign pin73 = 1'b1; 
assign pin74 = 1'b1; 
assign pin75 = 1'b1; 
assign pin76 = 1'b1; 
assign pin77 = 1'b1; 
assign pin78 = 1'b1; 
assign pin81 = 1'b1;
assign pin82 = 1'b1;
assign pin83 = 1'b1;
assign pin84 = 1'b1;
assign pin85 = 1'b1;
assign pin86 = 1'b1;
assign pin87 = 1'b1;
assign pin88 = 1'b1;
assign pin89 = 1'b1;
assign pin90 = 1'b1;
assign pin91 = 1'b1;
assign pin92 = 1'b1;
assign pin95 = 1'b1;
assign pin96 = 1'b1;
assign pin97 = 1'b1;
assign pin98 = 1'b1;
assign pin99 = 1'b1;
assign pin100 = 1'b1;
assign pin1 = 1'b1;



assign pin5 = 1'bZ;  //inout
assign pin6 = 1'bZ;
assign pin7 = 1'bZ;
assign pin8 = 1'bZ;
assign pin37 = 1'bZ;
assign pin63 = 1'bZ;


reg [6:0] Nesumma_ligth;   // создание вектора

always @(*) begin
 Nesumma_ligth <= ~ summ_ligth;
end

always @(*) begin
 Nesumma_ligth <= pin14 + pin15 + pin16 + pin17 + pin18 + pin19 + pin20 + pin21;
end


summator
summator_inst
(
 .chislo_clik(chislo_clik),
 .summ_ligth (summ_ligth),
);

endmodule




module schetchik_key (    // Модуль Ключа
    input wire ckik,
    input wire clk,
    output reg clik_push
);

reg [24:0] cnt;
//assign clik = pin62;
wire f_clik_push; 

initial begin

cnt = 'd0;

end

    assign f_clik_push = (cnt >= 25'h0A98AC7) ? (1'b0) : (1'b1);

    always @(posedge clk) begin 
	clik_push <= f_clik_push;
end
    always @(posedge clk) begin 
	if (ckik == 1'b0)  begin
	    if(cnt < {25{1'b1}} )begin
				cnt <= cnt +'d1;
	    end else begin
				cnt <= cnt;
		 end
	end else begin
		cnt <= 'd0;
	end
end 

endmodule

module summator (                   //Модуль сумматора
    input wire chislo_clik,         //колличество нажатий
    output reg [6 : 0] summ_ligth //колличество светящихся ламп
);




schetchik_key
schetchik_key_inst
(
 .ckik(ckik),
 .clk(clk),
 .clik_push(chislo_clik)
);

initial begin
    summ_ligth = 7'b0;
end
    always @(chislo_clik) begin
        if (summ_ligth + 1'b1);
        else begin
            summ_ligth <= summ_ligth;
        end
    end

endmodule


