module UART_RX(rx,tick,clk,rst,dout,rx_done);
input rx,tick,rst,clk;
output reg rx_done;
output [7:0] dout;

reg [3:0] s_next,s_reg;
reg [2:0] n_bits_next,n_bits_reg;
reg [7:0] bits_next,bits_reg;

parameter [1:0] IDLE =2'b00, START = 2'b01, DATA =2'b10, STOP = 2'b11;
reg [1:0] state,next_state;

always @(*) begin
    s_next=s_reg;
    bits_next=bits_reg;
    n_bits_next=n_bits_reg;
    next_state=state;
    rx_done=1'b0;
case(state)

IDLE: 
    if(rx==1'b0) begin
    next_state=START;
    s_next=0;
    end

START:
    if(tick)
    begin
        if(s_reg==7) begin
        s_next=0;
        n_bits_next=0;
        next_state=DATA;
        end
    else
    s_next=s_reg+1;
    end

DATA:
if(tick) begin
    if(s_reg==15)
        begin
            s_next=0;
            bits_next={rx,bits_reg[7:1]};
            if(n_bits_reg==7)
            begin
                s_next=0;
                next_state=STOP;
            end
            else
            n_bits_next=n_bits_reg+1;
        end
    else
        s_next=s_reg+1;
        end
STOP:
   if(tick)
    begin
        if(s_reg==7)
        begin
        next_state=IDLE;
        rx_done=1'b1;
        end
    else
    s_next=s_reg+1;
    end
endcase

end

always@(posedge clk , negedge rst) begin
if(rst==1'b0)
begin
    s_reg<=0;
    n_bits_reg<=0;
    state<=IDLE;
    bits_reg<=0;
end
else
begin
    s_reg<=s_next;
    n_bits_reg<=n_bits_next;
    state<=next_state;
    bits_reg<=bits_next;
end


end
assign dout = bits_reg;
endmodule