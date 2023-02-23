module stopwatch (
    input sys_clk,          // clock input with frequency of 27 Mhz
    input sys_rst_n,        // reset button
    input sys_startstopbtn, // start stop button
    output reg [5:0] led = 6'b111111, // LEDS pin 10, 11, 13, 14, 15, 16
    output reg [7:0] segLED = 8'b1111_1111, // pins 70 thru 77
    output reg [3:0] segBlock = 4'b1110 // pins 80 thru 83, note the pull direction in constraints file

);

// Stopwatch system
reg [31:0] timer;
reg [31:0] timeScale = 32'd2_700_000; //0.1 seconds or 10 Hz base timer,
reg [3:0] stopWatchCtr_ms = 4'b0;
reg [31:0] stopWatchCtr_sec = 32'b0;

always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n) begin // Reset everything
        timer = 32'd0;
        led[6:1] = 5'b11111; // this means assign the value 5'b11111 to the 6th thru 1st bit in the LED parameter in, e.g. LED is 6'b000000 -> assign 5'b11111 to LED[6:1] -> LED is 6'111110
        stopWatchCtr_ms = 4'b0;
        stopWatchCtr_sec = 32'b0;
    end else if (startStopClk) begin // The Stopwatch clock engine
        timer = timer + 1'b1;
        if (timer == timeScale * startStopClk) begin
            timer = 32'd0;
            stopWatchCtr_ms = stopWatchCtr_ms + 1'b1;
            if (stopWatchCtr_ms == 4'd10) begin
                stopWatchCtr_ms = 4'b0;
                stopWatchCtr_sec = stopWatchCtr_sec + 1'b1;
                led <= {~stopWatchCtr_sec, led[1:0]};
            end
            led[1] <= ~led[1]; // for debug purposes
        end
    end else if (!led[1] && !startStopClk) begin // Just to reset the debug led back to 1'b1 when reset 
        led[1] <= 1'b1;
    end
end

// Segment decoder and mulitplexer. The former converts decimal values into binary pin output so the data is in a way hardware compatible while the latter switches between segement in a timely sequence and apply the correct data.
// The {<value>,<value>} is the concatenation operator, meaning it joins the left and right side values into a longer data set
reg [7:0] segmentData; // 8 bits long but note only 7 bits are used in the case statement
reg segmentDot; // 1 bit long

always @ (posedge sys_clk) begin
    case (segmentData) // 7 segment decoder
        8'd0 : segLED = {segmentDot, 7'b011_1111};
        8'd1 : segLED = {segmentDot, 7'b000_0110};
        8'd2 : segLED = {segmentDot, 7'b101_1011};
        8'd3 : segLED = {segmentDot, 7'b100_1111};
        8'd4 : segLED = {segmentDot, 7'b110_0110};
        8'd5 : segLED = {segmentDot, 7'b110_1101};
        8'd6 : segLED = {segmentDot, 7'b111_1101};
        8'd7 : segLED = {segmentDot, 7'b000_0111};
        8'd8 : segLED = {segmentDot, 7'b111_1111};
        8'd9 : segLED = {segmentDot, 7'b110_1111};
        default: ;
    endcase
    segmentDot = 1'b0;
    case (segBlock) // 7 segment multiplexer
        4'b1110 : segmentData = stopWatchCtr_ms;
        4'b1101 : begin
                    segmentData = stopWatchCtr_sec % 4'd10;
                    segmentDot = 1'b1;
                    end
        4'b1011 : segmentData = (stopWatchCtr_sec / 4'd10) % 4'd6;
        4'b0111 : begin
                    segmentData = stopWatchCtr_sec / 6'd60;
                    segmentDot = 1'b1;
                    end
        default : begin 
            segmentData <= stopWatchCtr_ms;
        end
    endcase
end    

// Segment switching and display, a separate standalone timer running at 240 Hz
// Each segment will display its data at 60 Hz (240 Hz / 4 pulses, each segment activates in 1 pulse).
reg [31:0] segmentCounter;
reg [31:0] segmentCounterTimeScale = 32'd0_112_500; //0.0041667 seconds or 240 Hz base timer,  

always @(posedge sys_clk) begin
    if (segmentCounter == segmentCounterTimeScale) begin
        segmentCounter = 32'b0;
        segBlock = (segBlock <<< 1) + 1'b1; // Since left shift fills the parameter with a 0 then have to add a 1'b1 to avoid activating the other segments
        if (segBlock == 4'b1111) // resets the block segment data
            segBlock = 4'b1110;
    end else
        segmentCounter <= segmentCounter + 1'b1;
end

// Start Stop button, Rise edge detection, non continuous single button press
// Rational: fill a counter up by copying and kinf of bitshifting so that a 2 bit comparator (array pos 2 and 1) gives a true value in one pulse cycle
// { , } = concantenate two parameter, see above
reg [2:0] btn_ctr = 4'b111;
reg inc_ctr;
reg startStopClk;

always @ (posedge sys_clk) begin
    btn_ctr <= {btn_ctr[1:0],sys_startstopbtn};
    inc_ctr <= ~btn_ctr[2] & btn_ctr[1];
    if (inc_ctr) begin
        startStopClk <= ~startStopClk;
        led[0] = startStopClk; // debug
    end 
end    

endmodule
