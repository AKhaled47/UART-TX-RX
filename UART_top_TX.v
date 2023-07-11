module UART_top_TX (clk,rst_n,tx_start,dvsr,d_in,tx_done,tx_out);
input clk,rst_n,tx_start;
input [10:0] dvsr;
input [7:0] d_in;
output tx_done;
output tx_out;

wire tick;

baud_gen U1 (clk,rst_n,dvsr,tick);
UART_TX  U2 (tick,clk,rst_n,tx_start,tx_done,d_in,tx_out);

endmodule