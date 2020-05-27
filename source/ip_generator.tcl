if { $argc != 1 } {
  puts "\[Error\] Please type in one of the below commands in the source directory"
  puts "vivado -nojournal -nolog -mode batch -source ip_generator.tcl -tclargs xcku040-ffva1156-2-e"
  puts "vivado -nojournal -nolog -mode batch -source ip_generator.tcl -tclargs xcku035-ffva1156-1-c"
} else {
  # Set environment variable
  set SOURCE_FOLDER [file dirname [ dict get [ info frame 0 ] file ] ]
  set FPGA_TYPE [lindex $argv 0] 

  # Create ip project manager
  create_project managed_ip_project $SOURCE_FOLDER/../ip/$FPGA_TYPE/managed_ip_project -part $FPGA_TYPE -ip -force
  set_property target_language VHDL [current_project]
  set_property target_simulator XSim [current_project]
  
  # Create clockManager
  create_ip -name clk_wiz -vendor xilinx.com -library ip -version 6.0 -module_name clockManager -dir $SOURCE_FOLDER/../ip/$FPGA_TYPE -force
  # Set parameters
  set_property -dict [list CONFIG.PRIM_SOURCE {No_buffer} CONFIG.PRIM_IN_FREQ {300} CONFIG.CLKOUT2_USED {true} CONFIG.CLKOUT3_USED {true} CONFIG.PRIMARY_PORT {clk_in300} CONFIG.CLK_OUT1_PORT {clk_out40} CONFIG.CLK_OUT2_PORT {clk_out10} CONFIG.CLK_OUT3_PORT {clk_out80} CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {40} CONFIG.CLKOUT2_REQUESTED_OUT_FREQ {10} CONFIG.CLKOUT3_REQUESTED_OUT_FREQ {80} CONFIG.CLKOUT1_DRIVES {BUFG} CONFIG.CLKOUT2_DRIVES {BUFG} CONFIG.CLKOUT3_DRIVES {BUFG} CONFIG.USE_LOCKED {false} CONFIG.USE_RESET {false} CONFIG.CLKOUT1_MATCHED_ROUTING {true} CONFIG.CLKOUT2_MATCHED_ROUTING {true} CONFIG.CLKOUT3_MATCHED_ROUTING {true} CONFIG.CLKIN1_JITTER_PS {33.330000000000005} CONFIG.FEEDBACK_SOURCE {FDBK_AUTO} CONFIG.MMCM_DIVCLK_DIVIDE {5} CONFIG.MMCM_CLKFBOUT_MULT_F {16.000} CONFIG.MMCM_CLKIN1_PERIOD {3.333} CONFIG.MMCM_CLKIN2_PERIOD {10.0} CONFIG.MMCM_CLKOUT0_DIVIDE_F {24.000} CONFIG.MMCM_CLKOUT1_DIVIDE {96} CONFIG.MMCM_CLKOUT2_DIVIDE {12} CONFIG.NUM_OUT_CLKS {3} CONFIG.CLKOUT1_JITTER {177.713} CONFIG.CLKOUT1_PHASE_ERROR {121.733} CONFIG.CLKOUT2_JITTER {231.491} CONFIG.CLKOUT2_PHASE_ERROR {121.733} CONFIG.CLKOUT3_JITTER {154.948} CONFIG.CLKOUT3_PHASE_ERROR {121.733}] [get_ips clockManager]
  # Set out-of-contex to speed up synthesis
  set_property generate_synth_checkpoint true [get_files $SOURCE_FOLDER/../ip/$FPGA_TYPE/clockManager/clockManager.xci]
  
  # Create ila
  create_ip -name ila -vendor xilinx.com -library ip -version 6.2 -module_name ila -dir $SOURCE_FOLDER/../ip/$FPGA_TYPE -force
  # Set parameters
  set_property -dict [list CONFIG.C_PROBE1_TYPE {1} CONFIG.C_PROBE0_TYPE {2} CONFIG.C_PROBE1_WIDTH {4096} CONFIG.C_PROBE0_WIDTH {256} CONFIG.C_NUM_OF_PROBES {2} CONFIG.ALL_PROBE_SAME_MU {false}] [get_ips ila]
  # Set out-of-contex to speed up synthesis
  set_property generate_synth_checkpoint true [get_files $SOURCE_FOLDER/../ip/$FPGA_TYPE/ila/ila.xci]
  
  # Create lut_input1
  create_ip -name blk_mem_gen -vendor xilinx.com -library ip -version 8.4 -module_name lut_input1 -dir $SOURCE_FOLDER/../ip/$FPGA_TYPE -force
  # Set parameters
  set_property -dict [list CONFIG.Memory_Type {Single_Port_ROM} CONFIG.Write_Width_A {12} CONFIG.Write_Depth_A {4} CONFIG.Enable_A {Always_Enabled} CONFIG.Register_PortA_Output_of_Memory_Primitives {false} CONFIG.Load_Init_File {true} CONFIG.Coe_File $SOURCE_FOLDER/data/Input1.coe CONFIG.Read_Width_A {12} CONFIG.Write_Width_B {12} CONFIG.Read_Width_B {12} CONFIG.Port_A_Write_Rate {0}] [get_ips lut_input1]
  # Set out-of-contex to speed up synthesis
  set_property generate_synth_checkpoint true [get_files $SOURCE_FOLDER/../ip/$FPGA_TYPE/lut_input1/lut_input1.xci]
  
  # Create lut_input2
  create_ip -name blk_mem_gen -vendor xilinx.com -library ip -version 8.4 -module_name lut_input2 -dir $SOURCE_FOLDER/../ip/$FPGA_TYPE -force
  # Set parameters
  set_property -dict [list CONFIG.Memory_Type {Single_Port_ROM} CONFIG.Write_Width_A {12} CONFIG.Write_Depth_A {4} CONFIG.Enable_A {Always_Enabled} CONFIG.Register_PortA_Output_of_Memory_Primitives {false} CONFIG.Load_Init_File {true} CONFIG.Coe_File $SOURCE_FOLDER/data/Input2.coe CONFIG.Read_Width_A {12} CONFIG.Write_Width_B {12} CONFIG.Read_Width_B {12} CONFIG.Port_A_Write_Rate {0}] [get_ips lut_input2]
  # Set out-of-contex to speed up synthesis
  set_property generate_synth_checkpoint true [get_files $SOURCE_FOLDER/../ip/$FPGA_TYPE/lut_input2/lut_input2.xci]

  puts "\[Success\] Created ip for $FPGA_TYPE"
  close_project
}
