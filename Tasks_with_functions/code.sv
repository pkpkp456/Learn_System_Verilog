class thiss;
  bit [7:0] a, b, c;

 
  function void set_values(input bit [7:0] a, b, c);
    this.a = a;
    this.b = b;
    this.c = c;
  endfunction


  task display();
    $display("a = %0d, b = %0d, c = %0d", a, b, c);
  endtask
endclass

module tb;
  thiss obj;
  initial begin
    obj = new();
    obj.set_values(2, 4, 56);
    obj.display();
    obj.set_values(.a(10), .b(20), .c(30));
    obj.display();
  end
endmodule
