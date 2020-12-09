module timer(input clk, input rst, output reg ms);     
  reg[12:0]cnt_reg; reg[12:0]cnt_nxt;

  always @(posedge clk)
    if(rst == 1'b0)
      cnt_reg <= 0;
    else
      cnt_reg <= cnt_nxt;

  always @(*) begin
    ms = 0;    
    cnt_nxt = cnt_reg + 1;
    //if(cnt_reg == 12'd2500)
    if(cnt_reg == 12'd500)
      begin
        cnt_nxt = 0;
        ms = 1'b1;
      end
  end
endmodule
