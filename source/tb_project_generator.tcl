# In the source directory run the below command
# vivado -nojournal -nolog -mode batch -source tb_project_generator.tcl
# Environment variables
set SOURCE_FOLDER [file dirname [ dict get [ info frame 0 ] file ] ]
set FPGA_TYPE xcku040-ffva1156-2-e

# Generate ip
set argv $FPGA_TYPE
set argc 1
source $SOURCE_FOLDER/ip_generator.tcl

# Create project
create_project tb_project $SOURCE_FOLDER/../tb_project -part $FPGA_TYPE -force
set_property target_language VHDL [current_project]
set_property target_simulator XSim [current_project]

# Add files
add_files -norecurse "$SOURCE_FOLDER/Firmware.vhd $SOURCE_FOLDER/Firmware_pkg.vhd $SOURCE_FOLDER/Firmware_tb.vhd $SOURCE_FOLDER/../ip/$FPGA_TYPE/clockManager/clockManager.xci $SOURCE_FOLDER/../ip/$FPGA_TYPE/ila/ila.xci $SOURCE_FOLDER/../ip/$FPGA_TYPE/lut_input1/lut_input1.xci $SOURCE_FOLDER/../ip/$FPGA_TYPE/lut_input2/lut_input2.xci"
add_files -fileset constrs_1 -norecurse "$SOURCE_FOLDER/Firmware_tb.xdc"

# Add tcl for simulation
set_property -name {xsim.simulate.custom_tcl} -value "$SOURCE_FOLDER/Firmware_tb.tcl" -objects [get_filesets sim_1]

# Set ip as global
set_property generate_synth_checkpoint false [get_files  $SOURCE_FOLDER/../ip/$FPGA_TYPE/clockManager/clockManager.xci]
set_property generate_synth_checkpoint false [get_files  $SOURCE_FOLDER/../ip/$FPGA_TYPE/ila/ila.xci]
set_property generate_synth_checkpoint false [get_files  $SOURCE_FOLDER/../ip/$FPGA_TYPE/lut_input1/lut_input1.xci]
set_property generate_synth_checkpoint false [get_files  $SOURCE_FOLDER/../ip/$FPGA_TYPE/lut_input2/lut_input2.xci]

puts "\[Success\] Created tb_project"
close_project
