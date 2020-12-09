
module top(input clk, input rst, input [7:0] flags, output [15:0] cnt_events);
  reg ms;
  timer t(.clk(clk), .rst(rst), .ms(ms));
  counter c(.clk(clk), .rst(rst), .active_event(ms), .flags(flags), 
            .cnt_events(cnt_events));
endmodule