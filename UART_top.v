module UART_top(
input clk,rst_n,tx_start,
input [10:0] dvsr,
input [7:0] d_in,
output rx_done,
output [7:0] dout
);


wire tx_done,tx_out;

UART_top_TX u1 (clk,rst_n,tx_start,dvsr,d_in,tx_done,tx_out);

UART_top_RX U2 (clk,rst_n,tx_out,dvsr,rx_done,dout);

endmodule