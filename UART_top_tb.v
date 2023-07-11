module UART_top_tb;
reg clk,rst_n,tx_start;
reg [10:0] dvsr;
reg [7:0] d_in;
wire rx_done;
wire [7:0] dout;

UART_top u1 (clk,rst_n,tx_start,dvsr,d_in,rx_done,dout);

initial begin
    $monitor("Time is %3d , DATA OUT is %h , RX_DONE is %b",$time,dout,rx_done);
    clk=1'b0; rst_n=1'b0; dvsr=11'd0; d_in=8'h5a; tx_start=1'b1;
    #11 rst_n=1'b1;
    #10 tx_start=1'b0;
end
always #2 clk=~clk;

endmodule