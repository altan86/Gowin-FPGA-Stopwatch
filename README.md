# Gowin FPGA Stopwatch (TangNano20k version)
 Verilog codes for a stopwatch project using the Tang Nano 20k. LED clock display used is the **Common Cathode** pinout. This is for the GW2AR-LV18QN88PC8/I7 FPGA developement board with TDCG1060m 7 LED Segment display.
 
# Pin connection (Please refer to 7 Segment LED clock display datasheet)
 Tang Nano 20k Pin&emsp;&emsp;&emsp;&emsp;7 Segment LED pin&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;Notes
 
 77&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;A - 14&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;previously pin 70
 
 27&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;B - 16&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;previously pin 71
 
 28&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;C - 13&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;previously pin 72
 
 25&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;D - 3&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;previously pin 73
 
 26&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;E - 5&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;previously pin 74
 
 29&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;F - 11&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;previously pin 75
 
 30&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;G - 15&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;previously pin 76
 
 31&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;DP - 7&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;previously pin 77
 
 41&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;D4 - 8&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;previously pin 80
 
 42&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;D3 - 6&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;previously pin 81
 
 80&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;D2 - 2&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;previously pin 82
 
 76&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;D1 - 1&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;previously pin 83
 
 
# Some dev notes
 * Each `always` block operates asynchronously, meaning that any codes nested within an `always` will run in parallel/simultaneously with other existing `always`. Hence this creates a runtime limitation that prevents any assignments (e.g. x = 1'b1;) of the same parameter to happen in separate `always` block during runtime. Question, which parallel/simultaneous process will have priority over the assignment?
 * When an `always` statement includes more than 1 condition, e.g. `always @ (posedge sys_clk or negedge sys_rst_n)`, said `always` block requires at least one `if` statement with either condition to be nested within the block.
 * There are two types of bitwise shift operator, `>>>` and `>>` (`<<<` and `<<` for reverse direction). Triple brackets are arithmetic shift where as double brackets are logical shifts. The `>>>` operator is unique from the other shift operator ( `<<<`, `<<` and `>>`), where by it will fill the left side of a **signed** parameter with a copy of the left most bit value, e.g. `4'b1011 >>> 1; //becomes 4'b1101 after shift`. The other shift operator simply fills the first or last bit with 0, depending on which shift direction.
 * Tang Nano 20k uses a 27 Mhz crystal oscillator, meaning its clock speed is basically 27 million pulses. Hence, a clock pulse counter that resets at 2.7 million pulses is equivalent to 0.1 seconds.

# Useful links for further study
 * https://www.chipverify.com/verilog/verilog-tutorial (General starting point)
 * https://www.asic-world.com/verilog/veritut.html (Intermediate and detailed guide, good for code reference)
 * https://wiki.sipeed.com/hardware/en/tang/tang-nano-20k/nano-20k.html (Tang Nano wiki)
 * https://www.vishay.com/doc/?83180= (PDF of 7 Segment LED clock display datasheet)
