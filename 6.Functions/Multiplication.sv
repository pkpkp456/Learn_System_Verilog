// Code your testbench here
// or browse Examples
// Code your testbench here
// or browse Examplesmo
module tb;
  function bit[11:0] add(input bit [4:0] a,b);
    return a*b;
    endfunction
  bit [11:0] hiii;
    initial begin
      
      hiii =add(5'b00010,5'b00110);
      if(hiii==12)
        
      $display("Values is =%0d",hiii);
      else
        $display("Values not is =%0d",hiii);
    end
    endmodule