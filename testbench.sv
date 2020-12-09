module clock_tb (output [15:0] cnt_events);
  reg clock;
  reg reset;
  reg[7:0] flags;
  integer i;
  
  initial begin
    flags <= 8'b00000001;
    clock <= 1;
    reset <=0; 
    #5 reset <= 1;
  end
  
  always begin 
    #1 clock = ~clock;
  end
  
  always begin
    for(i=0; i<8; i = i+1) begin
        #1000 flags = 8'b00000001;
        #2000 flags = 8'b00000010;
        #1000 flags = 8'b00000001;
        #4000 flags = 8'b00000100;
        #5 reset <= 0;
        #5 reset <= 1;
    end
    i = 0;
  end
  
  top top_1(.clk(clock), .rst(reset), .flags(flags), .cnt_events(cnt_events));
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, clock_tb);
    #15000
    $finish();
  end
endmodule  