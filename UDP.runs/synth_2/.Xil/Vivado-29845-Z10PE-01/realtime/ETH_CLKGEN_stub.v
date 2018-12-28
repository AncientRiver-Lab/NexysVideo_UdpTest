// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module ETH_CLKGEN(rxck_0deg, rxck_90deg, rxck_180deg, 
  rxck_270deg, rxck_n90deg, resetn, locked, eth_rxck);
  output rxck_0deg;
  output rxck_90deg;
  output rxck_180deg;
  output rxck_270deg;
  output rxck_n90deg;
  input resetn;
  output locked;
  input eth_rxck;
endmodule
