module baud_gen(clk,rst_n,dvsr,tick);
input clk,rst_n;
input [10:0] dvsr;
output tick;

wire [10:0] reg_d;
reg [10:0] reg_q;

always @(posedge clk,negedge rst_n) begin
    if(!rst_n)
    reg_q<={10{1'b0}};
    else
    reg_q<=reg_d;
end

assign reg_d = (reg_q==dvsr)? 0:reg_q+1;
assign tick =(reg_q==dvsr);
endmodule