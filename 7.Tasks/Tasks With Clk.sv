// Code your testbench here
// or browse Examples
module tb;
  bit clk = 0;
  bit [3:0] a, b, y;

  // Clock generation
  always #5 clk = ~clk;

  // Dumping for waveform analysis
  initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, tb);
  end

  // Task to perform addition
  task add();
    y = a + b;
    $display("Time: %0t | A = %0d, B = %0d, Y = %0d", $time, a, b, y);
  endtask

  // Task to generate test inputs and call add()
  task add_test();
    @(posedge clk);
    a = $urandom_range(0, 15); // restrict to 4-bit
    b = $urandom_range(0, 15);
    add();
  endtask

  // Stimulus process
  initial begin
    repeat (10) begin
      add_test();
    end
    $finish();
  end
endmodule

