//Example Code
class thiss;
bit[7:0] a;
bit[7:0] b;
bit[7:0] c;
function task(input bit[7:0]a,b,c);
this.a=a;
this.b=b;
this.c=c;
endfunction
module tb;
thiss hii;
initial begin
hii=task(2,4,56);
hii=task(.a(2),.c(56),.b(4));
$display("a=%0d,b=%0d,c=%0d",first.a,first.b,first.c);
end
endmodule

