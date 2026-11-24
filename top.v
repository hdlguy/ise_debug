//
module top(
    input	wire		clkin100,
    output 	reg[7:0]	led
);
	
	wire clk;
	assign clk = clkin100;
	
	reg [255:0] count=0, count_q=0;
	wire reset;
	reg reset_q=0;
	always @(posedge clk) begin
		reset_q <= reset;
		if (reset_q) begin
			count <= 0;
		end else begin
			count <= count + 1;
		end
		count_q <= count;
		led <= count[31:24];
	end
	
	// debug
	wire[35:0] control0, control1, control2;
	icon_core icon_inst (.CONTROL0(control0), .CONTROL1(control1), .CONTROL2(control2));
	ila_core  ila_inst0 (.CONTROL(control0), .CLK(clk), .DATA(count_q), .TRIG0(reset_q));
	ila_core  ila_inst1 (.CONTROL(control1), .CLK(clk), .DATA(count_q), .TRIG0(reset_q));
	vio_core  vio_inst  (.CONTROL(control2), .CLK(clk), .SYNC_OUT(reset));

endmodule
