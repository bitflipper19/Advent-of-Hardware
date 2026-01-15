module top_tb;

	reg clk;
	reg reset;
	reg signed [31:0] n;
	wire signed [31:0] c;

	Top DUT(
		.clk(clk),
		.reset(reset),
		.n(n),
		.c(c)
	);

	initial begin
		clk = 0;
		forever #5 clk = ~clk;
	end

	task send;
		input dir;                
		input [31:0] val;
		begin
			if (dir)
				n = val;          
			else
				n = -val;         
			@(posedge clk);
		end
	endtask

	initial begin
		n = 0;
		reset = 1;

		@(posedge clk);
		@(posedge clk);
		reset = 0;

		send(0, 68);
		send(0, 30);
		send(1, 48);
		send(0, 5);
		send(1, 60);
		send(0, 55);
		send(0, 1);
		send(0, 99);
		send(1, 14);
		send(0, 82);

		@(posedge clk);

		$display("x = %0d, count = %0d", dut.x, c);

		$finish;
	end

endmodule