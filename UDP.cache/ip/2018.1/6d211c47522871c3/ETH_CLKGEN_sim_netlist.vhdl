-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.1 (lin64) Build 2188600 Wed Apr  4 18:39:19 MDT 2018
-- Date        : Mon Dec 24 20:39:51 2018
-- Host        : Z10PE-01 running 64-bit Ubuntu 16.04.5 LTS
-- Command     : write_vhdl -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
--               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ ETH_CLKGEN_sim_netlist.vhdl
-- Design      : ETH_CLKGEN
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a200tsbg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ETH_CLKGEN_clk_wiz is
  port (
    eth_rxck_45deg : out STD_LOGIC;
    eth_rxck_90deg : out STD_LOGIC;
    eth_rxck_180deg : out STD_LOGIC;
    eth_rxck_270deg : out STD_LOGIC;
    reset : in STD_LOGIC;
    locked : out STD_LOGIC;
    eth_rxck : in STD_LOGIC
  );
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ETH_CLKGEN_clk_wiz;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ETH_CLKGEN_clk_wiz is
  signal clkfbout_ETH_CLKGEN : STD_LOGIC;
  signal clkfbout_buf_ETH_CLKGEN : STD_LOGIC;
  signal eth_rxck_180deg_ETH_CLKGEN : STD_LOGIC;
  signal eth_rxck_270deg_ETH_CLKGEN : STD_LOGIC;
  signal eth_rxck_45deg_ETH_CLKGEN : STD_LOGIC;
  signal eth_rxck_90deg_ETH_CLKGEN : STD_LOGIC;
  signal eth_rxck_ETH_CLKGEN : STD_LOGIC;
  signal NLW_plle2_adv_inst_CLKOUT4_UNCONNECTED : STD_LOGIC;
  signal NLW_plle2_adv_inst_CLKOUT5_UNCONNECTED : STD_LOGIC;
  signal NLW_plle2_adv_inst_DRDY_UNCONNECTED : STD_LOGIC;
  signal NLW_plle2_adv_inst_DO_UNCONNECTED : STD_LOGIC_VECTOR ( 15 downto 0 );
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of clkf_buf : label is "PRIMITIVE";
  attribute BOX_TYPE of clkin1_ibufg : label is "PRIMITIVE";
  attribute CAPACITANCE : string;
  attribute CAPACITANCE of clkin1_ibufg : label is "DONT_CARE";
  attribute IBUF_DELAY_VALUE : string;
  attribute IBUF_DELAY_VALUE of clkin1_ibufg : label is "0";
  attribute IFD_DELAY_VALUE : string;
  attribute IFD_DELAY_VALUE of clkin1_ibufg : label is "AUTO";
  attribute BOX_TYPE of clkout1_buf : label is "PRIMITIVE";
  attribute BOX_TYPE of clkout2_buf : label is "PRIMITIVE";
  attribute BOX_TYPE of clkout3_buf : label is "PRIMITIVE";
  attribute BOX_TYPE of clkout4_buf : label is "PRIMITIVE";
  attribute BOX_TYPE of plle2_adv_inst : label is "PRIMITIVE";
begin
clkf_buf: unisim.vcomponents.BUFG
     port map (
      I => clkfbout_ETH_CLKGEN,
      O => clkfbout_buf_ETH_CLKGEN
    );
clkin1_ibufg: unisim.vcomponents.IBUF
    generic map(
      IOSTANDARD => "DEFAULT"
    )
        port map (
      I => eth_rxck,
      O => eth_rxck_ETH_CLKGEN
    );
clkout1_buf: unisim.vcomponents.BUFG
     port map (
      I => eth_rxck_45deg_ETH_CLKGEN,
      O => eth_rxck_45deg
    );
clkout2_buf: unisim.vcomponents.BUFG
     port map (
      I => eth_rxck_90deg_ETH_CLKGEN,
      O => eth_rxck_90deg
    );
clkout3_buf: unisim.vcomponents.BUFG
     port map (
      I => eth_rxck_180deg_ETH_CLKGEN,
      O => eth_rxck_180deg
    );
clkout4_buf: unisim.vcomponents.BUFG
     port map (
      I => eth_rxck_270deg_ETH_CLKGEN,
      O => eth_rxck_270deg
    );
plle2_adv_inst: unisim.vcomponents.PLLE2_ADV
    generic map(
      BANDWIDTH => "OPTIMIZED",
      CLKFBOUT_MULT => 7,
      CLKFBOUT_PHASE => 0.000000,
      CLKIN1_PERIOD => 8.000000,
      CLKIN2_PERIOD => 0.000000,
      CLKOUT0_DIVIDE => 7,
      CLKOUT0_DUTY_CYCLE => 0.500000,
      CLKOUT0_PHASE => 45.000000,
      CLKOUT1_DIVIDE => 7,
      CLKOUT1_DUTY_CYCLE => 0.500000,
      CLKOUT1_PHASE => 90.000000,
      CLKOUT2_DIVIDE => 7,
      CLKOUT2_DUTY_CYCLE => 0.500000,
      CLKOUT2_PHASE => 180.000000,
      CLKOUT3_DIVIDE => 7,
      CLKOUT3_DUTY_CYCLE => 0.500000,
      CLKOUT3_PHASE => 270.000000,
      CLKOUT4_DIVIDE => 1,
      CLKOUT4_DUTY_CYCLE => 0.500000,
      CLKOUT4_PHASE => 0.000000,
      CLKOUT5_DIVIDE => 1,
      CLKOUT5_DUTY_CYCLE => 0.500000,
      CLKOUT5_PHASE => 0.000000,
      COMPENSATION => "ZHOLD",
      DIVCLK_DIVIDE => 1,
      IS_CLKINSEL_INVERTED => '0',
      IS_PWRDWN_INVERTED => '0',
      IS_RST_INVERTED => '0',
      REF_JITTER1 => 0.010000,
      REF_JITTER2 => 0.010000,
      STARTUP_WAIT => "FALSE"
    )
        port map (
      CLKFBIN => clkfbout_buf_ETH_CLKGEN,
      CLKFBOUT => clkfbout_ETH_CLKGEN,
      CLKIN1 => eth_rxck_ETH_CLKGEN,
      CLKIN2 => '0',
      CLKINSEL => '1',
      CLKOUT0 => eth_rxck_45deg_ETH_CLKGEN,
      CLKOUT1 => eth_rxck_90deg_ETH_CLKGEN,
      CLKOUT2 => eth_rxck_180deg_ETH_CLKGEN,
      CLKOUT3 => eth_rxck_270deg_ETH_CLKGEN,
      CLKOUT4 => NLW_plle2_adv_inst_CLKOUT4_UNCONNECTED,
      CLKOUT5 => NLW_plle2_adv_inst_CLKOUT5_UNCONNECTED,
      DADDR(6 downto 0) => B"0000000",
      DCLK => '0',
      DEN => '0',
      DI(15 downto 0) => B"0000000000000000",
      DO(15 downto 0) => NLW_plle2_adv_inst_DO_UNCONNECTED(15 downto 0),
      DRDY => NLW_plle2_adv_inst_DRDY_UNCONNECTED,
      DWE => '0',
      LOCKED => locked,
      PWRDWN => '0',
      RST => reset
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
  port (
    eth_rxck_45deg : out STD_LOGIC;
    eth_rxck_90deg : out STD_LOGIC;
    eth_rxck_180deg : out STD_LOGIC;
    eth_rxck_270deg : out STD_LOGIC;
    reset : in STD_LOGIC;
    locked : out STD_LOGIC;
    eth_rxck : in STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is true;
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
begin
inst: entity work.decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ETH_CLKGEN_clk_wiz
     port map (
      eth_rxck => eth_rxck,
      eth_rxck_180deg => eth_rxck_180deg,
      eth_rxck_270deg => eth_rxck_270deg,
      eth_rxck_45deg => eth_rxck_45deg,
      eth_rxck_90deg => eth_rxck_90deg,
      locked => locked,
      reset => reset
    );
end STRUCTURE;
