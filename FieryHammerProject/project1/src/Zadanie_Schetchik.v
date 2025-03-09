
/*
1) По нажатию кнопки 1 +1бит,кнопки 2 -1бит.(возможно 3я кнопка ресета)
1.1)создать кнопку по 0 с откликом в 1 сек
1.2)создать модуль опроса кнопок(по клоку(011,101,110))
1.3)обьединить
+2) Счетчик
 2.1) Ввести переменные для управления
 2.1.1) Входящий i+ рег+1
 2.1.2) Входящий i- рег-1
 ?2.1.3) добавить рег который булет осекать от счетчика несколько нажатий
 -2.2) Собрать счетчик из кнопок и рега
  2.2.1) задать константу для начала
  2.2.2) Собрать сам счетчик
+3.Бит Счетчик - светодиод L4-L7
 3.1 Написать светодиод по 0 с сохранением состояния. 0=Вкл, 1=Выкл
 3.2 Объединить светодиоды в массив.
 4. Собрать п.3 и п2(через инверсию)
Расширение чтения на 4 кнопкки
*/

// 3.1
module LED_Save
(
	input  wire i_enable_led ,// сюда должен прийти сигнал с счетчика
	output wire o_led
);

reg r_reg;// 0 - вкл, 1 -lamp выкл
initial begin
	r_leg = 1'b1; //чтоб не горела
end

always @(negedge i_enable_led) begin// по спаду смена состояния
	r_led <= ~r_led;
end
assign	o_led = r_led; // присвоение выходу рега

endmodule

//3.2
module Massive_LED 
(
	input  wire [3:0] i_schet_signal ,
	output wire [3:0] o_schet_LEDs   
);
wire [3:0] w_massive_schet_led;

assign o_schet_LEDs [0] = w_massive_schet_led [0]; 
assign o_schet_LEDs [1] = w_massive_schet_led [1]; 
assign o_schet_LEDs [2] = w_massive_schet_led [2]; 
assign o_schet_LEDs [3] = w_massive_schet_led [3];

LED_Save
inst_led_0
(
  .i_enable_led (i_schet_signal[0]),//вход заимствованого(куда подставляется в этом модуле)
  .o_led (w_massive_schet_led[0])   //выход заимствованого(куда подставляется в этом модуле)
);

LED_Save
inst_led_1
(
  .i_enable_led (i_schet_signal[1]),
  .o_led (w_massive_schet_led [1])
);

LED_Save
inst_led_2
(
  .i_enable_led (i_schet_signal[2]),
  .o_led (w_massive_schet_led [2])
);

LED_Save
inst_led_3
(
  .i_enable_led (i_schet_signal[3]),
  .o_led (w_massive_schet_led [3])
);

endmodule


//2 Счетчик
module Schetchik 
(
	input wire i_button1,//+
	input wire i_button2,//-
	input wire i_button3,//reset
	output reg [3:0] Result
);
	initial begin
		 Result = 4'b0000;
	end
	//reg [3:0] promegutok;
	always @(posedge i_button1 or posedge i_button2 or posedge i_button3) begin
		if (i_button1 == 1'b1) begin
			Result <= Result + 4'b0001;
		end
         else if (i_button2 == 1'b1) begin
			Result <= Result - 4'b0001;
		end
         else if (i_button3 == 1'b1) begin
			Result <= 4'b0;
         end
          else begin
			 Result <= Result;
		end   
end

endmodule

//1.1 кнопка с задержкой
module schetchik_key 
(
    input wire i_push,
    input wire clk,
    input wire zero,
    output reg o_clik_push
);

reg [24:0] cnt;
wire  w_clik_push;

initial begin

cnt = 'd0;// счетчик начала зажатия

end

    assign w_clik_push = (cnt >= 25'h0A98AC7) ? (1'b0) : (1'b1);

    always @(posedge clk) begin 
		o_clik_push <= w_clik_push;
    end

    // always @(posedge clk) begin 
	// if (i_push == 1'b0)  begin
	//     if(cnt < {25{1'b1}} )begin
	// 			cnt <= cnt +'d1;
	//     end else begin
	// 			cnt <= cnt;
	// 	 end
	// end else begin
	// 	cnt <= 'd0;
	// end
    // end 

    always @(posedge clk) begin 
        if(zero)begin
            if (i_push == 1'b0)  begin
                if(cnt < {25{1'b1}} )begin
                        cnt <= cnt +'d1;
                end else begin
                        cnt <= cnt;
                 end
            end else begin
                cnt <= 'd0;
            end
        end
        else begin
            cnt <= cnt;
        end
    end 

endmodule

//1.2 Модуль опроса кнопок
module Cyclic_button_senser 
(
    input wire clk,               // Тактовый сигнал
    output reg [2:0] o_sensor     // Выходные сигналы (пины 51-53)
);

    reg [1:0] state;         // Состояние автомата (2 бита для 3 состояний)

     // Определение состояний
    localparam STATE_0 = 2'b00;
    localparam STATE_1 = 2'b01;
    localparam STATE_2 = 2'b10;
   
    always @(posedge clk) begin //тут можно попробовать добавить задержку с #?
            case (state)
                STATE_0: begin
                    o_sensor <= 3'b110;  // Отправляем 0 на первый вход
                    state <= STATE_1;
                end
                STATE_1: begin
                    o_sensor <= 3'b101;  // Отправляем 0 на второй вход
                    state <= STATE_2;
                end
                STATE_2: begin
                    o_sensor <= 3'b011;  // Отправляем 0 на третий вход
                    state <= STATE_0;
                end
            endcase
        end

endmodule



module Management_button //хотим обьединить кнопки
(
input  wire clk,
input wire  [2:0] zero,  //синхронизация кнопок
input  wire [2:0] i_manag_button,//массив входящих от кнопок
output wire [2:0] o_schet_signal_button //сигналы кнопок
);
	
schetchik_key 
key_summa
(
    .i_push (i_manag_button[0]),//вход заимствованого(куда подставляется в этом модуле)
    .clk (clk),
    .zero (zero[0]),
    .o_clik_push (o_schet_signal_button[0])
);

schetchik_key 
key_raznica
(
    .i_push (i_manag_button[1]),
    .clk (clk),
    .zero (zero[1]),
    .o_clik_push (o_schet_signal_button[1])
);

schetchik_key 
key_res
(
    .i_push (i_manag_button[2]),
    .clk (clk),
    .zero (zero[0]),
    .o_clik_push (o_schet_signal_button[2])
);

endmodule

module Management_Schetchik //хотим обьединить кнопки и счетчик
( 
    input  wire       clk,
    input wire  [2:0] zero,
    input  wire [2:0] i_manag_button,//массив входящих от кнопок
	output wire [3:0] o_schet_signal
);

wire [3:0] w_schet_signal_button;

Management_button 
inst_Management_button 
(
   .clk(clk),
   .zero (zero),
   .i_manag_button(i_manag_button),
   .o_schet_signal(w_schet_signal_button) 
);

Schetchik 
inst_Schetchik
(
	.i_button1(w_schet_signal_button[0]),
	.i_button2(w_schet_signal_button[1]),
	.i_button3(w_schet_signal_button[2]),
	.Result(o_schet_signal)
)

endmodule