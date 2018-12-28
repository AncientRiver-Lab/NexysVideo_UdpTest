// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.1 (lin64) Build 2188600 Wed Apr  4 18:39:19 MDT 2018
// Date        : Mon Dec 24 20:39:50 2018
// Host        : Z10PE-01 running 64-bit Ubuntu 16.04.5 LTS
// Command     : write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ ETH_CLKGEN_stub.v
// Design      : ETH_CLKGEN
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a200tsbg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix(eth_rxck_45deg, eth_rxck_90deg, 
  eth_rxck_180deg, eth_rxck_270deg, reset, locked, eth_rxck)
/* synthesis syn_black_box black_box_pad_pin="eth_rxck_45deg,eth_rxck_90deg,eth_rxck_180deg,eth_rxck_270deg,reset,locked,eth_rxck" */;
  output eth_rxck_45deg;
  output eth_rxck_90deg;
  output eth_rxck_180deg;
  output eth_rxck_270deg;
  input reset;
  output locked;
  input eth_rxck;
endmodule
