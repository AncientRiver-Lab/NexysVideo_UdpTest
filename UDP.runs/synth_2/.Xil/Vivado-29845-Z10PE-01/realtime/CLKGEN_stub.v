// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module CLKGEN(clk125, clk100, clk10, clk125_90, reset, locked, 
  SYSCLK);
  output clk125;
  output clk100;
  output clk10;
  output clk125_90;
  input reset;
  output locked;
  input SYSCLK;
endmodule
