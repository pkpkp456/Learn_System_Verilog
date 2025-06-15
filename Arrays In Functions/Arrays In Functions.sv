// Code your testbench here
// or browse Examples
module tb;
  bit[3:0] array[16];
  function automatic void array_in(ref bit[3:0] a[16]);
    for(int i=0;i<=15;i++) begin
      a[i]=i;
    end
  endfunction
    initial begin
    $dumpfile("waveform.vcd");    // Output VCD file
    $dumpvars(0, tb);
  end
  initial begin
    int i;
    array_in(array);
    for(i=0;i<=15;i++) begin
    $display("array[%0d]=%0d",i,array[i]);
    end
  end

endmodule