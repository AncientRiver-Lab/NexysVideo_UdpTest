# 
# Synthesis run script generated by Vivado
# 

proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
set_param xicom.use_bs_reader 1
set_param tcl.collectionResultDisplayLimit 0
create_project -in_memory -part xc7a200tsbg484-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir /home/moikawa/proj_Mitsuhashi/NexysVideo_UdpTest/UDP.cache/wt [current_project]
set_property parent.project_path /home/moikawa/proj_Mitsuhashi/NexysVideo_UdpTest/UDP.xpr [current_project]
set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property board_part digilentinc.com:nexys_video:part0:1.1 [current_project]
set_property ip_output_repo /home/moikawa/proj_Mitsuhashi/NexysVideo_UdpTest/UDP.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
set_property include_dirs /home/moikawa/proj_Mitsuhashi/NexysVideo_UdpTest/UDP.srcs/sources_1 [current_fileset]
read_verilog -library xil_defaultlib -sv {
  /home/moikawa/proj_Mitsuhashi/NexysVideo_UdpTest/UDP.srcs/sources_1/ARP.sv
  /home/moikawa/proj_Mitsuhashi/NexysVideo_UdpTest/UDP.srcs/sources_1/Arbiter.sv
  /home/moikawa/proj_Mitsuhashi/NexysVideo_UdpTest/UDP.srcs/sources_1/CRC_ge.sv
  /home/moikawa/proj_Mitsuhashi/NexysVideo_UdpTest/UDP.srcs/sources_1/GMII2RGMII.sv
  /home/moikawa/proj_Mitsuhashi/NexysVideo_UdpTest/UDP.srcs/sources_1/RGMII2GMII.sv
  /home/moikawa/proj_Mitsuhashi/NexysVideo_UdpTest/UDP.srcs/sources_1/T_Arbiter.sv
  /home/moikawa/proj_Mitsuhashi/NexysVideo_UdpTest/UDP.srcs/sources_1/checksum.sv
  /home/moikawa/proj_Mitsuhashi/NexysVideo_UdpTest/UDP.srcs/sources_1/ping.sv
  /home/moikawa/proj_Mitsuhashi/NexysVideo_UdpTest/UDP.srcs/sources_1/recv_image.sv
  /home/moikawa/proj_Mitsuhashi/NexysVideo_UdpTest/UDP.srcs/sources_1/trans_image.sv
  /home/moikawa/proj_Mitsuhashi/NexysVideo_UdpTest/UDP.srcs/sources_1/TOP.sv
}
read_verilog -library xil_defaultlib /home/moikawa/proj_Mitsuhashi/NexysVideo_UdpTest/UDP.srcs/sources_1/RSTGEN.v
read_ip -quiet /home/moikawa/proj_Mitsuhashi/NexysVideo_UdpTest/UDP.srcs/sources_1/ip/image_RAM/image_RAM.xci
set_property used_in_implementation false [get_files -all /home/moikawa/proj_Mitsuhashi/NexysVideo_UdpTest/UDP.srcs/sources_1/ip/image_RAM/image_RAM_ooc.xdc]

read_ip -quiet /home/moikawa/proj_Mitsuhashi/NexysVideo_UdpTest/UDP.srcs/sources_1/ip/CLKGEN/CLKGEN.xci
set_property used_in_implementation false [get_files -all /home/moikawa/proj_Mitsuhashi/NexysVideo_UdpTest/UDP.srcs/sources_1/ip/CLKGEN/CLKGEN_board.xdc]
set_property used_in_implementation false [get_files -all /home/moikawa/proj_Mitsuhashi/NexysVideo_UdpTest/UDP.srcs/sources_1/ip/CLKGEN/CLKGEN.xdc]
set_property used_in_implementation false [get_files -all /home/moikawa/proj_Mitsuhashi/NexysVideo_UdpTest/UDP.srcs/sources_1/ip/CLKGEN/CLKGEN_late.xdc]
set_property used_in_implementation false [get_files -all /home/moikawa/proj_Mitsuhashi/NexysVideo_UdpTest/UDP.srcs/sources_1/ip/CLKGEN/CLKGEN_ooc.xdc]

read_ip -quiet /home/moikawa/proj_Mitsuhashi/NexysVideo_UdpTest/UDP.srcs/sources_1/ip/queue/queue.xci
set_property used_in_implementation false [get_files -all /home/moikawa/proj_Mitsuhashi/NexysVideo_UdpTest/UDP.srcs/sources_1/ip/queue/queue.xdc]
set_property used_in_implementation false [get_files -all /home/moikawa/proj_Mitsuhashi/NexysVideo_UdpTest/UDP.srcs/sources_1/ip/queue/queue_clocks.xdc]
set_property used_in_implementation false [get_files -all /home/moikawa/proj_Mitsuhashi/NexysVideo_UdpTest/UDP.srcs/sources_1/ip/queue/queue_ooc.xdc]

read_ip -quiet /home/moikawa/proj_Mitsuhashi/NexysVideo_UdpTest/UDP.srcs/sources_1/ip/ETH_CLKGEN/ETH_CLKGEN.xci
set_property used_in_implementation false [get_files -all /home/moikawa/proj_Mitsuhashi/NexysVideo_UdpTest/UDP.srcs/sources_1/ip/ETH_CLKGEN/ETH_CLKGEN_board.xdc]
set_property used_in_implementation false [get_files -all /home/moikawa/proj_Mitsuhashi/NexysVideo_UdpTest/UDP.srcs/sources_1/ip/ETH_CLKGEN/ETH_CLKGEN.xdc]
set_property used_in_implementation false [get_files -all /home/moikawa/proj_Mitsuhashi/NexysVideo_UdpTest/UDP.srcs/sources_1/ip/ETH_CLKGEN/ETH_CLKGEN_ooc.xdc]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc /home/moikawa/proj_Mitsuhashi/NexysVideo_UdpTest/UDP.srcs/constrs_1/NexysVideo_20181221.xdc
set_property used_in_implementation false [get_files /home/moikawa/proj_Mitsuhashi/NexysVideo_UdpTest/UDP.srcs/constrs_1/NexysVideo_20181221.xdc]

read_xdc /home/moikawa/proj_Mitsuhashi/NexysVideo_UdpTest/UDP.srcs/constrs_1/new/etc.xdc
set_property used_in_implementation false [get_files /home/moikawa/proj_Mitsuhashi/NexysVideo_UdpTest/UDP.srcs/constrs_1/new/etc.xdc]

read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]
set_param ips.enableIPCacheLiteLoad 0
close [open __synthesis_is_running__ w]

synth_design -top TOP -part xc7a200tsbg484-1 -flatten_hierarchy none


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef TOP.dcp
create_report "synth_2_synth_report_utilization_0" "report_utilization -file TOP_utilization_synth.rpt -pb TOP_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]