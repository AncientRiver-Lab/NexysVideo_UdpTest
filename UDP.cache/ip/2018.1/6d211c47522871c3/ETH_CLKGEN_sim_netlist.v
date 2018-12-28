// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.1 (lin64) Build 2188600 Wed Apr  4 18:39:19 MDT 2018
// Date        : Mon Dec 24 20:39:51 2018
// Host        : Z10PE-01 running 64-bit Ubuntu 16.04.5 LTS
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ ETH_CLKGEN_sim_netlist.v
// Design      : ETH_CLKGEN
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a200tsbg484-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
   (eth_rxck_45deg,
    eth_rxck_90deg,
    eth_rxck_180deg,
    eth_rxck_270deg,
    reset,
    locked,
    eth_rxck);
  output eth_rxck_45deg;
  output eth_rxck_90deg;
  output eth_rxck_180deg;
  output eth_rxck_270deg;
  input reset;
  output locked;
  input eth_rxck;

  (* IBUF_LOW_PWR *) wire eth_rxck;
  wire eth_rxck_180deg;
  wire eth_rxck_270deg;
  wire eth_rxck_45deg;
  wire eth_rxck_90deg;
  wire locked;
  wire reset;

  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ETH_CLKGEN_clk_wiz inst
       (.eth_rxck(eth_rxck),
        .eth_rxck_180deg(eth_rxck_180deg),
        .eth_rxck_270deg(eth_rxck_270deg),
        .eth_rxck_45deg(eth_rxck_45deg),
        .eth_rxck_90deg(eth_rxck_90deg),
        .locked(locked),
        .reset(reset));
endmodule

module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ETH_CLKGEN_clk_wiz
   (eth_rxck_45deg,
    eth_rxck_90deg,
    eth_rxck_180deg,
    eth_rxck_270deg,
    reset,
    locked,
    eth_rxck);
  output eth_rxck_45deg;
  output eth_rxck_90deg;
  output eth_rxck_180deg;
  output eth_rxck_270deg;
  input reset;
  output locked;
  input eth_rxck;

  wire clkfbout_ETH_CLKGEN;
  wire clkfbout_buf_ETH_CLKGEN;
  wire eth_rxck;
  wire eth_rxck_180deg;
  wire eth_rxck_180deg_ETH_CLKGEN;
  wire eth_rxck_270deg;
  wire eth_rxck_270deg_ETH_CLKGEN;
  wire eth_rxck_45deg;
  wire eth_rxck_45deg_ETH_CLKGEN;
  wire eth_rxck_90deg;
  wire eth_rxck_90deg_ETH_CLKGEN;
  wire eth_rxck_ETH_CLKGEN;
  wire locked;
  wire reset;
  wire NLW_plle2_adv_inst_CLKOUT4_UNCONNECTED;
  wire NLW_plle2_adv_inst_CLKOUT5_UNCONNECTED;
  wire NLW_plle2_adv_inst_DRDY_UNCONNECTED;
  wire [15:0]NLW_plle2_adv_inst_DO_UNCONNECTED;

  (* BOX_TYPE = "PRIMITIVE" *) 
  BUFG clkf_buf
       (.I(clkfbout_ETH_CLKGEN),
        .O(clkfbout_buf_ETH_CLKGEN));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* CAPACITANCE = "DONT_CARE" *) 
  (* IBUF_DELAY_VALUE = "0" *) 
  (* IFD_DELAY_VALUE = "AUTO" *) 
  IBUF #(
    .IOSTANDARD("DEFAULT")) 
    clkin1_ibufg
       (.I(eth_rxck),
        .O(eth_rxck_ETH_CLKGEN));
  (* BOX_TYPE = "PRIMITIVE" *) 
  BUFG clkout1_buf
       (.I(eth_rxck_45deg_ETH_CLKGEN),
        .O(eth_rxck_45deg));
  (* BOX_TYPE = "PRIMITIVE" *) 
  BUFG clkout2_buf
       (.I(eth_rxck_90deg_ETH_CLKGEN),
        .O(eth_rxck_90deg));
  (* BOX_TYPE = "PRIMITIVE" *) 
  BUFG clkout3_buf
       (.I(eth_rxck_180deg_ETH_CLKGEN),
        .O(eth_rxck_180deg));
  (* BOX_TYPE = "PRIMITIVE" *) 
  BUFG clkout4_buf
       (.I(eth_rxck_270deg_ETH_CLKGEN),
        .O(eth_rxck_270deg));
  (* BOX_TYPE = "PRIMITIVE" *) 
  PLLE2_ADV #(
    .BANDWIDTH("OPTIMIZED"),
    .CLKFBOUT_MULT(7),
    .CLKFBOUT_PHASE(0.000000),
    .CLKIN1_PERIOD(8.000000),
    .CLKIN2_PERIOD(0.000000),
    .CLKOUT0_DIVIDE(7),
    .CLKOUT0_DUTY_CYCLE(0.500000),
    .CLKOUT0_PHASE(45.000000),
    .CLKOUT1_DIVIDE(7),
    .CLKOUT1_DUTY_CYCLE(0.500000),
    .CLKOUT1_PHASE(90.000000),
    .CLKOUT2_DIVIDE(7),
    .CLKOUT2_DUTY_CYCLE(0.500000),
    .CLKOUT2_PHASE(180.000000),
    .CLKOUT3_DIVIDE(7),
    .CLKOUT3_DUTY_CYCLE(0.500000),
    .CLKOUT3_PHASE(270.000000),
    .CLKOUT4_DIVIDE(1),
    .CLKOUT4_DUTY_CYCLE(0.500000),
    .CLKOUT4_PHASE(0.000000),
    .CLKOUT5_DIVIDE(1),
    .CLKOUT5_DUTY_CYCLE(0.500000),
    .CLKOUT5_PHASE(0.000000),
    .COMPENSATION("ZHOLD"),
    .DIVCLK_DIVIDE(1),
    .IS_CLKINSEL_INVERTED(1'b0),
    .IS_PWRDWN_INVERTED(1'b0),
    .IS_RST_INVERTED(1'b0),
    .REF_JITTER1(0.010000),
    .REF_JITTER2(0.010000),
    .STARTUP_WAIT("FALSE")) 
    plle2_adv_inst
       (.CLKFBIN(clkfbout_buf_ETH_CLKGEN),
        .CLKFBOUT(clkfbout_ETH_CLKGEN),
        .CLKIN1(eth_rxck_ETH_CLKGEN),
        .CLKIN2(1'b0),
        .CLKINSEL(1'b1),
        .CLKOUT0(eth_rxck_45deg_ETH_CLKGEN),
        .CLKOUT1(eth_rxck_90deg_ETH_CLKGEN),
        .CLKOUT2(eth_rxck_180deg_ETH_CLKGEN),
        .CLKOUT3(eth_rxck_270deg_ETH_CLKGEN),
        .CLKOUT4(NLW_plle2_adv_inst_CLKOUT4_UNCONNECTED),
        .CLKOUT5(NLW_plle2_adv_inst_CLKOUT5_UNCONNECTED),
        .DADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DCLK(1'b0),
        .DEN(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DO(NLW_plle2_adv_inst_DO_UNCONNECTED[15:0]),
        .DRDY(NLW_plle2_adv_inst_DRDY_UNCONNECTED),
        .DWE(1'b0),
        .LOCKED(locked),
        .PWRDWN(1'b0),
        .RST(reset));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
