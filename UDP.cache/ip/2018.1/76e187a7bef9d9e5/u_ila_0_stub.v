// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.1 (lin64) Build 2188600 Wed Apr  4 18:39:19 MDT 2018
// Date        : Fri Dec 21 15:01:01 2018
// Host        : Z10PE-01 running 64-bit Ubuntu 16.04.5 LTS
// Command     : write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ u_ila_0_stub.v
// Design      : u_ila_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a200tsbg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "ila,Vivado 2018.1" *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix(clk, probe0, probe1, probe2, probe3, probe4, probe5, 
  probe6, probe7, probe8, probe9, probe10, probe11, probe12, probe13, probe14, probe15, probe16, probe17, 
  probe18, probe19, probe20)
/* synthesis syn_black_box black_box_pad_pin="clk,probe0[1:0],probe1[31:0],probe2[31:0],probe3[2:0],probe4[2:0],probe5[2:0],probe6[31:0],probe7[47:0],probe8[2:0],probe9[31:0],probe10[8:0],probe11[8:0],probe12[8:0],probe13[7:0],probe14[8:0],probe15[0:0],probe16[0:0],probe17[0:0],probe18[0:0],probe19[0:0],probe20[0:0]" */;
  input clk;
  input [1:0]probe0;
  input [31:0]probe1;
  input [31:0]probe2;
  input [2:0]probe3;
  input [2:0]probe4;
  input [2:0]probe5;
  input [31:0]probe6;
  input [47:0]probe7;
  input [2:0]probe8;
  input [31:0]probe9;
  input [8:0]probe10;
  input [8:0]probe11;
  input [8:0]probe12;
  input [7:0]probe13;
  input [8:0]probe14;
  input [0:0]probe15;
  input [0:0]probe16;
  input [0:0]probe17;
  input [0:0]probe18;
  input [0:0]probe19;
  input [0:0]probe20;
endmodule