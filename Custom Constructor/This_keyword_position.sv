//Basic Code For This Keyword In Functions  By Position
class thiss;
int data1;
bit[7:0] data2;
shortint data3;
function new(input int data1=0,input bit[7:0] data2=8'h00,input shortint data3=0);
this.data1=data1;
this.data2=data2;
this.data3=data3;
endfunction 
module tb;
thiss first;
initial begin 
first=new(25,54,56);
$display("Data1=%0d,Data2=%0d,Data3=%0d",first.data1,first.data2,first.data3);
end
endmodule


