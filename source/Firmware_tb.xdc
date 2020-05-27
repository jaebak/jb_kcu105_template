set_property LOC AK17 [get_ports CLK_IN_P]
set_property IOSTANDARD  DIFF_SSTL12 [get_ports CLK_IN_P]
set_property ODT         RTT_48 [get_ports CLK_IN_P]

set_property LOC AK16 [get_ports CLK_IN_N]
set_property IOSTANDARD  DIFF_SSTL12 [get_ports CLK_IN_N]
set_property ODT         RTT_48 [get_ports CLK_IN_N]

set_property LOC H27 [get_ports J36_USER_SMA_GPIO_P]
set_property IOSTANDARD  LVCMOS18 [get_ports J36_USER_SMA_GPIO_P]

# Constrain only P side of the clock: https://www.xilinx.com/support/answers/57109.html
create_clock -period 3.333 -name clk_in [get_ports CLK_IN_P]
set_input_jitter [get_clocks -of_objects [get_ports CLK_IN_P]] 0.033330000000000005

# get_ports vs get_pins: https://electronics.stackexchange.com/questions/339401/get-ports-vs-get-pins-vs-get-nets-vs-get-registers
# To match timing from same source clock: https://forums.xilinx.com/t5/Timing-Analysis/CLOCK-DELAY-GROUP-doesn-t-seem-to-be-working/td-p/899055


#set clk_out10_net [get_nets -of_objects [get_pins ClockManager_i/clk_out10]]
#set clk_out40_net   [get_nets -of_objects [get_pins ClockManager_i/clk_out40]]
#set_property CLOCK_DELAY_GROUP clk_grp [get_nets [list $clk_out10_net $clk_out40_net ]]
#set_property CLOCK_DELAY_GROUP group_clockManager [get_nets -hierarchical {clk_out40 clk_out10 clk_out80}]
#set_property CLOCK_DELAY_GROUP my_clk_grp [get_nets -hierarchical {clk_out40 clk_out10}]
#set_property CLOCK_DELAY_GROUP my_clk_grp CLK_OUT10 CLK_OUT40
#set_property CLOCK_DELAY_GROUP my_clk_grp [get_nets -of_objects [get_pins {ClockManager_i/clk_out10 ClockManager_i/clk_out40}]]

set_property CLOCK_DELAY_GROUP my_clk_grp [get_nets -of_objects [get_pins {bufg_sysclk/O bufg_sysclkQuarter/O}]]

#set_property CLOCK_DELAY_GROUP my_clk_grp [get_nets -of_objects [get_pins {ClockManager_i/inst/clkout2_buf/O ClockManager_i/inst/clkout1_buf/O}]]

#set_multicycle_path -setup 4 -from [get_clocks clk_out10_clockManager] -to [get_clocks clk_out40_clockManager]
#set_multicycle_path -hold 3 -end -from [get_clocks clk_out10_clockManager] -to [get_clocks clk_out40_clockManager]


#set_multicycle_path -setup 4 -from [get_nets -hierarchical clk_out10] -to [get_nets -hierarchical clk_out40]
#set_multicycle_path -hold 3 -end -from [get_nets -hierarchical clk_out10] -to [get_nets -hierarchical clk_out40]
