module UART_top_RX (clk,rst_n,rx,dvsr,rx_done,dout);
input clk,rst_n,rx;
input [10:0] dvsr;
output rx_done;
output [7:0] dout;

wire tick;

baud_gen U1 (clk,rst_n,dvsr,tick);
UART_RX  U2 (rx,tick,clk,rst_n,dout,rx_done);

endmodule