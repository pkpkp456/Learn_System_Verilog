// Code your testbench here
// or browse Examples
module tb;

  bit [3:0] a, b, y;

  // Dumping for waveform analysis
  initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, tb);
  end
  //Pass By Value 
  task add(input a,input b,output y);
    y = a + b;
    $display("Time: %0t | A = %0d, B = %0d, Y = %0d", $time, a, b, y);
  endtask
  initial begin 
    add(3,4,y);
    $display("value of a=%0d and b=%0d",a,b);
  end
endmodule
  