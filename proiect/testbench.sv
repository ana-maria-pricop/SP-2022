// Code your testbench here
// or browse Examples


module TestBench_cronometru;
  reg osc_clk_t;
  reg reset_t;
  wire [3:0] an_t;
  wire [7:0] cat_t;
  
  Top_Cronos DUT(
    .osc_clk	( osc_clk_t ),
    .reset		( reset_t ),
    .an 		( an_t ),
    .cat 		( cat_t )
  );
  
  initial begin
      #0 osc_clk_t = 1'b0;
    forever #5 osc_clk_t = ~osc_clk_t;  end
    
  
  initial begin
    #0 reset_t = 1'b1;
    #20 reset_t = 1'b0; 
    #200 $finish();  end
  
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars();  end
 
endmodule