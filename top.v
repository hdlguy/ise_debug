`timescale 1ns / 1ps

module top(
    input 			clkin100,
    output 			led
);

	wire clkin100;
	reg [7:0] led;
	
	wire clk;
	assign clk = clkin100;
	
	reg [31:0] count;
	always @(posedge clk) begin
		count <= count + 1;
		led <= count[31:24];
	end

endmodule
