// Code your testbench here
// or browse Examples
module tb;
 
  //////pass by value
  
  task swap ( input bit [1:0] a, [1:0] b); 
    bit [1:0] temp;
    temp = a;
    a = b;
    b = temp;   
    $display("Value of a : %0d and b : %0d", a,b);
  endtask
  