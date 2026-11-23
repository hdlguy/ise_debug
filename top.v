`timescale 1ns / 1ps

module top(
    input 			clkin100,
    output 			led
);

	wire clkin100;
	reg [7:0] led;
	
	wire clk;
	assign clk = clkin100;
	
	reg [31:0] count=0;
	reg[7:0] a, b, c, d;
	wire reset;
	always @(posedge clk) begin
		if (reset) begin
			count <= 0;
		end else begin
			count <= count + 1;
		end
		led <= count[31:24];
		a <= count[7:0];
		b <= count[15:8];
		c <= count[23:16];
		d <= count[31:24];
	end
	
	wire[35:0] control0, control1;
	icon_core icon_inst (.CONTROL0(control0), .CONTROL1(control1));
	ila_core ila_inst (.CONTROL(control0), .CLK(clk), .DATA({a, b, c, d}), .TRIG0(a));
	vio_core vio_inst (.CONTROL(control1), .CLK(clk), .SYNC_OUT(reset));

endmodule
