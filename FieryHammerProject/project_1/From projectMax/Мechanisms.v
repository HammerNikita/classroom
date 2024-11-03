module KEYY(          //модуль ключа+счетчик
input wire KEY1,
input wire FPGA_clk,
output reg flag_light
);

reg [24:0] cnt;
wire f_flag_light;

initial begin

cnt = 'd0;

end

assign f_flag_light = (cnt >= 25'h0A98AC7) ? (1'b1) : (1'b0);

always @(posedge FPGA_clk) begin 
	flag_light <= f_flag_light;
end

//always @(posedge FPGA_clk) begin 
//	if(cnt >= 28'h00005F5E100)begin
//		flag_light <= 1'b1;
//	end
//	else begin
//		flag_light <= 1'b0;
//	end
//end

always @(posedge FPGA_clk) begin : COUNTER_inst
	if (KEY1 == 1'b0)  begin
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

module LEDXY(             //модуль лампочки
input wire pwr,
output wire LED1
);

reg L0;
initial begin
 L0 = 1'b1;
end

assign LED1 = L0;//r_led

always@(posedge pwr)begin
	L0 <= ~L0;
end

endmodule

