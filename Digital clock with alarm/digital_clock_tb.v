module digital_clock_tb;
  
  reg clk, reset;
  wire [6:0] seg_out;
  wire [3:0] anode_out;
  
  Digital_clock dut (
    .clk(clk),
    .reset(reset),
    .seg_out(seg_out),
    .anode_out(anode_out)
  );
  
  initial begin
    clk = 0;
    reset = 1;
    #10 reset = 0;
  end
  
  always #5 clk = ~clk;
  
endmodule
