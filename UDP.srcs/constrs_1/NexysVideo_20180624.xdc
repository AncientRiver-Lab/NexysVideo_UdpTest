### This file is a general .xdc for the Nexys Video Rev. A
### To use it in a project:
### - uncomment the lines corresponding to used pins
### - rename the used ports (in each line, after get_ports) according to the top level signal names in the project


## Clock Signal
set_property -dict {PACKAGE_PIN R4 IOSTANDARD LVCMOS33} [get_ports SYSCLK]
create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} -add [get_ports SYSCLK]

#set_property CLOCK_DEDICATED_ROUTE BACKBONE [get_nets pllsys/inst/SYSCLK_i_PLLSYS];
## FMC Transceiver clocks (Must be set to value provided by Mezzanine card, currently set to 156.25 MHz)
## Note: This clock is attached to a MGTREFCLK pin
#set_property -dict { PACKAGE_PIN E6 } [get_ports { GTP_CLK_N }];
#set_property -dict { PACKAGE_PIN F6 } [get_ports { GTP_CLK_P }];
#create_clock -add -name gtpclk0_pin -period 6.400 -waveform {0 3.200} [get_ports {GTP_CLK_P}];
#set_property -dict { PACKAGE_PIN E10 } [get_ports { FMC_MGT_CLK_N }];
#set_property -dict { PACKAGE_PIN F10 } [get_ports { FMC_MGT_CLK_P }];
#create_clock -add -name mgtclk1_pin -period 6.400 -waveform {0 3.200} [get_ports {FMC_MGT_CLK_P}];


## LEDs
set_property -dict {PACKAGE_PIN T14 IOSTANDARD LVCMOS25} [get_ports {LED[0]}]
set_property -dict {PACKAGE_PIN T15 IOSTANDARD LVCMOS25} [get_ports {LED[1]}]
set_property -dict {PACKAGE_PIN T16 IOSTANDARD LVCMOS25} [get_ports {LED[2]}]
set_property -dict {PACKAGE_PIN U16 IOSTANDARD LVCMOS25} [get_ports {LED[3]}]
set_property -dict {PACKAGE_PIN V15 IOSTANDARD LVCMOS25} [get_ports {LED[4]}]
set_property -dict {PACKAGE_PIN W16 IOSTANDARD LVCMOS25} [get_ports {LED[5]}]
set_property -dict {PACKAGE_PIN W15 IOSTANDARD LVCMOS25} [get_ports {LED[6]}]
set_property -dict {PACKAGE_PIN Y13 IOSTANDARD LVCMOS25} [get_ports {LED[7]}]


## Buttons
set_property -dict {PACKAGE_PIN B22 IOSTANDARD LVCMOS33} [get_ports BTN_C]
set_property -dict {PACKAGE_PIN D22 IOSTANDARD LVCMOS33} [get_ports BTN_D];
set_property -dict {PACKAGE_PIN C22 IOSTANDARD LVCMOS33} [get_ports BTN_L];
set_property -dict {PACKAGE_PIN D14 IOSTANDARD LVCMOS33} [get_ports BTN_R];
set_property -dict {PACKAGE_PIN F15 IOSTANDARD LVCMOS33} [get_ports BTN_U];
set_property -dict {PACKAGE_PIN G4 IOSTANDARD LVCMOS15} [get_ports CPU_RSTN]
set_false_path -from [get_ports CPU_RSTN]

## Switches
set_property -dict {PACKAGE_PIN E22 IOSTANDARD LVCMOS33} [get_ports {SW[0]}]
set_property -dict {PACKAGE_PIN F21 IOSTANDARD LVCMOS33} [get_ports {SW[1]}]
set_property -dict {PACKAGE_PIN G21 IOSTANDARD LVCMOS33} [get_ports {SW[2]}]
set_property -dict {PACKAGE_PIN G22 IOSTANDARD LVCMOS33} [get_ports {SW[3]}]
set_property -dict {PACKAGE_PIN H17 IOSTANDARD LVCMOS33} [get_ports {SW[4]}]
set_property -dict {PACKAGE_PIN J16 IOSTANDARD LVCMOS33} [get_ports {SW[5]}]
set_property -dict {PACKAGE_PIN K13 IOSTANDARD LVCMOS33} [get_ports {SW[6]}]
set_property -dict {PACKAGE_PIN M17 IOSTANDARD LVCMOS33} [get_ports {SW[7]}]


## OLED Display
#set_property -dict { PACKAGE_PIN W22   IOSTANDARD LVCMOS33 } [get_ports { oled_dc }]; #IO_L7N_T1_D10_14 Sch=oled_dc
#set_property -dict { PACKAGE_PIN U21   IOSTANDARD LVCMOS33 } [get_ports { oled_res }]; #IO_L4N_T0_D05_14 Sch=oled_res
#set_property -dict { PACKAGE_PIN W21   IOSTANDARD LVCMOS33 } [get_ports { oled_sclk }]; #IO_L7P_T1_D09_14 Sch=oled_sclk
#set_property -dict { PACKAGE_PIN Y22   IOSTANDARD LVCMOS33 } [get_ports { oled_sdin }]; #IO_L9N_T1_DQS_D13_14 Sch=oled_sdin
#set_property -dict { PACKAGE_PIN P20   IOSTANDARD LVCMOS33 } [get_ports { oled_vbat }]; #IO_0_14 Sch=oled_vbat
#set_property -dict { PACKAGE_PIN V22   IOSTANDARD LVCMOS33 } [get_ports { oled_vdd }]; #IO_L3N_T0_DQS_EMCCLK_14 Sch=oled_vdd


## HDMI in
set_property -dict {PACKAGE_PIN AA5 IOSTANDARD LVCMOS33} [get_ports HDMI_RX_CEC];
set_property -dict {PACKAGE_PIN W4 IOSTANDARD TMDS_33} [get_ports HDMI_RX_CLK_N];
set_property -dict {PACKAGE_PIN V4 IOSTANDARD TMDS_33} [get_ports HDMI_RX_CLK_P];
set_property -dict {PACKAGE_PIN AB12 IOSTANDARD LVCMOS25} [get_ports HDMI_RX_HPA];
set_property -dict {PACKAGE_PIN Y4 IOSTANDARD LVCMOS33} [get_ports HDMI_RX_SCL];
set_property -dict {PACKAGE_PIN AB5 IOSTANDARD LVCMOS33} [get_ports HDMI_RX_SDA];
set_property -dict {PACKAGE_PIN R3 IOSTANDARD LVCMOS33} [get_ports HDMI_RX_TXEN];
set_property -dict {PACKAGE_PIN AA3 IOSTANDARD TMDS_33} [get_ports {HDMI_RX_DAT_N[0]}];
set_property -dict {PACKAGE_PIN Y3 IOSTANDARD TMDS_33} [get_ports {HDMI_RX_DAT_P[0]}];
set_property -dict {PACKAGE_PIN Y2 IOSTANDARD TMDS_33} [get_ports {HDMI_RX_DAT_N[1]}];
set_property -dict {PACKAGE_PIN W2 IOSTANDARD TMDS_33} [get_ports {HDMI_RX_DAT_P[1]}];
set_property -dict {PACKAGE_PIN V2 IOSTANDARD TMDS_33} [get_ports {HDMI_RX_DAT_N[2]}];
set_property -dict {PACKAGE_PIN U2 IOSTANDARD TMDS_33} [get_ports {HDMI_RX_DAT_P[2]}];
create_clock -period 8.330 -name hdmi_rx0_clk -waveform {0.000 4.165} [get_ports HDMI_RX_CLK_P];
#set_property CLOCK_DEDICATED_ROUTE BACKBONE [get_nets dvi2rgb_i0/U0/TMDS_ClockingX/CLK_IN_hdmi_clk];


## HDMI out
#set_property -dict { PACKAGE_PIN AA4   IOSTANDARD LVCMOS33 } [get_ports { hdmi_tx_cec }]; #IO_L11N_T1_SRCC_34 Sch=hdmi_tx_cec
set_property -dict {PACKAGE_PIN U1 IOSTANDARD TMDS_33} [get_ports HDMI_TX_CLK_N];
set_property -dict {PACKAGE_PIN T1 IOSTANDARD TMDS_33} [get_ports HDMI_TX_CLK_P];
#set_property -dict { PACKAGE_PIN AB13  IOSTANDARD LVCMOS25 } [get_ports { hdmi_tx_hpd }]; #IO_L3N_T0_DQS_13 Sch=hdmi_tx_hpd
#set_property -dict { PACKAGE_PIN U3    IOSTANDARD LVCMOS33 } [get_ports { hdmi_tx_rscl }]; #IO_L6P_T0_34 Sch=hdmi_tx_rscl
#set_property -dict { PACKAGE_PIN V3    IOSTANDARD LVCMOS33 } [get_ports { hdmi_tx_rsda }]; #IO_L6N_T0_VREF_34 Sch=hdmi_tx_rsda
set_property -dict {PACKAGE_PIN Y1 IOSTANDARD TMDS_33} [get_ports {HDMI_TX_DAT_N[0]}];
set_property -dict {PACKAGE_PIN W1 IOSTANDARD TMDS_33} [get_ports {HDMI_TX_DAT_P[0]}];
set_property -dict {PACKAGE_PIN AB1 IOSTANDARD TMDS_33} [get_ports {HDMI_TX_DAT_N[1]}];
set_property -dict {PACKAGE_PIN AA1 IOSTANDARD TMDS_33} [get_ports {HDMI_TX_DAT_P[1]}];
set_property -dict {PACKAGE_PIN AB2 IOSTANDARD TMDS_33} [get_ports {HDMI_TX_DAT_N[2]}];
set_property -dict {PACKAGE_PIN AB3 IOSTANDARD TMDS_33} [get_ports {HDMI_TX_DAT_P[2]}];
#create_clock -period 6.250 [get_ports rgb2dvi/PixelClk]

## Display Port
#set_property -dict { PACKAGE_PIN AB10  IOSTANDARD TMDS_33  } [get_ports { dp_tx_aux_n }]; #IO_L8N_T1_13 Sch=dp_tx_aux_n
#set_property -dict { PACKAGE_PIN AA11  IOSTANDARD TMDS_33  } [get_ports { dp_tx_aux_n }]; #IO_L9N_T1_DQS_13 Sch=dp_tx_aux_n
#set_property -dict { PACKAGE_PIN AA9   IOSTANDARD TMDS_33  } [get_ports { dp_tx_aux_p }]; #IO_L8P_T1_13 Sch=dp_tx_aux_p
#set_property -dict { PACKAGE_PIN AA10  IOSTANDARD TMDS_33  } [get_ports { dp_tx_aux_p }]; #IO_L9P_T1_DQS_13 Sch=dp_tx_aux_p
#set_property -dict { PACKAGE_PIN N15   IOSTANDARD LVCMOS33 } [get_ports { dp_tx_hpd }]; #IO_25_14 Sch=dp_tx_hpd


## Audio Codec
#set_property -dict { PACKAGE_PIN T4    IOSTANDARD LVCMOS33 } [get_ports { ac_adc_sdata }]; #IO_L13N_T2_MRCC_34 Sch=ac_adc_sdata
#set_property -dict { PACKAGE_PIN T5    IOSTANDARD LVCMOS33 } [get_ports { ac_bclk }]; #IO_L14P_T2_SRCC_34 Sch=ac_bclk
#set_property -dict { PACKAGE_PIN W6    IOSTANDARD LVCMOS33 } [get_ports { ac_dac_sdata }]; #IO_L15P_T2_DQS_34 Sch=ac_dac_sdata
#set_property -dict { PACKAGE_PIN U5    IOSTANDARD LVCMOS33 } [get_ports { ac_lrclk }]; #IO_L14N_T2_SRCC_34 Sch=ac_lrclk
#set_property -dict { PACKAGE_PIN U6    IOSTANDARD LVCMOS33 } [get_ports { ac_mclk }]; #IO_L16P_T2_34 Sch=ac_mclk


## Pmod header JA
set_property -dict {PACKAGE_PIN AB22 IOSTANDARD LVCMOS33} [get_ports {PMOD_A[0]}];
set_property -dict {PACKAGE_PIN AB21 IOSTANDARD LVCMOS33} [get_ports {PMOD_A[1]}];
set_property -dict {PACKAGE_PIN AB20 IOSTANDARD LVCMOS33} [get_ports {PMOD_A[2]}];
set_property -dict {PACKAGE_PIN AB18 IOSTANDARD LVCMOS33} [get_ports {PMOD_A[3]}];
set_property -dict {PACKAGE_PIN Y21 IOSTANDARD LVCMOS33} [get_ports {PMOD_A[4]}];
set_property -dict {PACKAGE_PIN AA21 IOSTANDARD LVCMOS33} [get_ports {PMOD_A[5]}];
set_property -dict {PACKAGE_PIN AA20 IOSTANDARD LVCMOS33} [get_ports {PMOD_A[6]}];
set_property -dict {PACKAGE_PIN AA18 IOSTANDARD LVCMOS33} [get_ports {PMOD_A[7]}];
set_false_path -to [get_ports {PMOD_A[*]}]

## Pmod header JB
set_property -dict {PACKAGE_PIN V9 IOSTANDARD LVCMOS33} [get_ports {PMOD_B[0]}];
set_property -dict {PACKAGE_PIN V8 IOSTANDARD LVCMOS33} [get_ports {PMOD_B[1]}];
set_property -dict {PACKAGE_PIN V7 IOSTANDARD LVCMOS33} [get_ports {PMOD_B[2]}];
set_property -dict {PACKAGE_PIN W7 IOSTANDARD LVCMOS33} [get_ports {PMOD_B[3]}];
set_property -dict {PACKAGE_PIN W9 IOSTANDARD LVCMOS33} [get_ports {PMOD_B[4]}];
set_property -dict {PACKAGE_PIN Y9 IOSTANDARD LVCMOS33} [get_ports {PMOD_B[5]}];
set_property -dict {PACKAGE_PIN Y8 IOSTANDARD LVCMOS33} [get_ports {PMOD_B[6]}];
set_property -dict {PACKAGE_PIN Y7 IOSTANDARD LVCMOS33} [get_ports {PMOD_B[7]}];


## Pmod header JC
set_property -dict {PACKAGE_PIN Y6 IOSTANDARD LVCMOS33} [get_ports {PMOD_C[0]}];
set_property -dict {PACKAGE_PIN AA6 IOSTANDARD LVCMOS33} [get_ports {PMOD_C[1]}];
set_property -dict {PACKAGE_PIN AA8 IOSTANDARD LVCMOS33} [get_ports {PMOD_C[2]}];
set_property -dict {PACKAGE_PIN AB8 IOSTANDARD LVCMOS33} [get_ports {PMOD_C[3]}];
set_property -dict {PACKAGE_PIN R6 IOSTANDARD LVCMOS33} [get_ports {PMOD_C[4]}];
set_property -dict {PACKAGE_PIN T6 IOSTANDARD LVCMOS33} [get_ports {PMOD_C[5]}];
set_property -dict {PACKAGE_PIN AB7 IOSTANDARD LVCMOS33} [get_ports {PMOD_C[6]}];
set_property -dict {PACKAGE_PIN AB6 IOSTANDARD LVCMOS33} [get_ports {PMOD_C[7]}];


## XADC Header
#set_property -dict { PACKAGE_PIN J14   IOSTANDARD LVCMOS33 } [get_ports { xa_p[0] }]; #IO_L3P_T0_DQS_AD1P_15 Sch=xa_p[1]
#set_property -dict { PACKAGE_PIN H13   IOSTANDARD LVCMOS33 } [get_ports { xa_p[1] }]; #IO_L1P_T0_AD0P_15 Sch=xa_p[2]
#set_property -dict { PACKAGE_PIN G13   IOSTANDARD LVCMOS33 } [get_ports { xa_n[1] }]; #IO_L1N_T0_AD0N_15 Sch=xa_n[2]
#set_property -dict { PACKAGE_PIN G15   IOSTANDARD LVCMOS33 } [get_ports { xa_p[2] }]; #IO_L2P_T0_AD8P_15 Sch=xa_p[3]
#set_property -dict { PACKAGE_PIN G16   IOSTANDARD LVCMOS33 } [get_ports { xa_n[2] }]; #IO_L2N_T0_AD8N_15 Sch=xa_n[3]
#set_property -dict { PACKAGE_PIN J15   IOSTANDARD LVCMOS33 } [get_ports { xa_p[3] }]; #IO_L5P_T0_AD9P_15 Sch=xa_p[4]
#set_property -dict { PACKAGE_PIN H15   IOSTANDARD LVCMOS33 } [get_ports { xa_n[3] }]; #IO_L5N_T0_AD9N_15 Sch=xa_n[4]


## UART
set_property -dict {PACKAGE_PIN AA19 IOSTANDARD LVCMOS33} [get_ports UART_RX_OUT];
set_property -dict {PACKAGE_PIN V18 IOSTANDARD LVCMOS33} [get_ports UART_TX_IN];


## Ethernet
set_property -dict { PACKAGE_PIN Y14   IOSTANDARD LVCMOS25 } [get_ports { eth_int_b }]; #IO_L6N_T0_VREF_13 Sch=eth_int_b
set_property -dict { PACKAGE_PIN AA16  IOSTANDARD LVCMOS25 } [get_ports { eth_mdc }]; #IO_L1N_T0_13 Sch=eth_mdc
set_property -dict { PACKAGE_PIN Y16   IOSTANDARD LVCMOS25 } [get_ports { eth_mdio }]; #IO_L1P_T0_13 Sch=eth_mdio
set_property -dict { PACKAGE_PIN W14   IOSTANDARD LVCMOS25 } [get_ports { eth_pme_b }]; #IO_L6P_T0_13 Sch=eth_pme_b
set_property -dict {PACKAGE_PIN U7 IOSTANDARD LVCMOS33} [get_ports eth_rst_b]
set_property -dict {PACKAGE_PIN V13 IOSTANDARD LVCMOS25} [get_ports eth_rxck]
set_property -dict {PACKAGE_PIN W10 IOSTANDARD LVCMOS25} [get_ports eth_rxctl]
set_property -dict {PACKAGE_PIN AB16 IOSTANDARD LVCMOS25} [get_ports {eth_rxd[0]}]
set_property -dict {PACKAGE_PIN AA15 IOSTANDARD LVCMOS25} [get_ports {eth_rxd[1]}]
set_property -dict {PACKAGE_PIN AB15 IOSTANDARD LVCMOS25} [get_ports {eth_rxd[2]}]
set_property -dict {PACKAGE_PIN AB11 IOSTANDARD LVCMOS25} [get_ports {eth_rxd[3]}]
set_property -dict {PACKAGE_PIN AA14 IOSTANDARD LVCMOS25} [get_ports eth_txck]
set_property -dict {PACKAGE_PIN V10 IOSTANDARD LVCMOS25} [get_ports eth_txctl]
set_property -dict {PACKAGE_PIN Y12 IOSTANDARD LVCMOS25} [get_ports {eth_txd[0]}]
set_property -dict {PACKAGE_PIN W12 IOSTANDARD LVCMOS25} [get_ports {eth_txd[1]}]
set_property -dict {PACKAGE_PIN W11 IOSTANDARD LVCMOS25} [get_ports {eth_txd[2]}]
set_property -dict {PACKAGE_PIN Y11 IOSTANDARD LVCMOS25} [get_ports {eth_txd[3]}]


## Fan PWM
#set_property -dict { PACKAGE_PIN U15   IOSTANDARD LVCMOS25 } [get_ports { fan_pwm }]; #IO_L14P_T2_SRCC_13 Sch=fan_pwm


## DPTI/DSPI
#set_property -dict { PACKAGE_PIN Y18   IOSTANDARD LVCMOS33 } [get_ports { prog_clko }]; #IO_L13P_T2_MRCC_14 Sch=prog_clko
#set_property -dict { PACKAGE_PIN U20   IOSTANDARD LVCMOS33 } [get_ports { prog_d[0]}]; #IO_L11P_T1_SRCC_14 Sch=prog_d0/sck
#set_property -dict { PACKAGE_PIN P14   IOSTANDARD LVCMOS33 } [get_ports { prog_d[1] }]; #IO_L19P_T3_A10_D26_14 Sch=prog_d1/mosi
#set_property -dict { PACKAGE_PIN P15   IOSTANDARD LVCMOS33 } [get_ports { prog_d[2] }]; #IO_L22P_T3_A05_D21_14 Sch=prog_d2/miso
#set_property -dict { PACKAGE_PIN U17   IOSTANDARD LVCMOS33 } [get_ports { prog_d[3]}]; #IO_L18P_T2_A12_D28_14 Sch=prog_d3/ss
#set_property -dict { PACKAGE_PIN R17   IOSTANDARD LVCMOS33 } [get_ports { prog_d[4] }]; #IO_L24N_T3_A00_D16_14 Sch=prog_d[4]
#set_property -dict { PACKAGE_PIN P16   IOSTANDARD LVCMOS33 } [get_ports { prog_d[5] }]; #IO_L24P_T3_A01_D17_14 Sch=prog_d[5]
#set_property -dict { PACKAGE_PIN R18   IOSTANDARD LVCMOS33 } [get_ports { prog_d[6] }]; #IO_L20P_T3_A08_D24_14 Sch=prog_d[6]
#set_property -dict { PACKAGE_PIN N14   IOSTANDARD LVCMOS33 } [get_ports { prog_d[7] }]; #IO_L23N_T3_A02_D18_14 Sch=prog_d[7]
#set_property -dict { PACKAGE_PIN V17   IOSTANDARD LVCMOS33 } [get_ports { prog_oen }]; #IO_L16P_T2_CSI_B_14 Sch=prog_oen
#set_property -dict { PACKAGE_PIN P19   IOSTANDARD LVCMOS33 } [get_ports { prog_rdn }]; #IO_L5P_T0_D06_14 Sch=prog_rdn
#set_property -dict { PACKAGE_PIN N17   IOSTANDARD LVCMOS33 } [get_ports { prog_rxen }]; #IO_L21P_T3_DQS_14 Sch=prog_rxen
#set_property -dict { PACKAGE_PIN P17   IOSTANDARD LVCMOS33 } [get_ports { prog_siwun }]; #IO_L21N_T3_DQS_A06_D22_14 Sch=prog_siwun
#set_property -dict { PACKAGE_PIN R14   IOSTANDARD LVCMOS33 } [get_ports { prog_spien }]; #IO_L19N_T3_A09_D25_VREF_14 Sch=prog_spien
#set_property -dict { PACKAGE_PIN Y19   IOSTANDARD LVCMOS33 } [get_ports { prog_txen }]; #IO_L13N_T2_MRCC_14 Sch=prog_txen
#set_property -dict { PACKAGE_PIN R19   IOSTANDARD LVCMOS33 } [get_ports { prog_wrn }]; #IO_L5N_T0_D07_14 Sch=prog_wrn


## HID port
#set_property -dict { PACKAGE_PIN W17   IOSTANDARD LVCMOS33   PULLUP true } [get_ports { ps2_clk }]; #IO_L16N_T2_A15_D31_14 Sch=ps2_clk
#set_property -dict { PACKAGE_PIN N13   IOSTANDARD LVCMOS33   PULLUP true } [get_ports { ps2_data }]; #IO_L23P_T3_A03_D19_14 Sch=ps2_data


## QSPI
#set_property -dict { PACKAGE_PIN T19   IOSTANDARD LVCMOS33 } [get_ports { qspi_cs }]; #IO_L6P_T0_FCS_B_14 Sch=qspi_cs
#set_property -dict { PACKAGE_PIN P22   IOSTANDARD LVCMOS33 } [get_ports { qspi_dq[0] }]; #IO_L1P_T0_D00_MOSI_14 Sch=qspi_dq[0]
#set_property -dict { PACKAGE_PIN R22   IOSTANDARD LVCMOS33 } [get_ports { qspi_dq[1] }]; #IO_L1N_T0_D01_DIN_14 Sch=qspi_dq[1]
#set_property -dict { PACKAGE_PIN P21   IOSTANDARD LVCMOS33 } [get_ports { qspi_dq[2] }]; #IO_L2P_T0_D02_14 Sch=qspi_dq[2]
#set_property -dict { PACKAGE_PIN R21   IOSTANDARD LVCMOS33 } [get_ports { qspi_dq[3] }]; #IO_L2N_T0_D03_14 Sch=qspi_dq[3]


## SD card
#set_property -dict { PACKAGE_PIN W19   IOSTANDARD LVCMOS33 } [get_ports { sd_cclk }]; #IO_L12P_T1_MRCC_14 Sch=sd_cclk
#set_property -dict { PACKAGE_PIN T18   IOSTANDARD LVCMOS33 } [get_ports { sd_cd }]; #IO_L20N_T3_A07_D23_14 Sch=sd_cd
#set_property -dict { PACKAGE_PIN W20   IOSTANDARD LVCMOS33 } [get_ports { sd_cmd }]; #IO_L12N_T1_MRCC_14 Sch=sd_cmd
#set_property -dict { PACKAGE_PIN V19   IOSTANDARD LVCMOS33 } [get_ports { sd_d[0] }]; #IO_L14N_T2_SRCC_14 Sch=sd_d[0]
#set_property -dict { PACKAGE_PIN T21   IOSTANDARD LVCMOS33 } [get_ports { sd_d[1] }]; #IO_L4P_T0_D04_14 Sch=sd_d[1]
#set_property -dict { PACKAGE_PIN T20   IOSTANDARD LVCMOS33 } [get_ports { sd_d[2] }]; #IO_L6N_T0_D08_VREF_14 Sch=sd_d[2]
#set_property -dict { PACKAGE_PIN U18   IOSTANDARD LVCMOS33 } [get_ports { sd_d[3] }]; #IO_L18N_T2_A11_D27_14 Sch=sd_d[3]
#set_property -dict { PACKAGE_PIN V20   IOSTANDARD LVCMOS33 } [get_ports { sd_reset }]; #IO_L11N_T1_SRCC_14 Sch=sd_reset


## I2C
#set_property -dict { PACKAGE_PIN W5    IOSTANDARD LVCMOS33 } [get_ports { scl }]; #IO_L15N_T2_DQS_34 Sch=scl
#set_property -dict { PACKAGE_PIN V5    IOSTANDARD LVCMOS33 } [get_ports { sda }]; #IO_L16N_T2_34 Sch=sda


## Voltage Adjust
set_property -dict {PACKAGE_PIN AA13 IOSTANDARD LVCMOS25} [get_ports {SET_VADJ[0]}];
set_property -dict {PACKAGE_PIN AB17 IOSTANDARD LVCMOS25} [get_ports {SET_VADJ[1]}];
set_property -dict {PACKAGE_PIN V14 IOSTANDARD LVCMOS25} [get_ports VADJ_EN];

##################
##  <--- FMC    ##
##################
#set_property -dict { PACKAGE_PIN H19   IOSTANDARD LVCMOS12 } [get_ports { fmc_clk0_m2c_n }]; #IO_L12N_T1_MRCC_15 Sch=fmc_clk0_m2c_n, "open"
#set_property -dict { PACKAGE_PIN J19   IOSTANDARD LVCMOS12 } [get_ports { fmc_clk0_m2c_p }]; #IO_L12P_T1_MRCC_15 Sch=fmc_clk0_m2c_p, "open"
#set_property -dict { PACKAGE_PIN C19   IOSTANDARD LVCMOS12 } [get_ports { fmc_clk1_m2c_n }]; #IO_L13N_T2_MRCC_16 Sch=fmc_clk1_m2c_n, "open"
#set_property -dict { PACKAGE_PIN C18   IOSTANDARD LVCMOS12 } [get_ports { fmc_clk1_m2c_p }]; #IO_L13P_T2_MRCC_16 Sch=fmc_clk1_m2c_p, "open"
set_property -dict {PACKAGE_PIN K19 IOSTANDARD LVCMOS33} [get_ports {FMC_HDMI1_P[23]}];
set_property -dict {PACKAGE_PIN K18 IOSTANDARD LVCMOS33} [get_ports FMC_HDMI1_LLC]; #IO_L13P_T2_MRCC_15 Sch=fmc_la00_cc_p
set_property -dict {PACKAGE_PIN J21 IOSTANDARD TMDS_33} [get_ports FMC_HDMI2_CLK_N];
set_property -dict {PACKAGE_PIN J20 IOSTANDARD TMDS_33} [get_ports FMC_HDMI2_CLK_P];
set_property -dict {PACKAGE_PIN L18 IOSTANDARD LVCMOS33} [get_ports {FMC_HDMI1_P[21]}];
set_property -dict {PACKAGE_PIN M18 IOSTANDARD LVCMOS33} [get_ports {FMC_HDMI1_P[22]}];
set_property -dict {PACKAGE_PIN N19 IOSTANDARD LVCMOS33} [get_ports {FMC_HDMI1_P[19]}];
set_property -dict {PACKAGE_PIN N18 IOSTANDARD LVCMOS33} [get_ports {FMC_HDMI1_P[20]}];
set_property -dict {PACKAGE_PIN M20 IOSTANDARD LVCMOS33} [get_ports {FMC_HDMI1_P[17]}];
set_property -dict {PACKAGE_PIN N20 IOSTANDARD LVCMOS33} [get_ports {FMC_HDMI1_P[18]}];
set_property -dict {PACKAGE_PIN L21 IOSTANDARD TMDS_33} [get_ports {FMC_HDMI2_DAT_N[1]}];
set_property -dict {PACKAGE_PIN M21 IOSTANDARD TMDS_33} [get_ports {FMC_HDMI2_DAT_P[1]}];
set_property -dict {PACKAGE_PIN M22 IOSTANDARD TMDS_33} [get_ports {FMC_HDMI2_DAT_N[0]}];
set_property -dict {PACKAGE_PIN N22 IOSTANDARD TMDS_33} [get_ports {FMC_HDMI2_DAT_P[0]}];
set_property -dict {PACKAGE_PIN L13 IOSTANDARD LVCMOS33} [get_ports {FMC_HDMI1_P[13]}];
set_property -dict {PACKAGE_PIN M13 IOSTANDARD LVCMOS33} [get_ports {FMC_HDMI1_P[15]}];
set_property -dict {PACKAGE_PIN M16 IOSTANDARD LVCMOS33} [get_ports {FMC_HDMI1_P[14]}];
set_property -dict {PACKAGE_PIN M15 IOSTANDARD LVCMOS33} [get_ports {FMC_HDMI1_P[16]}];
set_property -dict {PACKAGE_PIN G20 IOSTANDARD LVCMOS33} [get_ports FMC_HDMI2_TX_EN];
set_property -dict {PACKAGE_PIN H20 IOSTANDARD LVCMOS33} [get_ports FMC_HDMI2_PE_EN];
set_property -dict {PACKAGE_PIN K22 IOSTANDARD TMDS_33} [get_ports {FMC_HDMI2_DAT_N[2]}];
set_property -dict {PACKAGE_PIN K21 IOSTANDARD TMDS_33} [get_ports {FMC_HDMI2_DAT_P[2]}];
set_property -dict {PACKAGE_PIN L15 IOSTANDARD LVCMOS33} [get_ports {FMC_HDMI1_P[8]}];
set_property -dict {PACKAGE_PIN L14 IOSTANDARD LVCMOS33} [get_ports {FMC_HDMI1_P[10]}];
set_property -dict {PACKAGE_PIN L20 IOSTANDARD LVCMOS33} [get_ports {FMC_HDMI1_P[11]}];
set_property -dict {PACKAGE_PIN L19 IOSTANDARD LVCMOS33} [get_ports {FMC_HDMI1_P[12]}];
set_property -dict {PACKAGE_PIN J17 IOSTANDARD LVCMOS33} [get_ports FMC_HDMI2_SDA];
set_property -dict {PACKAGE_PIN K17 IOSTANDARD LVCMOS33} [get_ports FMC_HDMI2_SCL];
set_property -dict {PACKAGE_PIN H22 IOSTANDARD LVCMOS33} [get_ports {FMC_HDMI1_P[4]}];
set_property -dict {PACKAGE_PIN J22 IOSTANDARD LVCMOS33} [get_ports {FMC_HDMI1_P[9]}];
set_property -dict {PACKAGE_PIN K16 IOSTANDARD LVCMOS33} [get_ports {FMC_HDMI1_P[3]}];
set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVCMOS33} [get_ports {FMC_HDMI1_P[5]}];
set_property -dict {PACKAGE_PIN G18 IOSTANDARD LVCMOS33} [get_ports {FMC_HDMI1_P[6]}];
set_property -dict {PACKAGE_PIN G17 IOSTANDARD LVCMOS33} [get_ports {FMC_HDMI1_P[7]}];
set_property -dict {PACKAGE_PIN B18 IOSTANDARD LVCMOS33} [get_ports FMC_HDMI2_HPA];
set_property -dict {PACKAGE_PIN B17 IOSTANDARD LVCMOS33} [get_ports FMC_HDMI1_MCLK];
set_property -dict {PACKAGE_PIN C17 IOSTANDARD LVCMOS33} [get_ports FMC_HDMI2_CEC];
set_property -dict {PACKAGE_PIN D17 IOSTANDARD LVCMOS33} [get_ports FMC_HDMI1_SCLK];
set_property -dict {PACKAGE_PIN A19 IOSTANDARD LVCMOS33} [get_ports FMC_HDMI1_HS];
set_property -dict {PACKAGE_PIN A18 IOSTANDARD LVCMOS33} [get_ports {FMC_HDMI1_P[0]}];
set_property -dict {PACKAGE_PIN F20 IOSTANDARD LVCMOS33} [get_ports {FMC_HDMI1_P[1]}];
set_property -dict {PACKAGE_PIN F19 IOSTANDARD LVCMOS33} [get_ports {FMC_HDMI1_P[2]}];
set_property -dict {PACKAGE_PIN D19 IOSTANDARD LVCMOS33} [get_ports FMC_HDMI1_SCL];
set_property -dict {PACKAGE_PIN E19 IOSTANDARD LVCMOS33} [get_ports FMC_HDMI1_LRCLK];
set_property -dict {PACKAGE_PIN D21 IOSTANDARD LVCMOS33} [get_ports FMC_HDMI1_DE];
set_property -dict {PACKAGE_PIN E21 IOSTANDARD LVCMOS33} [get_ports FMC_HDMI1_VS]; #IO_L23P_T3_16 Sch=fmc_la_p[22]
set_property -dict {PACKAGE_PIN A21 IOSTANDARD LVCMOS33} [get_ports FMC_HDMI1_AP];
set_property -dict {PACKAGE_PIN B21 IOSTANDARD LVCMOS33} [get_ports FMC_HDMI1_RESETN]; #IO_L21P_T3_DQS_16 Sch=fmc_la_p[23]
#set_property -dict { PACKAGE_PIN B16   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_n[24] }]; #IO_L7N_T1_16 Sch=fmc_la_n[24], "open"
#set_property -dict { PACKAGE_PIN B15   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_p[24] }]; #IO_L7P_T1_16 Sch=fmc_la_p[24], "open"
set_property -dict {PACKAGE_PIN E17 IOSTANDARD LVCMOS33} [get_ports FMC_HDMI1_INT1];
set_property -dict {PACKAGE_PIN F16 IOSTANDARD LVCMOS33} [get_ports FMC_HDMI1_SDA];
#set_property -dict { PACKAGE_PIN E18   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_n[26] }]; #IO_L15N_T2_DQS_16 Sch=fmc_la_n[26], "open"
#set_property -dict { PACKAGE_PIN F18   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_p[26] }]; #IO_L15P_T2_DQS_16 Sch=fmc_la_p[26], "open"
#set_property -dict { PACKAGE_PIN A20   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_n[27] }]; #IO_L16N_T2_16 Sch=fmc_la_n[27], "open"
#set_property -dict { PACKAGE_PIN B20   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_p[27] }]; #IO_L16P_T2_16 Sch=fmc_la_p[27], "open"
#set_property -dict { PACKAGE_PIN B13   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_n[28] }]; #IO_L8N_T1_16 Sch=fmc_la_n[28], "open"
#set_property -dict { PACKAGE_PIN C13   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_p[28] }]; #IO_L8P_T1_16 Sch=fmc_la_p[28], "open"
#set_property -dict { PACKAGE_PIN C15   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_n[29] }]; #IO_L3N_T0_DQS_16 Sch=fmc_la_n[29], "open"
#set_property -dict { PACKAGE_PIN C14   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_p[29] }]; #IO_L3P_T0_DQS_16 Sch=fmc_la_p[29], "open"
#set_property -dict { PACKAGE_PIN A14   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_n[30] }]; #IO_L10N_T1_16 Sch=fmc_la_n[30], "open"
#set_property -dict { PACKAGE_PIN A13   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_p[30] }]; #IO_L10P_T1_16 Sch=fmc_la_p[30], "open"
#set_property -dict { PACKAGE_PIN E14   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_n[31] }]; #IO_L4N_T0_16 Sch=fmc_la_n[31], "open"
#set_property -dict { PACKAGE_PIN E13   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_p[31] }]; #IO_L4P_T0_16 Sch=fmc_la_p[31], "open"
#set_property -dict { PACKAGE_PIN A16   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_n[32] }]; #IO_L9N_T1_DQS_16 Sch=fmc_la_n[32], "open"
#set_property -dict { PACKAGE_PIN A15   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_p[32] }]; #IO_L9P_T1_DQS_16 Sch=fmc_la_p[32], "open"
#set_property -dict { PACKAGE_PIN F14   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_n[33] }]; #IO_L1N_T0_16 Sch=fmc_la_n[33], "open"
#set_property -dict { PACKAGE_PIN F13   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_p[33] }]; #IO_L1P_T0_16 Sch=fmc_la_p[33], "open"
create_clock -period 6.600 -name hdmi_rx1_clk -waveform {0.000 3.300} [get_ports FMC_HDMI1_LLC];   #FMC HDMI1 decoder pixel clock.
create_clock -period 6.250 -name hdmi_rx2_clk -waveform {0.000 3.125} [get_ports FMC_HDMI2_CLK_P]; #FMC HDMI2 buffer pixel clock.
set_false_path -from [get_ports FMC_HDMI1_RESETN];

set_false_path -from [get_ports FMC_HDMI2_TX_EN];
set_false_path -from [get_ports FMC_HDMI2_PE_EN];
## ---> FMC

#set_property BEL MMCME2_ADV [get_cells dvi2rgb_i2/U0/TMDS_ClockingX/DVI_ClkGenerator]
set_property LOC MMCME2_ADV_X0Y3 [get_cells dvi2rgb_i2/U0/TMDS_ClockingX/DVI_ClkGenerator];
#set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
#set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
#set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
#connect_debug_port dbg_hub/clk [get_nets clk200]




connect_debug_port u_ila_2/clk [get_nets [list {CRC_reg[31]_i_2_n_0}]]
connect_debug_port u_ila_2/probe0 [get_nets [list {T_Arbiter/CRC32_reg_n_0_[0]}]]
connect_debug_port u_ila_2/probe1 [get_nets [list {T_Arbiter/CRC32_reg_n_0_[1]}]]
connect_debug_port u_ila_2/probe2 [get_nets [list {T_Arbiter/CRC32_reg_n_0_[2]}]]
connect_debug_port u_ila_2/probe3 [get_nets [list {T_Arbiter/CRC32_reg_n_0_[3]}]]
connect_debug_port u_ila_2/probe4 [get_nets [list {T_Arbiter/CRC32_reg_n_0_[4]}]]
connect_debug_port u_ila_2/probe5 [get_nets [list {T_Arbiter/CRC32_reg_n_0_[5]}]]
connect_debug_port u_ila_2/probe6 [get_nets [list {T_Arbiter/CRC32_reg_n_0_[6]}]]
connect_debug_port u_ila_2/probe7 [get_nets [list {T_Arbiter/CRC32_reg_n_0_[7]}]]
connect_debug_port u_ila_2/probe8 [get_nets [list {T_Arbiter/CRC32_reg_n_0_[8]}]]
connect_debug_port u_ila_2/probe9 [get_nets [list {T_Arbiter/CRC32_reg_n_0_[9]}]]
connect_debug_port u_ila_2/probe10 [get_nets [list {T_Arbiter/CRC32_reg_n_0_[10]}]]
connect_debug_port u_ila_2/probe11 [get_nets [list {T_Arbiter/CRC32_reg_n_0_[11]}]]
connect_debug_port u_ila_2/probe12 [get_nets [list {T_Arbiter/CRC32_reg_n_0_[12]}]]
connect_debug_port u_ila_2/probe13 [get_nets [list {T_Arbiter/CRC32_reg_n_0_[13]}]]
connect_debug_port u_ila_2/probe14 [get_nets [list {T_Arbiter/CRC32_reg_n_0_[14]}]]
connect_debug_port u_ila_2/probe15 [get_nets [list {T_Arbiter/CRC32_reg_n_0_[15]}]]
connect_debug_port u_ila_2/probe16 [get_nets [list {T_Arbiter/CRC32_reg_n_0_[16]}]]
connect_debug_port u_ila_2/probe17 [get_nets [list {T_Arbiter/CRC32_reg_n_0_[17]}]]
connect_debug_port u_ila_2/probe18 [get_nets [list {T_Arbiter/CRC32_reg_n_0_[18]}]]
connect_debug_port u_ila_2/probe19 [get_nets [list {T_Arbiter/CRC32_reg_n_0_[19]}]]
connect_debug_port u_ila_2/probe20 [get_nets [list {T_Arbiter/CRC32_reg_n_0_[20]}]]
connect_debug_port u_ila_2/probe21 [get_nets [list {T_Arbiter/CRC32_reg_n_0_[21]}]]
connect_debug_port u_ila_2/probe22 [get_nets [list {T_Arbiter/CRC32_reg_n_0_[22]}]]
connect_debug_port u_ila_2/probe23 [get_nets [list {T_Arbiter/CRC32_reg_n_0_[23]}]]
connect_debug_port u_ila_2/probe24 [get_nets [list {T_Arbiter/CRC32_reg_n_0_[24]}]]
connect_debug_port u_ila_2/probe25 [get_nets [list {T_Arbiter/CRC32_reg_n_0_[25]}]]
connect_debug_port u_ila_2/probe26 [get_nets [list {T_Arbiter/CRC32_reg_n_0_[26]}]]
connect_debug_port u_ila_2/probe27 [get_nets [list {T_Arbiter/CRC32_reg_n_0_[27]}]]
connect_debug_port u_ila_2/probe28 [get_nets [list {T_Arbiter/CRC32_reg_n_0_[28]}]]
connect_debug_port u_ila_2/probe29 [get_nets [list {T_Arbiter/CRC32_reg_n_0_[29]}]]
connect_debug_port u_ila_2/probe30 [get_nets [list {T_Arbiter/CRC32_reg_n_0_[30]}]]
connect_debug_port u_ila_2/probe31 [get_nets [list {T_Arbiter/CRC32_reg_n_0_[31]}]]
connect_debug_port dbg_hub/clk [get_nets CRC_reg[31]_i_2_n_0]

connect_debug_port u_ila_0/probe2 [get_nets [list {arp_d[0]} {arp_d[1]} {arp_d[2]} {arp_d[3]} {arp_d[4]} {arp_d[5]} {arp_d[6]} {arp_d[7]}]]




connect_debug_port u_ila_0/probe1 [get_nets [list {R_Arbiter/ping/csum_cnt[0]} {R_Arbiter/ping/csum_cnt[1]} {R_Arbiter/ping/csum_cnt[2]} {R_Arbiter/ping/csum_cnt[3]} {R_Arbiter/ping/csum_cnt[4]} {R_Arbiter/ping/csum_cnt[5]} {R_Arbiter/ping/csum_cnt[6]} {R_Arbiter/ping/csum_cnt[7]} {R_Arbiter/ping/csum_cnt[8]} {R_Arbiter/ping/csum_cnt[9]}]]
connect_debug_port u_ila_1/probe4 [get_nets [list R_Arbiter/ping_st]]




connect_debug_port u_ila_2/clk [get_nets [list ping_st]]
connect_debug_port dbg_hub/clk [get_nets ping_st]

connect_debug_port u_ila_0/probe1 [get_nets [list {R_Arbiter/ping/RXBUF_i_reg[6]__0[0]} {R_Arbiter/ping/RXBUF_i_reg[6]__0[1]} {R_Arbiter/ping/RXBUF_i_reg[6]__0[2]} {R_Arbiter/ping/RXBUF_i_reg[6]__0[3]} {R_Arbiter/ping/RXBUF_i_reg[6]__0[4]} {R_Arbiter/ping/RXBUF_i_reg[6]__0[5]} {R_Arbiter/ping/RXBUF_i_reg[6]__0[6]} {R_Arbiter/ping/RXBUF_i_reg[6]__0[7]}]]
connect_debug_port u_ila_0/probe2 [get_nets [list {R_Arbiter/ping/RXBUF_i_reg[7]__0[0]} {R_Arbiter/ping/RXBUF_i_reg[7]__0[1]} {R_Arbiter/ping/RXBUF_i_reg[7]__0[2]} {R_Arbiter/ping/RXBUF_i_reg[7]__0[3]} {R_Arbiter/ping/RXBUF_i_reg[7]__0[4]} {R_Arbiter/ping/RXBUF_i_reg[7]__0[5]} {R_Arbiter/ping/RXBUF_i_reg[7]__0[6]} {R_Arbiter/ping/RXBUF_i_reg[7]__0[7]}]]
connect_debug_port u_ila_0/probe3 [get_nets [list {R_Arbiter/ping/RXBUF_i_reg[8]__0[0]} {R_Arbiter/ping/RXBUF_i_reg[8]__0[1]} {R_Arbiter/ping/RXBUF_i_reg[8]__0[2]} {R_Arbiter/ping/RXBUF_i_reg[8]__0[3]} {R_Arbiter/ping/RXBUF_i_reg[8]__0[4]} {R_Arbiter/ping/RXBUF_i_reg[8]__0[5]} {R_Arbiter/ping/RXBUF_i_reg[8]__0[6]} {R_Arbiter/ping/RXBUF_i_reg[8]__0[7]}]]



connect_debug_port u_ila_0/probe1 [get_nets [list {ping/checksum/sum0[0]} {ping/checksum/sum0[1]} {ping/checksum/sum0[2]} {ping/checksum/sum0[3]} {ping/checksum/sum0[4]} {ping/checksum/sum0[5]} {ping/checksum/sum0[6]} {ping/checksum/sum0[7]} {ping/checksum/sum0[8]} {ping/checksum/sum0[9]} {ping/checksum/sum0[10]} {ping/checksum/sum0[11]} {ping/checksum/sum0[12]} {ping/checksum/sum0[13]} {ping/checksum/sum0[14]} {ping/checksum/sum0[15]} {ping/checksum/sum0[16]}]]
connect_debug_port u_ila_1/probe7 [get_nets [list {R_Arbiter/ping_st_reg_n_0_[3]}]]



connect_debug_port u_ila_0/probe5 [get_nets [list {R_Arbiter/ping/data[0]} {R_Arbiter/ping/data[1]} {R_Arbiter/ping/data[2]} {R_Arbiter/ping/data[3]} {R_Arbiter/ping/data[4]} {R_Arbiter/ping/data[5]} {R_Arbiter/ping/data[6]} {R_Arbiter/ping/data[7]}]]


connect_debug_port u_ila_0/probe5 [get_nets [list {UDP_d[0]} {UDP_d[1]} {UDP_d[2]} {UDP_d[3]} {UDP_d[4]} {UDP_d[5]} {UDP_d[6]} {UDP_d[7]} {UDP_d[8]}]]
connect_debug_port u_ila_0/probe6 [get_nets [list {ping/checksum/sum_170[0]} {ping/checksum/sum_170[1]} {ping/checksum/sum_170[2]} {ping/checksum/sum_170[3]} {ping/checksum/sum_170[4]} {ping/checksum/sum_170[5]} {ping/checksum/sum_170[6]} {ping/checksum/sum_170[7]} {ping/checksum/sum_170[8]} {ping/checksum/sum_170[9]} {ping/checksum/sum_170[10]} {ping/checksum/sum_170[11]} {ping/checksum/sum_170[12]} {ping/checksum/sum_170[13]} {ping/checksum/sum_170[14]} {ping/checksum/sum_170[15]} {ping/checksum/sum_170[16]}]]
connect_debug_port u_ila_0/probe9 [get_nets [list {R_Arbiter/ping/RXBUF_i_reg[12]__0[0]} {R_Arbiter/ping/RXBUF_i_reg[12]__0[1]} {R_Arbiter/ping/RXBUF_i_reg[12]__0[2]} {R_Arbiter/ping/RXBUF_i_reg[12]__0[3]} {R_Arbiter/ping/RXBUF_i_reg[12]__0[4]} {R_Arbiter/ping/RXBUF_i_reg[12]__0[5]} {R_Arbiter/ping/RXBUF_i_reg[12]__0[6]} {R_Arbiter/ping/RXBUF_i_reg[12]__0[7]}]]
connect_debug_port u_ila_0/probe10 [get_nets [list {R_Arbiter/ping/RXBUF_i_reg[13]__0[0]} {R_Arbiter/ping/RXBUF_i_reg[13]__0[1]} {R_Arbiter/ping/RXBUF_i_reg[13]__0[2]} {R_Arbiter/ping/RXBUF_i_reg[13]__0[3]} {R_Arbiter/ping/RXBUF_i_reg[13]__0[4]} {R_Arbiter/ping/RXBUF_i_reg[13]__0[5]} {R_Arbiter/ping/RXBUF_i_reg[13]__0[6]} {R_Arbiter/ping/RXBUF_i_reg[13]__0[7]}]]
connect_debug_port u_ila_0/probe11 [get_nets [list arp_tx]]
connect_debug_port u_ila_0/probe16 [get_nets [list ping_tx]]


connect_debug_port u_ila_0/probe0 [get_nets [list {R_Arbiter/UDP_reply/DstPort[0]} {R_Arbiter/UDP_reply/DstPort[1]} {R_Arbiter/UDP_reply/DstPort[2]} {R_Arbiter/UDP_reply/DstPort[3]} {R_Arbiter/UDP_reply/DstPort[4]} {R_Arbiter/UDP_reply/DstPort[5]} {R_Arbiter/UDP_reply/DstPort[6]} {R_Arbiter/UDP_reply/DstPort[7]} {R_Arbiter/UDP_reply/DstPort[8]} {R_Arbiter/UDP_reply/DstPort[9]} {R_Arbiter/UDP_reply/DstPort[10]} {R_Arbiter/UDP_reply/DstPort[11]} {R_Arbiter/UDP_reply/DstPort[12]} {R_Arbiter/UDP_reply/DstPort[13]} {R_Arbiter/UDP_reply/DstPort[14]} {R_Arbiter/UDP_reply/DstPort[15]}]]
connect_debug_port u_ila_0/probe1 [get_nets [list {R_Arbiter/UDP_reply/csum[0]} {R_Arbiter/UDP_reply/csum[1]} {R_Arbiter/UDP_reply/csum[2]} {R_Arbiter/UDP_reply/csum[3]} {R_Arbiter/UDP_reply/csum[4]} {R_Arbiter/UDP_reply/csum[5]} {R_Arbiter/UDP_reply/csum[6]} {R_Arbiter/UDP_reply/csum[7]} {R_Arbiter/UDP_reply/csum[8]} {R_Arbiter/UDP_reply/csum[9]} {R_Arbiter/UDP_reply/csum[10]} {R_Arbiter/UDP_reply/csum[11]} {R_Arbiter/UDP_reply/csum[12]} {R_Arbiter/UDP_reply/csum[13]} {R_Arbiter/UDP_reply/csum[14]} {R_Arbiter/UDP_reply/csum[15]}]]
connect_debug_port u_ila_0/probe2 [get_nets [list {R_Arbiter/UDP_reply/csum_cnt[0]} {R_Arbiter/UDP_reply/csum_cnt[1]} {R_Arbiter/UDP_reply/csum_cnt[2]} {R_Arbiter/UDP_reply/csum_cnt[3]} {R_Arbiter/UDP_reply/csum_cnt[4]} {R_Arbiter/UDP_reply/csum_cnt[5]} {R_Arbiter/UDP_reply/csum_cnt[6]} {R_Arbiter/UDP_reply/csum_cnt[7]} {R_Arbiter/UDP_reply/csum_cnt[8]} {R_Arbiter/UDP_reply/csum_cnt[9]}]]
connect_debug_port u_ila_0/probe3 [get_nets [list {R_Arbiter/UDP_reply/st[0]} {R_Arbiter/UDP_reply/st[1]} {R_Arbiter/UDP_reply/st[2]} {R_Arbiter/UDP_reply/st[3]} {R_Arbiter/UDP_reply/st[4]} {R_Arbiter/UDP_reply/st[5]} {R_Arbiter/UDP_reply/st[6]} {R_Arbiter/UDP_reply/st[7]}]]
connect_debug_port u_ila_0/probe9 [get_nets [list {R_Arbiter/UDP_d[0]} {R_Arbiter/UDP_d[1]} {R_Arbiter/UDP_d[2]} {R_Arbiter/UDP_d[3]} {R_Arbiter/UDP_d[4]} {R_Arbiter/UDP_d[5]} {R_Arbiter/UDP_d[6]} {R_Arbiter/UDP_d[7]}]]
connect_debug_port u_ila_0/probe14 [get_nets [list R_Arbiter/UDP_reply/csum_ok]]
connect_debug_port u_ila_1/probe11 [get_nets [list {R_Arbiter/UDP_st_reg_n_0_[2]}]]


connect_debug_port u_ila_1/probe6 [get_nets [list {R_Arbiter/imdata[0]} {R_Arbiter/imdata[1]} {R_Arbiter/imdata[2]} {R_Arbiter/imdata[3]} {R_Arbiter/imdata[4]} {R_Arbiter/imdata[5]} {R_Arbiter/imdata[6]} {R_Arbiter/imdata[7]}]]

create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 2048 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list clk125]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 16 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {R_Arbiter/ping/checksum/buffer[0]} {R_Arbiter/ping/checksum/buffer[1]} {R_Arbiter/ping/checksum/buffer[2]} {R_Arbiter/ping/checksum/buffer[3]} {R_Arbiter/ping/checksum/buffer[4]} {R_Arbiter/ping/checksum/buffer[5]} {R_Arbiter/ping/checksum/buffer[6]} {R_Arbiter/ping/checksum/buffer[7]} {R_Arbiter/ping/checksum/buffer[8]} {R_Arbiter/ping/checksum/buffer[9]} {R_Arbiter/ping/checksum/buffer[10]} {R_Arbiter/ping/checksum/buffer[11]} {R_Arbiter/ping/checksum/buffer[12]} {R_Arbiter/ping/checksum/buffer[13]} {R_Arbiter/ping/checksum/buffer[14]} {R_Arbiter/ping/checksum/buffer[15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 16 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {R_Arbiter/ping/csum[0]} {R_Arbiter/ping/csum[1]} {R_Arbiter/ping/csum[2]} {R_Arbiter/ping/csum[3]} {R_Arbiter/ping/csum[4]} {R_Arbiter/ping/csum[5]} {R_Arbiter/ping/csum[6]} {R_Arbiter/ping/csum[7]} {R_Arbiter/ping/csum[8]} {R_Arbiter/ping/csum[9]} {R_Arbiter/ping/csum[10]} {R_Arbiter/ping/csum[11]} {R_Arbiter/ping/csum[12]} {R_Arbiter/ping/csum[13]} {R_Arbiter/ping/csum[14]} {R_Arbiter/ping/csum[15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 10 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list {R_Arbiter/ping/csum_cnt[0]} {R_Arbiter/ping/csum_cnt[1]} {R_Arbiter/ping/csum_cnt[2]} {R_Arbiter/ping/csum_cnt[3]} {R_Arbiter/ping/csum_cnt[4]} {R_Arbiter/ping/csum_cnt[5]} {R_Arbiter/ping/csum_cnt[6]} {R_Arbiter/ping/csum_cnt[7]} {R_Arbiter/ping/csum_cnt[8]} {R_Arbiter/ping/csum_cnt[9]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
set_property port_width 4 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list {R_Arbiter/ping/st[0]} {R_Arbiter/ping/st[1]} {R_Arbiter/ping/st[2]} {R_Arbiter/ping/st[3]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
set_property port_width 10 [get_debug_ports u_ila_0/probe4]
connect_debug_port u_ila_0/probe4 [get_nets [list {R_Arbiter/ping/tx_cnt[0]} {R_Arbiter/ping/tx_cnt[1]} {R_Arbiter/ping/tx_cnt[2]} {R_Arbiter/ping/tx_cnt[3]} {R_Arbiter/ping/tx_cnt[4]} {R_Arbiter/ping/tx_cnt[5]} {R_Arbiter/ping/tx_cnt[6]} {R_Arbiter/ping/tx_cnt[7]} {R_Arbiter/ping/tx_cnt[8]} {R_Arbiter/ping/tx_cnt[9]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
set_property port_width 17 [get_debug_ports u_ila_0/probe5]
connect_debug_port u_ila_0/probe5 [get_nets [list {UDP/udp_checksum/sum_17[0]} {UDP/udp_checksum/sum_17[1]} {UDP/udp_checksum/sum_17[2]} {UDP/udp_checksum/sum_17[3]} {UDP/udp_checksum/sum_17[4]} {UDP/udp_checksum/sum_17[5]} {UDP/udp_checksum/sum_17[6]} {UDP/udp_checksum/sum_17[7]} {UDP/udp_checksum/sum_17[8]} {UDP/udp_checksum/sum_17[9]} {UDP/udp_checksum/sum_17[10]} {UDP/udp_checksum/sum_17[11]} {UDP/udp_checksum/sum_17[12]} {UDP/udp_checksum/sum_17[13]} {UDP/udp_checksum/sum_17[14]} {UDP/udp_checksum/sum_17[15]} {UDP/udp_checksum/sum_17[16]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
set_property port_width 8 [get_debug_ports u_ila_0/probe6]
connect_debug_port u_ila_0/probe6 [get_nets [list {gmii_txd[0]} {gmii_txd[1]} {gmii_txd[2]} {gmii_txd[3]} {gmii_txd[4]} {gmii_txd[5]} {gmii_txd[6]} {gmii_txd[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe7]
set_property port_width 1 [get_debug_ports u_ila_0/probe7]
connect_debug_port u_ila_0/probe7 [get_nets [list BTN_C_IBUF]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe8]
set_property port_width 1 [get_debug_ports u_ila_0/probe8]
connect_debug_port u_ila_0/probe8 [get_nets [list R_Arbiter/ping/csum_ok]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe9]
set_property port_width 1 [get_debug_ports u_ila_0/probe9]
connect_debug_port u_ila_0/probe9 [get_nets [list R_Arbiter/ping/checksum/d_clk]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe10]
set_property port_width 1 [get_debug_ports u_ila_0/probe10]
connect_debug_port u_ila_0/probe10 [get_nets [list R_Arbiter/ping/data_en]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe11]
set_property port_width 1 [get_debug_ports u_ila_0/probe11]
connect_debug_port u_ila_0/probe11 [get_nets [list gmii_txctl]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe12]
set_property port_width 1 [get_debug_ports u_ila_0/probe12]
connect_debug_port u_ila_0/probe12 [get_nets [list R_Arbiter/ARP/start_tx_reg_n_0]]
create_debug_core u_ila_1 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_1]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_1]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_1]
set_property C_DATA_DEPTH 2048 [get_debug_cores u_ila_1]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_1]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_1]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_1]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_1]
set_property port_width 1 [get_debug_ports u_ila_1/clk]
connect_debug_port u_ila_1/clk [get_nets [list eth_rxck_IBUF_BUFG]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe0]
set_property port_width 8 [get_debug_ports u_ila_1/probe0]
connect_debug_port u_ila_1/probe0 [get_nets [list {R_Arbiter/recv_image/st[0]} {R_Arbiter/recv_image/st[1]} {R_Arbiter/recv_image/st[2]} {R_Arbiter/recv_image/st[3]} {R_Arbiter/recv_image/st[4]} {R_Arbiter/recv_image/st[5]} {R_Arbiter/recv_image/st[6]} {R_Arbiter/recv_image/st[7]}]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe1]
set_property port_width 8 [get_debug_ports u_ila_1/probe1]
connect_debug_port u_ila_1/probe1 [get_nets [list {gmii_rxd[0]} {gmii_rxd[1]} {gmii_rxd[2]} {gmii_rxd[3]} {gmii_rxd[4]} {gmii_rxd[5]} {gmii_rxd[6]} {gmii_rxd[7]}]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe2]
set_property port_width 32 [get_debug_ports u_ila_1/probe2]
connect_debug_port u_ila_1/probe2 [get_nets [list {R_Arbiter/DstIP[0]} {R_Arbiter/DstIP[1]} {R_Arbiter/DstIP[2]} {R_Arbiter/DstIP[3]} {R_Arbiter/DstIP[4]} {R_Arbiter/DstIP[5]} {R_Arbiter/DstIP[6]} {R_Arbiter/DstIP[7]} {R_Arbiter/DstIP[8]} {R_Arbiter/DstIP[9]} {R_Arbiter/DstIP[10]} {R_Arbiter/DstIP[11]} {R_Arbiter/DstIP[12]} {R_Arbiter/DstIP[13]} {R_Arbiter/DstIP[14]} {R_Arbiter/DstIP[15]} {R_Arbiter/DstIP[16]} {R_Arbiter/DstIP[17]} {R_Arbiter/DstIP[18]} {R_Arbiter/DstIP[19]} {R_Arbiter/DstIP[20]} {R_Arbiter/DstIP[21]} {R_Arbiter/DstIP[22]} {R_Arbiter/DstIP[23]} {R_Arbiter/DstIP[24]} {R_Arbiter/DstIP[25]} {R_Arbiter/DstIP[26]} {R_Arbiter/DstIP[27]} {R_Arbiter/DstIP[28]} {R_Arbiter/DstIP[29]} {R_Arbiter/DstIP[30]} {R_Arbiter/DstIP[31]}]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe3]
set_property port_width 48 [get_debug_ports u_ila_1/probe3]
connect_debug_port u_ila_1/probe3 [get_nets [list {R_Arbiter/DstMAC[0]} {R_Arbiter/DstMAC[1]} {R_Arbiter/DstMAC[2]} {R_Arbiter/DstMAC[3]} {R_Arbiter/DstMAC[4]} {R_Arbiter/DstMAC[5]} {R_Arbiter/DstMAC[6]} {R_Arbiter/DstMAC[7]} {R_Arbiter/DstMAC[8]} {R_Arbiter/DstMAC[9]} {R_Arbiter/DstMAC[10]} {R_Arbiter/DstMAC[11]} {R_Arbiter/DstMAC[12]} {R_Arbiter/DstMAC[13]} {R_Arbiter/DstMAC[14]} {R_Arbiter/DstMAC[15]} {R_Arbiter/DstMAC[16]} {R_Arbiter/DstMAC[17]} {R_Arbiter/DstMAC[18]} {R_Arbiter/DstMAC[19]} {R_Arbiter/DstMAC[20]} {R_Arbiter/DstMAC[21]} {R_Arbiter/DstMAC[22]} {R_Arbiter/DstMAC[23]} {R_Arbiter/DstMAC[24]} {R_Arbiter/DstMAC[25]} {R_Arbiter/DstMAC[26]} {R_Arbiter/DstMAC[27]} {R_Arbiter/DstMAC[28]} {R_Arbiter/DstMAC[29]} {R_Arbiter/DstMAC[30]} {R_Arbiter/DstMAC[31]} {R_Arbiter/DstMAC[32]} {R_Arbiter/DstMAC[33]} {R_Arbiter/DstMAC[34]} {R_Arbiter/DstMAC[35]} {R_Arbiter/DstMAC[36]} {R_Arbiter/DstMAC[37]} {R_Arbiter/DstMAC[38]} {R_Arbiter/DstMAC[39]} {R_Arbiter/DstMAC[40]} {R_Arbiter/DstMAC[41]} {R_Arbiter/DstMAC[42]} {R_Arbiter/DstMAC[43]} {R_Arbiter/DstMAC[44]} {R_Arbiter/DstMAC[45]} {R_Arbiter/DstMAC[46]} {R_Arbiter/DstMAC[47]}]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe4]
set_property port_width 48 [get_debug_ports u_ila_1/probe4]
connect_debug_port u_ila_1/probe4 [get_nets [list {R_Arbiter/host_MAC[0]} {R_Arbiter/host_MAC[1]} {R_Arbiter/host_MAC[2]} {R_Arbiter/host_MAC[3]} {R_Arbiter/host_MAC[4]} {R_Arbiter/host_MAC[5]} {R_Arbiter/host_MAC[6]} {R_Arbiter/host_MAC[7]} {R_Arbiter/host_MAC[8]} {R_Arbiter/host_MAC[9]} {R_Arbiter/host_MAC[10]} {R_Arbiter/host_MAC[11]} {R_Arbiter/host_MAC[12]} {R_Arbiter/host_MAC[13]} {R_Arbiter/host_MAC[14]} {R_Arbiter/host_MAC[15]} {R_Arbiter/host_MAC[16]} {R_Arbiter/host_MAC[17]} {R_Arbiter/host_MAC[18]} {R_Arbiter/host_MAC[19]} {R_Arbiter/host_MAC[20]} {R_Arbiter/host_MAC[21]} {R_Arbiter/host_MAC[22]} {R_Arbiter/host_MAC[23]} {R_Arbiter/host_MAC[24]} {R_Arbiter/host_MAC[25]} {R_Arbiter/host_MAC[26]} {R_Arbiter/host_MAC[27]} {R_Arbiter/host_MAC[28]} {R_Arbiter/host_MAC[29]} {R_Arbiter/host_MAC[30]} {R_Arbiter/host_MAC[31]} {R_Arbiter/host_MAC[32]} {R_Arbiter/host_MAC[33]} {R_Arbiter/host_MAC[34]} {R_Arbiter/host_MAC[35]} {R_Arbiter/host_MAC[36]} {R_Arbiter/host_MAC[37]} {R_Arbiter/host_MAC[38]} {R_Arbiter/host_MAC[39]} {R_Arbiter/host_MAC[40]} {R_Arbiter/host_MAC[41]} {R_Arbiter/host_MAC[42]} {R_Arbiter/host_MAC[43]} {R_Arbiter/host_MAC[44]} {R_Arbiter/host_MAC[45]} {R_Arbiter/host_MAC[46]} {R_Arbiter/host_MAC[47]}]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe5]
set_property port_width 32 [get_debug_ports u_ila_1/probe5]
connect_debug_port u_ila_1/probe5 [get_nets [list {R_Arbiter/r_crc[0]} {R_Arbiter/r_crc[1]} {R_Arbiter/r_crc[2]} {R_Arbiter/r_crc[3]} {R_Arbiter/r_crc[4]} {R_Arbiter/r_crc[5]} {R_Arbiter/r_crc[6]} {R_Arbiter/r_crc[7]} {R_Arbiter/r_crc[8]} {R_Arbiter/r_crc[9]} {R_Arbiter/r_crc[10]} {R_Arbiter/r_crc[11]} {R_Arbiter/r_crc[12]} {R_Arbiter/r_crc[13]} {R_Arbiter/r_crc[14]} {R_Arbiter/r_crc[15]} {R_Arbiter/r_crc[16]} {R_Arbiter/r_crc[17]} {R_Arbiter/r_crc[18]} {R_Arbiter/r_crc[19]} {R_Arbiter/r_crc[20]} {R_Arbiter/r_crc[21]} {R_Arbiter/r_crc[22]} {R_Arbiter/r_crc[23]} {R_Arbiter/r_crc[24]} {R_Arbiter/r_crc[25]} {R_Arbiter/r_crc[26]} {R_Arbiter/r_crc[27]} {R_Arbiter/r_crc[28]} {R_Arbiter/r_crc[29]} {R_Arbiter/r_crc[30]} {R_Arbiter/r_crc[31]}]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe6]
set_property port_width 10 [get_debug_ports u_ila_1/probe6]
connect_debug_port u_ila_1/probe6 [get_nets [list {R_Arbiter/rx_cnt[0]} {R_Arbiter/rx_cnt[1]} {R_Arbiter/rx_cnt[2]} {R_Arbiter/rx_cnt[3]} {R_Arbiter/rx_cnt[4]} {R_Arbiter/rx_cnt[5]} {R_Arbiter/rx_cnt[6]} {R_Arbiter/rx_cnt[7]} {R_Arbiter/rx_cnt[8]} {R_Arbiter/rx_cnt[9]}]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe7]
set_property port_width 8 [get_debug_ports u_ila_1/probe7]
connect_debug_port u_ila_1/probe7 [get_nets [list {R_Arbiter/st[0]} {R_Arbiter/st[1]} {R_Arbiter/st[2]} {R_Arbiter/st[3]} {R_Arbiter/st[4]} {R_Arbiter/st[5]} {R_Arbiter/st[6]} {R_Arbiter/st[7]}]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe8]
set_property port_width 1 [get_debug_ports u_ila_1/probe8]
connect_debug_port u_ila_1/probe8 [get_nets [list {R_Arbiter/arp_st_reg_n_0_[0]}]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe9]
set_property port_width 1 [get_debug_ports u_ila_1/probe9]
connect_debug_port u_ila_1/probe9 [get_nets [list R_Arbiter/crc_ok_reg_n_0]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe10]
set_property port_width 1 [get_debug_ports u_ila_1/probe10]
connect_debug_port u_ila_1/probe10 [get_nets [list gmii_rxctl]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe11]
set_property port_width 1 [get_debug_ports u_ila_1/probe11]
connect_debug_port u_ila_1/probe11 [get_nets [list {R_Arbiter/ping_st_reg_n_0_[2]}]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe12]
set_property port_width 1 [get_debug_ports u_ila_1/probe12]
connect_debug_port u_ila_1/probe12 [get_nets [list R_Arbiter/recvend]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets eth_rxck_IBUF_BUFG]
