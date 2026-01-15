/*
Maps the /cppSolutions/day1p2.cpp algorithm as hardware blocks
*/

module Top(
	input clk,
	input reset,
	input signed [31:0] n,
	output reg signed [31:0] c
);
	reg signed [31:0] x;
	wire [31:0] absn;
	wire signed [31:0] n1;
	wire signed [31:0] n2;
	wire dir;
	wire signed [31:0] dirval;
	wire zerox;
	wire signed [31:0] zeroval;
	wire signed [31:0] moveval;
	wire signed [31:0] xnext;
	wire gth;
	wire ltz;
	wire crossed;
	wire signed [31:0] xmod;

	absval a0(n, absn);

	assign n1 = absn / 100;
	assign n2 = absn % 100;
	assign dir = ~n[31];
	assign dirval = dir ? 32'sd1 : -32'sd1;

	iszero z0(x, zerox);

	assign zeroval = dir ? n2 : (32'sd100 - n2);
	assign moveval = x + dirval * n2;

	mux2 m0(moveval, zeroval, zerox, xnext);

	gthundred g0(xnext, gth);
	ltzero l0(xnext, ltz);

	assign crossed = (~zerox) & (gth | ltz);
	assign xmod = (xnext % 100 + 100) % 100;

	always @(posedge clk) begin
		if (reset) begin
			x <= 32'sd50;
			c <= 32'sd0;
		end else begin
			x <= xmod;
			c <= c + n1 + crossed + (xmod == 0);
		end
	end
endmodule


module mux2(
	input [31:0] a,
	input [31:0] b,
	input sel,
	output [31:0] y
);
	assign y = sel ? b : a;
endmodule


module absval(
	input signed [31:0] a,
	output [31:0] y
);
	assign y = a[31] ? -a : a;
endmodule


module iszero(
	input signed [31:0] a,
	output z
);
	assign z = (a == 0);
endmodule


module gthundred(
	input signed [31:0] a,
	output y
);
	assign y = (a > 100);
endmodule


module ltzero(
	input signed [31:0] a,
	output y
);
	assign y = (a < 0);
endmodule

