//Copyright (C)2014-2023 GOWIN Semiconductor Corporation.
//All rights reserved.
//File Title: Timing Constraints file
//GOWIN Version: 1.9.8.09 Education
//Created Time: 2023-12-29 13:49:27
create_clock -name sys_clk_1Mhz -period 1000 -waveform {0 500} [get_ports {sys_clk}]

set_clock_groups -exclusive -group [get_clocks {sys_clk_1Mhz}] 
