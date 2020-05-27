# In the source directory run the below command
# vivado -nojournal -nolog -mode batch -source project_generator.tcl

# Environment variables
set SOURCE_FOLDER [file dirname [ dict get [ info frame 0 ] file ] ]
set FPGA_TYPE xcku035-ffva1156-1-c

# Create project
create_project project $SOURCE_FOLDER/../project -part $FPGA_TYPE -force
set_property target_language VHDL [current_project]
set_property target_simulator XSim [current_project]

# Add files
add_files -norecurse "$SOURCE_FOLDER/Firmware.vhd $SOURCE_FOLDER/Firmware_pkg.vhd"
