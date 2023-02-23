# Gowin FPGA Stopwatch
 Verilog codes for a stopwatch project using the Tang Nano 9k. LED clock display used is the **Common Cathode** design.
 
# Pin connection (Please refer to 7 Segment LED clock display datasheet)
 Tang Nano 9k Pin		7 Segment LED pin		Note
 70							A - 14
 71							B - 16
 72							C - 13
 73							D - 3
 74							E - 5
 75							F - 11
 76							G - 15
 77							DP - 7
 
 80							D4 - 8			10 Ohm resisitor inline
 81							D3 - 6			10 Ohm resisitor inline
 82							D2 - 2			10 Ohm resisitor inline
 83							D1 - 1			10 Ohm resisitor inline
 
# Some dev notes
 * Each `always` block operates asynchronously, meaning that any codes nested within an `always` will run in parallel/simultaneously with other existing `always`. Hence this creates a runtime limitation that prevents any assignments (e.g. x = 1'b1;) of the same parameter to happen in separate `always` block during runtime. Question, which parallel/simultaneous process will have priority over the assignment?
 * When an `always` statement includes more than 1 condition, e.g. `always @ (posedge sys_clk or negedge sys_rst_n)`, said `always` block requires at least one `if` statement with either condition to be nested within the block.
 * There are two types of bitwise shift operator, `>>>` and `>>` (`<<<` and `<<` for reverse direction). Triple brackets are arithmetic shift where as double brackets are logical shifts. The `>>>` operator is unique from the other shift operator ( `<<<`, `<<` and `>>`), where by it will fill the left side of a **signed** parameter with a copy of the left most bit value, e.g. `4'b1011 >>> 1; //becomes 4'b1101 after shift`. The other shift operator simply fills the first or last bit with 0, depending on which shift direction.
 * Tang Nano 9k uses a 27 Mhz crystal oscillator, meaning its clock speed is basically 27 million pulses. Hence, a clock pulse counter that resets at 2.7 million pulses is equivalent to 0.1 seconds.
 * 

# Useful links for further study
 * https://www.chipverify.com/verilog/verilog-tutorial (General starting point)
 * https://www.asic-world.com/verilog/veritut.html (Intermediate and detailed guide, good for code reference)
 * https://wiki.sipeed.com/hardware/en/tang/Tang-Nano-9K/Nano-9K.html (Tang Nano wiki)
 * https://www.vishay.com/doc/?83180= (PDF of 7 Segment LED clock display datasheet)