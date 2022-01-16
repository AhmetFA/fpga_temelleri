set test_path [pwd]
create_project vivado_prj -part xc7a100tcsg324-1 -force
##Generate IP files
create_ip -name fifo_generator -vendor xilinx.com -library ip -version 13.2 -module_name fifo_generator_0
set_property -dict [list CONFIG.Input_Data_Width {8} CONFIG.Input_Depth {256} CONFIG.Output_Data_Width {8} CONFIG.Output_Depth {256} CONFIG.Data_Count {true} CONFIG.Data_Count_Width {8} CONFIG.Write_Data_Count_Width {8} CONFIG.Read_Data_Count_Width {8} CONFIG.Full_Threshold_Assert_Value {254} CONFIG.Full_Threshold_Negate_Value {253}] [get_ips fifo_generator_0]
generate_target {instantiation_template} [get_files ${test_path}/vivado_prj.srcs/sources_1/ip/fifo_generator_0/fifo_generator_0.xci]
generate_target all [get_files  ${test_path}/vivado_prj.srcs/sources_1/ip/fifo_generator_0/fifo_generator_0.xci]
catch { config_ip_cache -export [get_ips -all fifo_generator_0] }
export_ip_user_files -of_objects [get_files ${test_path}/vivado_prj.srcs/sources_1/ip/fifo_generator_0/fifo_generator_0.xci] -no_script -sync
create_ip_run [get_files -of_objects [get_fileset sources_1] ${test_path}/vivado_prj.srcs/sources_1/ip/fifo_generator_0/fifo_generator_0.xci]
launch_runs fifo_generator_0_synth_1 -jobs 6
##Add design files
add_files -norecurse ${test_path}/../hdl/uart/baud_gen.vhd
add_files -norecurse ${test_path}/../hdl/uart/u_rx.vhd
add_files -norecurse ${test_path}/../hdl/uart/u_tx.vhd
add_files -norecurse ${test_path}/../hdl/uart/uart_pack.vhd
add_files -norecurse ${test_path}/../hdl/uart/uart_top.vhd
add_files -norecurse ${test_path}/../hdl/top.vhd
##Add verification files
add_files -norecurse ${test_path}/../verif/testbench/uart_interface.sv
add_files -norecurse ${test_path}/../verif/environment/uart_agent/uart_transaction.sv
add_files -norecurse ${test_path}/../verif/sequences/seq_list.sv
add_files -norecurse ${test_path}/../verif/sequences/uart_write_seq.sv
add_files -norecurse ${test_path}/../verif/environment/uart_agent/uart_driver.sv
add_files -norecurse ${test_path}/../verif/environment/uart_agent/uart_sequencer.sv
add_files -norecurse ${test_path}/../verif/environment/uart_agent/uart_agent.sv
add_files -norecurse ${test_path}/../verif/environment/uart_agent/uart_agent_pkg.sv
add_files -norecurse ${test_path}/../verif/environment/environment.sv
add_files -norecurse ${test_path}/../verif/environment/env_pkg.sv
add_files -norecurse ${test_path}/../verif/tests/base_test.sv
add_files -norecurse ${test_path}/../verif/tests/test_list.sv
add_files -norecurse ${test_path}/../verif/testbench/testbench.sv
set_property top testbench [current_fileset]
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1

set_property -name {xsim.simulate.runtime} -value {-all} -objects [get_filesets sim_1]
set_property -name {xsim.compile.xvlog.more_options} -value {-L uvm} -objects [get_filesets sim_1]
set_property -name {xsim.elaborate.xelab.more_options} -value {-L uvm -timescale 1ns/1ps} -objects [get_filesets sim_1]
set_property -name {xsim.simulate.xsim.more_options} -value {-testplusarg UVM_TESTNAME=base_test -testplusarg UVM_VERBOSITY=UVM_LOW} -objects [get_filesets sim_1]

