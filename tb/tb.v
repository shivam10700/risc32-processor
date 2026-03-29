module tb;

  reg clk;
  reg reset;

  risc32_pipeline uut (
      .clk(clk),
      .reset(reset)
  );

  always #5 clk = ~clk;

  initial begin
      clk = 0;
      reset = 1;

      #10 reset = 0;

      #200 $finish;
  end

  initial begin
      $dumpfile("dump.vcd");
      $dumpvars(0, tb);
  end

endmodule
