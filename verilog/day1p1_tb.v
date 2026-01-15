module top_tb;

    reg clk;
    reg rst;
    reg valid;
    reg dir;
    reg signed [31:0] n;
    wire [31:0] zeroCount;
    wire signed [31:0] xOut;

    top DUT(
        .clk(clk),
        .rst(rst),
        .valid(valid),
        .dir(dir),
        .n(n),
        .zeroCount(zeroCount),
        .xOut(xOut)
    );

    always begin
        #5 clk = ~clk;
    end

    // send task: pretty useful :p
    task send;
        input signed [31:0] n_val;
        begin
            valid = 1;
            n = n_val;
            #10 valid = 0;
        end
    endtask

    initial begin
        clk = 0;
        rst = 0;
        valid = 0;
        dir = 1;
        n = 32'd0;

        #10 rst = 1;
        #10 rst = 0;

        // test ip, paste the /scripts/tb.txt here or your custom inputs
        send(-68);
        send(-30);
        send(48);
        send(-5);
        send(60);
        send(-55);
        send(-1);
        send(-99);
        send(14);
        send(-82);

        #30;
        $display("x = %d, count = %d", xOut, zeroCount);
        $finish;
    end
endmodule