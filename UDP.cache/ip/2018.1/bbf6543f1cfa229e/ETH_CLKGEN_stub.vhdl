-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.1 (lin64) Build 2188600 Wed Apr  4 18:39:19 MDT 2018
-- Date        : Mon Dec 24 21:25:51 2018
-- Host        : Z10PE-01 running 64-bit Ubuntu 16.04.5 LTS
-- Command     : write_vhdl -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
--               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ ETH_CLKGEN_stub.vhdl
-- Design      : ETH_CLKGEN
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a200tsbg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
  Port ( 
    rxck_0deg : out STD_LOGIC;
    rxck_90deg : out STD_LOGIC;
    rxck_180deg : out STD_LOGIC;
    rxck_270deg : out STD_LOGIC;
    rxck_n90deg : out STD_LOGIC;
    resetn : in STD_LOGIC;
    locked : out STD_LOGIC;
    eth_rxck : in STD_LOGIC
  );

end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix;

architecture stub of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "rxck_0deg,rxck_90deg,rxck_180deg,rxck_270deg,rxck_n90deg,resetn,locked,eth_rxck";
begin
end;
