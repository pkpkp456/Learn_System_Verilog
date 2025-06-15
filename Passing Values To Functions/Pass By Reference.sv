module tb;

  bit [3:0] a, b;

  // VCD Dumping
  initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, tb);
  end

  // Automatic task with ref arguments
  task automatic add(ref int a, ref int b);
    a = a + 5;
    b = b + 5;
  endtask

  initial begin 
    int x = 3;
    int y = 4;
    add(x, y);
    $display("value of x = %0d and y = %0d", x, y);
  end

endmodule
