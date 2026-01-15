`timescale 1ns/1ps

/*
Maps the /cppSolutions/day1p1.cpp algorithm as hardware blocks
*/

module top(
    /*
    Top module, for modularity and RTL analysis on Vivado
    It instantiates all the other required modules.
    */
	input clk,
	input rst,
	input valid,
	input dir,
	input signed [31:0] n,
	output [31:0] zeroCount,
	output signed [31:0] xOut
);

	reg signed [31:0] xReg;
	wire signed [31:0] xNext;

	always @(posedge clk or posedge rst)begin
		if(rst) xReg<=32'sd50;
		else if(valid) xReg<=xNext;
	end

	assign xOut=xReg;

	wire signed[31:0] signedN;
	assign signedN=dir? n: -n;

	wire signed [31:0] addOut;
	wire signed [31:0] modOut;
	wire signed [31:0] normOut;
	wire zeroHit;

	adder uAdd(.a(xReg), .b(signedN), .sum(addOut));
	modulo uMod(.in(addOut), .out(modOut));
	normalize uNorm(.in(modOut), .out(normOut));
	comparator uCmp(.in(normOut), .zero(zeroHit));

	assign xNext=normOut;

	counter uCnt(
		.clk(clk),
		.rst(rst),
		.inc(valid&zeroHit),
		.count(zeroCount)
	);
endmodule

module adder(
    // Adds two 32-bit numbers
	input signed [31:0] a,
	input signed [31:0] b,
	output signed [31:0] sum
);
	assign sum=a+b;
endmodule

module modulo(
    /* 
    -> calculates the remainder of a number n when divided by 100
    -> yeah ik this can be optimized (by a lot)
    */
    
	input signed [31:0] in,
	output signed [31:0] out
);
	assign out=in%100;
endmodule

module normalize(
    /*
    If the result is negative, it needs to be within the range 0-99
    */
	input signed [31:0] in,
	output signed [31:0] out
);
	assign out=(in<0)? (in+100): in;
endmodule

module comparator(
    // compares with 0, if it's 0, generates a signal for the 
	// final count register
	input signed [31:0] in,
	output zero
);
	assign zero = (in==0);
endmodule

module counter(
	/*
	Keeps the track of the final count
	*/
	input clk,
	input rst,
	input inc,
	output reg [31:0] count
);
	always @(posedge clk or posedge rst)begin
		if(rst) count<=32'd0;
		else if(inc) count<=count+1;
	end
endmodule