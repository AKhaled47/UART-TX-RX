module UART_TX(tick,clk,rst_n,tx_start,tx_done,d_in,tx_out);
input tick,clk,rst_n,tx_start;
input [7:0] d_in;
output reg tx_done;
output tx_out;

reg [3:0] s_tick_reg,s_tick_next;
reg [2:0] n_bits_reg,n_bits_next;
reg [7:0] bits_reg,bits_next;
reg bit_out_reg,bit_out_next;

parameter [1:0] IDLE =2'b00, START=2'b01,DATA =2'b10, STOP=2'b11;  
reg [1:0] state,next_state;

always @(posedge clk,negedge rst_n) begin
if(!rst_n)
begin
    state<= IDLE;
    s_tick_reg<=0;
    n_bits_reg<=0;
    bits_reg<=0;
    bit_out_reg<=1'b1;
end    
else
begin
    state<= next_state;
    s_tick_reg<=s_tick_next;
    n_bits_reg<=n_bits_next;
    bits_reg<=bits_next;
    bit_out_reg<=bit_out_next;
end

end
assign tx_out=bit_out_reg;

always@(*) begin
next_state=state;
s_tick_next=s_tick_reg;
bits_next=bits_reg;
n_bits_next=n_bits_reg;
bit_out_next=bit_out_reg;
tx_done=1'b0;

case(state)

IDLE:begin
    if(tx_start)
    begin
        next_state=START;
        s_tick_next=0;
        bits_next=d_in;
    end
    else
        next_state=IDLE;
end
START: begin
    bit_out_next=1'b0;
    if(tick)
    begin
        if(s_tick_reg==15)
        begin
            next_state=DATA;
            s_tick_next=0;
            n_bits_next=0;
        end
        else
        s_tick_next=s_tick_reg+1;
    end
end
DATA: begin
    bit_out_next=bits_reg[0];
    if(tick) begin
        if(s_tick_reg==15) begin
            bits_next= bits_reg >> 1;
            s_tick_next=0;
            if(n_bits_reg==7) begin
                next_state=STOP;
                s_tick_next=0;
            end
            else
            n_bits_next=n_bits_reg+1;
        end
        else
        s_tick_next=s_tick_reg+1;
    end
end
STOP: begin
     bit_out_next=1'b1;
     if(tick)
    begin
        if(s_tick_reg==15)
        begin
        next_state=IDLE;
        tx_done=1'b1;
        end
    else
    s_tick_next=s_tick_reg+1;
    end
end

endcase
end
endmodule