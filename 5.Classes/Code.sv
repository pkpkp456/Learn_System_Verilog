class person;
  reg  data1;
  reg  data2;
endclass
module tb;
initial begin
  person o;
  o=new();
  #1
  o.data1=1'b1;
  o.data2=1'b1;
  $display("data=%0d and data2=%0d",o.data1,o.data2);
  o=null; 
end
endmodule