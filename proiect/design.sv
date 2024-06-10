// Code your design here

`include "Div_An"
`include "Num_An"
`include "DCD_an"
`include "Div_Osc"
`include "Num_US"
`include "Num_ZS"
`include "Num_UM"
`include "Num_ZM"
`include "MUX"
`include "BCD7segm"

module Top_Cronos
(
  input osc_clk,
  input reset,
  output [3:0] an,
  output [7:0] cat
);
  
  
  wire [3:0] tmp_state1;
  wire [3:0] tmp_state2;
  wire [3:0] tmp_state3;
  wire [3:0] tmp_state4;
  
  wire       tmp_enable1;
  wire       tmp_enable2;
  wire       tmp_enable3;
  
  wire [1:0] tmp_out_an;
  
  wire [1:0] tmp_in_DCD_an;
  wire [3:0] tmp_out_DCD_an;
  
  wire [3:0] tmp_I0_MUX;
  wire [3:0] tmp_I1_MUX;
  wire [3:0] tmp_I2_MUX;
  wire [3:0] tmp_I3_MUX;
  wire [1:0] tmp_in_sel;
  wire [3:0] tmp_out_MUX;
  
  wire [3:0] tmp_in_BCD7segm;
  wire [7:0] tmp_out_BCD7segm;
  
  wire tmp_clk_out1;
  wire tmp_clk_out2;
  wire tmp_clk_out3;
  
  wire tmp_clk1;
  wire tmp_clk2;
  wire tmp_clk3;
  wire tmp_clk4;
  
  wire [25:0] clk_1s;
  wire [19:0] clk_16ms;
  wire tmp_clk_an;
  
  
  
  Div_Osc 
  M1 (
    .osc_clk 	( osc_clk ),
    .reset 		( reset   ),
    .counter 	( clk_1s  )
  );
  

  Div_An
  M2 (
    .osc_clk 	( osc_clk ),
    .reset		( reset ),
    .counter 	( clk_16ms )  
  );
  
  
  Num_US
  M3 (
    .reset 		( reset ),
    .clk 		( tmp_clk1 ),
    .clk_out    ( tmp_clk_out1 ),
    .state      ( tmp_state1 )
  );
  
  
  Num_ZS
  M4 (
    .reset 		( reset ),
    .clk 		( tmp_clk2 ),
    .enable		( tmp_enable1 ),
    .clk_out	( tmp_clk_out2 ),
    .state 		( tmp_state2 )
  );
  
    
  Num_UM
  M5 (
    .clk 		( tmp_clk3 ),
    .reset 		( reset ),
    .enable 	( tmp_enable2 ),
    .clk_out 	( tmp_clk_out3 ),
    .state 		( tmp_state3 )
  );
  
  
  Num_ZM
  M6 (
    .clk 		( tmp_clk4 ),
    .reset 		( reset ),
    .enable 	( tmp_enable3 ),
    .state 		( tmp_state4 )
  ); 
  
  
  Num_An
  M7 (
    .clk 		( tmp_clk_an ),
    .reset 		( reset ),
    .out 		( tmp_out_an )
  );
  
  
  DCD_an
  M8 (
    .I 			( tmp_in_DCD_an ),
    .y 			( tmp_out_DCD_an )
  );
  
  
  MUX
  M9 (
    .I0 		( tmp_I0_MUX ),
    .I1 		( tmp_I1_MUX ),
    .I2 		( tmp_I2_MUX ),
    .I3 		( tmp_I3_MUX ),
    .sel 		( tmp_in_sel ),
    .out 		( tmp_out_MUX )
  );
  
  
  BCD7segm
  M10 (
    .bcd 		( tmp_in_BCD7segm ),
    .seg 		( tmp_out_BCD7segm )
  );
  
  
  assign an = tmp_out_DCD_an;
  assign cat = tmp_out_BCD7segm;
  
  assign tmp_I0_MUX = tmp_state1;
  assign tmp_I1_MUX = tmp_state2;
  assign tmp_I2_MUX = tmp_state3;
  assign tmp_I3_MUX = tmp_state4;
  
  assign tmp_in_BCD7segm = tmp_out_MUX;
  
 
  assign tmp_enable1 = tmp_clk_out1;
  assign tmp_enable2 = tmp_clk_out1 & tmp_clk_out2 ;
  assign tmp_enable3 = tmp_clk_out1 & tmp_clk_out2 & tmp_clk_out3;
    
  assign tmp_in_sel = tmp_out_an;
  assign tmp_in_DCD_an = tmp_out_an;
  
  assign tmp_clk1 = clk_1s;
  assign tmp_clk2 = clk_1s;
  assign tmp_clk3 = clk_1s;
  assign tmp_clk4 = clk_1s;
  
  assign tmp_clk_an = clk_16ms;
  
endmodule