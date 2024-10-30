`timescale 1ns / 1ns

module a_invertor 
(
    input  wire in_D  ,
    output wire out_Q 
);
    
assign out_Q = ~in_D;
// assign out_Q = !in_D;
// assign out_Q = (in_D == 1'b1) ? (1'b0) : (1'b1);

endmodule

module s_invertor 
(
    input  wire in_D  ,
    output reg  out_Q ,
    input  wire clk
);
    
always @(posedge clk) begin
     out_Q <= ~in_D;
    // out_Q <= !in_D;

    // if(in_D == 1'b1)begin
    //     out_Q <= 1'b0;
    // end
    // else begin
    //     out_Q <= 1'b1;
    // end

    // if(in_D)begin
    //     out_Q <= 1'b0;
    // end
    // else begin
    //     out_Q <= 1'b1;
    // end
end

endmodule


module rs_trig 
(
    input  wire R   ,
    input  wire S   ,
    output reg  Q   ,
    output wire Q_n ,
    input  wire clk
);

assign Q_n = ~Q;

always @(posedge clk) begin
    if(R == 1'b1) begin
        Q <= 1'b0;
    end
    else if(S == 1'b1)begin
        Q <= 1'b1;
    end
    else begin
        Q <= Q;
    end
end


endmodule