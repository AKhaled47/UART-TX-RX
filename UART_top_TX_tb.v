module UART_top_TX_tb;
reg clk,rst_n,tx_start;
reg [10:0] dvsr;
reg [7:0] d_in;
wire tx_done;
wire tx_out;

UART_top_TX U1 (clk,rst_n,tx_start,dvsr,d_in,tx_done,tx_out);

initial begin
clk=1'b0;
forever #2 clk=~clk;
end

initial begin
rst_n=1'b0;
tx_start=1'b0;
d_in=8'b10101010;
dvsr=11'd2;
#10 rst_n=1'b1;
tx_start=1'b1;
$monitor("Time is %3d , tx_out is %b , tx_done is %b",$time,tx_out,tx_done);



end
endmodule