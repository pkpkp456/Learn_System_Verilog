// Code your testbench here
// or browse Examples
// Code your testbench here
// or browse Examples
module tb;
  bit[3:0] a,b;
  bit[5:0] y;
  
  task add();
    y=a+b;
    $display("Value Of A=%0d And B=%0d So Y=%0d",a,b,y);
  endtask
  task add_test();
    a=2;
    b=3;
    add();
    #4;
    a=4;
    b=5;
    add();
    #12;
    a=12;
    b=2;
    add();
        #12;
    a=12;
    b=1;
    add();
        #12;
    a=52;
    b=21;
    add();
    
  endtask
    initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, tb);
  end
  initial begin
    add_test();
  end
endmodule
  
  
  

    