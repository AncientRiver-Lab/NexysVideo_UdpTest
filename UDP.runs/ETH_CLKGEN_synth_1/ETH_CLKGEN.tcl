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
set_param project.vivado.isBlockSynthRun true
set_msg_config -msgmgr_mode ooc_run
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
read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]
set_param ips.enableIPCacheLiteLoad 0

set cached_ip [config_ip_cache -export -no_bom -use_project_ipc -dir /home/moikawa/proj_Mitsuhashi/NexysVideo_UdpTest/UDP.runs/ETH_CLKGEN_synth_1 -new_name ETH_CLKGEN -ip [get_ips ETH_CLKGEN]]

if { $cached_ip eq {} } {
close [open __synthesis_is_running__ w]

synth_design -top ETH_CLKGEN -part xc7a200tsbg484-1 -mode out_of_context

#---------------------------------------------------------
# Generate Checkpoint/Stub/Simulation Files For IP Cache
#---------------------------------------------------------
# disable binary constraint mode for IPCache checkpoints
set_param constraints.enableBinaryConstraints false

catch {
 write_checkpoint -force -noxdef -rename_prefix ETH_CLKGEN_ ETH_CLKGEN.dcp

 set ipCachedFiles {}
 write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ ETH_CLKGEN_stub.v
 lappend ipCachedFiles ETH_CLKGEN_stub.v

 write_vhdl -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ ETH_CLKGEN_stub.vhdl
 lappend ipCachedFiles ETH_CLKGEN_stub.vhdl

 write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ ETH_CLKGEN_sim_netlist.v
 lappend ipCachedFiles ETH_CLKGEN_sim_netlist.v

 write_vhdl -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ ETH_CLKGEN_sim_netlist.vhdl
 lappend ipCachedFiles ETH_CLKGEN_sim_netlist.vhdl

 config_ip_cache -add -dcp ETH_CLKGEN.dcp -move_files $ipCachedFiles -use_project_ipc -ip [get_ips ETH_CLKGEN]
}

rename_ref -prefix_all ETH_CLKGEN_

# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef ETH_CLKGEN.dcp
create_report "ETH_CLKGEN_synth_1_synth_report_utilization_0" "report_utilization -file ETH_CLKGEN_utilization_synth.rpt -pb ETH_CLKGEN_utilization_synth.pb"

if { [catch {
  file copy -force /home/moikawa/proj_Mitsuhashi/NexysVideo_UdpTest/UDP.runs/ETH_CLKGEN_synth_1/ETH_CLKGEN.dcp /home/moikawa/proj_Mitsuhashi/NexysVideo_UdpTest/UDP.srcs/sources_1/ip/ETH_CLKGEN/ETH_CLKGEN.dcp
} _RESULT ] } { 
  send_msg_id runtcl-3 error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
  error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
}

if { [catch {
  write_verilog -force -mode synth_stub /home/moikawa/proj_Mitsuhashi/NexysVideo_UdpTest/UDP.srcs/sources_1/ip/ETH_CLKGEN/ETH_CLKGEN_stub.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a Verilog synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  write_vhdl -force -mode synth_stub /home/moikawa/proj_Mitsuhashi/NexysVideo_UdpTest/UDP.srcs/sources_1/ip/ETH_CLKGEN/ETH_CLKGEN_stub.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a VHDL synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  write_verilog -force -mode funcsim /home/moikawa/proj_Mitsuhashi/NexysVideo_UdpTest/UDP.srcs/sources_1/ip/ETH_CLKGEN/ETH_CLKGEN_sim_netlist.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the Verilog functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}

if { [catch {
  write_vhdl -force -mode funcsim /home/moikawa/proj_Mitsuhashi/NexysVideo_UdpTest/UDP.srcs/sources_1/ip/ETH_CLKGEN/ETH_CLKGEN_sim_netlist.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the VHDL functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}


} else {


if { [catch {
  file copy -force /home/moikawa/proj_Mitsuhashi/NexysVideo_UdpTest/UDP.runs/ETH_CLKGEN_synth_1/ETH_CLKGEN.dcp /home/moikawa/proj_Mitsuhashi/NexysVideo_UdpTest/UDP.srcs/sources_1/ip/ETH_CLKGEN/ETH_CLKGEN.dcp
} _RESULT ] } { 
  send_msg_id runtcl-3 error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
  error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
}

if { [catch {
  file rename -force /home/moikawa/proj_Mitsuhashi/NexysVideo_UdpTest/UDP.runs/ETH_CLKGEN_synth_1/ETH_CLKGEN_stub.v /home/moikawa/proj_Mitsuhashi/NexysVideo_UdpTest/UDP.srcs/sources_1/ip/ETH_CLKGEN/ETH_CLKGEN_stub.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a Verilog synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  file rename -force /home/moikawa/proj_Mitsuhashi/NexysVideo_UdpTest/UDP.runs/ETH_CLKGEN_synth_1/ETH_CLKGEN_stub.vhdl /home/moikawa/proj_Mitsuhashi/NexysVideo_UdpTest/UDP.srcs/sources_1/ip/ETH_CLKGEN/ETH_CLKGEN_stub.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a VHDL synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  file rename -force /home/moikawa/proj_Mitsuhashi/NexysVideo_UdpTest/UDP.runs/ETH_CLKGEN_synth_1/ETH_CLKGEN_sim_netlist.v /home/moikawa/proj_Mitsuhashi/NexysVideo_UdpTest/UDP.srcs/sources_1/ip/ETH_CLKGEN/ETH_CLKGEN_sim_netlist.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the Verilog functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}

if { [catch {
  file rename -force /home/moikawa/proj_Mitsuhashi/NexysVideo_UdpTest/UDP.runs/ETH_CLKGEN_synth_1/ETH_CLKGEN_sim_netlist.vhdl /home/moikawa/proj_Mitsuhashi/NexysVideo_UdpTest/UDP.srcs/sources_1/ip/ETH_CLKGEN/ETH_CLKGEN_sim_netlist.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the VHDL functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}

}; # end if cached_ip 

if {[file isdir /home/moikawa/proj_Mitsuhashi/NexysVideo_UdpTest/UDP.ip_user_files/ip/ETH_CLKGEN]} {
  catch { 
    file copy -force /home/moikawa/proj_Mitsuhashi/NexysVideo_UdpTest/UDP.srcs/sources_1/ip/ETH_CLKGEN/ETH_CLKGEN_stub.v /home/moikawa/proj_Mitsuhashi/NexysVideo_UdpTest/UDP.ip_user_files/ip/ETH_CLKGEN
  }
}

if {[file isdir /home/moikawa/proj_Mitsuhashi/NexysVideo_UdpTest/UDP.ip_user_files/ip/ETH_CLKGEN]} {
  catch { 
    file copy -force /home/moikawa/proj_Mitsuhashi/NexysVideo_UdpTest/UDP.srcs/sources_1/ip/ETH_CLKGEN/ETH_CLKGEN_stub.vhdl /home/moikawa/proj_Mitsuhashi/NexysVideo_UdpTest/UDP.ip_user_files/ip/ETH_CLKGEN
  }
}
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
