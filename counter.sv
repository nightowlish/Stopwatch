module counter (input clk, input rst, input active_event, input [7:0] flags, 
                output reg [15:0]cnt_events);
  reg[15:0]cnt_reg; reg[15:0]cnt_nxt;
  
  reg START = 0;
  reg STOP  = 0;
  reg PAUSE = 0;
  reg START_NXT = 0;
  reg STOP_NXT = 0;
  reg PAUSE_NXT = 0;
  
  always @(posedge clk) begin
    if(rst == 1'b0) begin
      cnt_reg <= 0;
      START <= 0;
      STOP <= 0;
      PAUSE <= 0;
      START_NXT <= 0;
      STOP_NXT <= 0;
      PAUSE_NXT <= 0;
    end
    else
      cnt_reg <= cnt_nxt;    
      STOP <= STOP_NXT;
      START <= START_NXT;
      PAUSE <= PAUSE_NXT;
  end

  always @(*) begin
    if (flags == 8'b00000001) begin
      START <= 1;
      STOP <= 0;
      PAUSE <= 0;
    end
    else if (flags == 8'b00000010) begin
      PAUSE <= 1;
      STOP <= 0;
      START <= 0;
    end
    else if (flags == 8'b00000100) begin
      STOP <= 1;
      PAUSE <= 0;
      START <= 0;
    end  
    cnt_nxt = cnt_reg;
    START_NXT = START;
    STOP_NXT = STOP;
    PAUSE_NXT = PAUSE;
    if (active_event == 1'b1 && START == 1'b1)
      cnt_nxt = cnt_reg + 1; 
    else if (PAUSE == 1'b1)
      cnt_nxt = cnt_reg;
    else if (STOP == 1'b1)
      cnt_nxt = 0;
    cnt_events = cnt_reg;
  end
endmodule
