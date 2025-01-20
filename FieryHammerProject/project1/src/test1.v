/*
Зажечь светодиоды L0-L3 с помощью кнопок K1,K4, K7, K10. 
1) управление светодиодами
1.1) Управление одним светодиодом.Зажигать светодиод Через reg.Придумать какие то управляюшие входы(flag)и реакцию зажигания.
1.2) РАСШИРИТЬ УПРАВЛЕНИЕ НА 4 СВЕТОДИОДА
2) Чтение кнопок
2.1) Чтение одной кнопки.
2.2) Расширение чтения на 4 кнопкки
*/

// 2.1
module button_ctrl
(
	input  wire i_button_n ,
	output wire o_flag_down,
	output wire o_flag_up   
);


assign o_flag_down = (i_button_n == 1'b0) ? (1'b1) : (1'b0);
assign o_flag_up   = (i_button_n == 1'b1) ? (1'b1) : (1'b0);

endmodule

module four_button_ctrl
(
	input  wire [3:0] i_btn,
	output wire [3:0] o_flag_btn_down,
	output wire [3:0] o_flag_btn_up 
);

wire w_btn_0;//1й способ
wire w_btn_1;
wire w_btn_2;
wire w_btn_3;

assign w_btn_0 = i_btn[0];
assign w_btn_1 = i_btn[1];
assign w_btn_2 = i_btn[2];
assign w_btn_3 = i_btn[3];

wire [3:0] w_flag_down;//2й способ
assign o_flag_btn_down [0] = w_flag_down [0]; 
assign o_flag_btn_down [1] = w_flag_down [1]; 
assign o_flag_btn_down [2] = w_flag_down [2]; 
assign o_flag_btn_down [3] = w_flag_down [3];


wire [3:0] w_flag_btn_up;//3й способ
assign o_flag_btn_up[3:0] = w_flag_btn_up[3:0];

button_ctrl//заимстованный модуль
inst0      //частное название 
(
	.i_button_n  (w_btn_0),
	.o_flag_down (w_flag_down [0]),
	.o_flag_up   (w_flag_btn_up[0])
);

button_ctrl
inst1
(
	.i_button_n  (w_btn_1),
	.o_flag_down (w_flag_down [1]),
	.o_flag_up   (w_flag_btn_up[1])
);

button_ctrl
inst2
(
	.i_button_n  (w_btn_2),
	.o_flag_down (w_flag_down [2]),
	.o_flag_up   (w_flag_btn_up[2])
);

button_ctrl
ins3
(
	.i_button_n  (w_btn_3),
	.o_flag_down (w_flag_down [3]),
	.o_flag_up   (w_flag_btn_up[3])
);

endmodule

module Singl_LED //1.1).Зажигать светодиод Через reg.Придумать какие то управляюшие входы(flag)и реакцию зажигания.
(
input  wire v,
output wire o_sLED
);
reg r_flag_led;//первичный
reg r_flag_led_d;//вторичный
initial begin
o_sLED = 1'b1;	//чтоб лампа не горела
end
	always @(i_sLED) begin
		if (i_sLED == 1'b0) begin //по идее будет гореть
			 flag_led = i_sLED;
		end else (i_sLED == 1'b1) and flag_led = 1'b1 begin //          будет сохранять горение
			flag_led = flag_led_d;// и 
	end
	end
	always @(i_sLED) begin// по нажатию переключать состояния
		if (flag_led == ~flag_led_d) begin
			flag_led_d <= ~flag_led_d;
		end else (flag_led == flag_led_d) begin
			flag_led_d <= flag_led_d;
		end
		
	end
endmodule

module four_LED 
(
input  wire [3:0] i_massive_led,
output wire [3:0] o_massive_led
);
// wire w_led_0;
// wire w_led_1;
// wire w_led_2;
// wire w_led_3;

// assign w_led_0 = i_massive_led[0];
// assign w_led_1 = i_massive_led[1];
// assign w_led_2 = i_massive_led[2];
// assign w_led_3 = i_massive_led[3];


wire [3:0] w_massive_led;
assign o_massive_led [0] = w_led_0 [0]; 
assign o_massive_led [1] = w_led_1 [1]; 
assign o_massive_led [2] = w_led_2 [2]; 
assign o_massive_led [3] = w_led_3 [3];

Singl_LED
inst_led_0
(
  .i_sLED (w_led_0),
  .o_sLED (w_massive_led[0])
);
Singl_LED
inst_led_0
(
  .i_sLED (w_led_1),
  .o_sLED (o_massive_led [1])
);
Singl_LED
inst_led_0
(
  .i_sLED (w_led_2),
  .o_sLED (o_massive_led [2])
);
Singl_LED
inst_led_0
(
  .i_sLED (w_led_3),
  .o_sLED (o_massive_led [3])
);

endmodule