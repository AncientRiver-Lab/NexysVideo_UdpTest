vlib work
vlib activehdl

vlib activehdl/xilinx_vip
vlib activehdl/xil_defaultlib
vlib activehdl/xpm

vmap xilinx_vip activehdl/xilinx_vip
vmap xil_defaultlib activehdl/xil_defaultlib
vmap xpm activehdl/xpm

vlog -work xilinx_vip  -sv2k12 "+incdir+../../../../UDP.srcs/sources_1/ip/CLKGEN" "+incdir+/home/Xilinx/Vivado/2018.1/data/xilinx_vip/include" "+incdir+/home/Xilinx/Vivado/2018.1/data/xilinx_vip/include" \
"/home/Xilinx/Vivado/2018.1/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
"/home/Xilinx/Vivado/2018.1/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
"/home/Xilinx/Vivado/2018.1/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
"/home/Xilinx/Vivado/2018.1/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
"/home/Xilinx/Vivado/2018.1/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
"/home/Xilinx/Vivado/2018.1/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
"/home/Xilinx/Vivado/2018.1/data/xilinx_vip/hdl/axi_vip_if.sv" \
"/home/Xilinx/Vivado/2018.1/data/xilinx_vip/hdl/clk_vip_if.sv" \
"/home/Xilinx/Vivado/2018.1/data/xilinx_vip/hdl/rst_vip_if.sv" \

vlog -work xil_defaultlib  -sv2k12 "+incdir+../../../../UDP.srcs/sources_1/ip/CLKGEN" "+incdir+/home/Xilinx/Vivado/2018.1/data/xilinx_vip/include" "+incdir+../../../../UDP.srcs/sources_1/ip/CLKGEN" "+incdir+/home/Xilinx/Vivado/2018.1/data/xilinx_vip/include" \
"/home/Xilinx/Vivado/2018.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"/home/Xilinx/Vivado/2018.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93 \
"/home/Xilinx/Vivado/2018.1/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../UDP.srcs/sources_1/ip/CLKGEN" "+incdir+/home/Xilinx/Vivado/2018.1/data/xilinx_vip/include" "+incdir+../../../../UDP.srcs/sources_1/ip/CLKGEN" "+incdir+/home/Xilinx/Vivado/2018.1/data/xilinx_vip/include" \
"../../../../UDP.srcs/sources_1/ip/CLKGEN/CLKGEN_sim_netlist.v" \

vlog -work xil_defaultlib \
"glbl.v"

