class thiss;
int data;
function new(input int datain=0);
data=datain;
endfunction
module tb;
thiss hii;
intial begin
hii=new(52);
$display("hii=%d",hii.data);
end
endmodule 

