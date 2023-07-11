module baudtb;
reg clk,rst_n;
reg [10:0] dvsr;
wire tick;

baud_gen U1 (clk,rst_n,dvsr,tick);



initial begin
    clk=1'b0;
    forever 
    #5 clk=~clk;
end
initial begin
    $monitor("time is %3d and tick is %b",$time,tick);
    rst_n=1'b1;
    #10 dvsr=10'd10;
    #10 rst_n=1'b0;
    #10 rst_n=1'b1;

end
endmodule