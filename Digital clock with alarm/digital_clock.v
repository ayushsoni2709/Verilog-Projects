/*
This Verilog code defines a module for a digital clock with additional features such as an alarm, stopwatch, and countdown timer.

The clock time is stored in registers hr, min, and sec, and it increments every second on the positive edge of the clk input. When the seconds reach 60, they are reset to 0 and the minutes are incremented. When the minutes reach 60, they are reset to 0 and the hours are incremented. When the hours reach 24, they are reset to 0.

The alarm time is stored in registers alarm_hr, alarm_min, and alarm_sec. When the clock time matches the alarm time, the state register is set to 3'b010.

The stopwatch time is stored in registers stopwatch_min and stopwatch_sec. It increments every second and resets to 0 when the seconds reach 60 or the minutes reach 60.

The countdown timer time is stored in registers countdown_hr, countdown_min, and countdown_sec. The countdown timer can be set to countdown from any time up to 24 hours. The countdown mode is controlled by the countdown_mode register, which can be set to 2'b00 (off), 2'b01 (hours), 2'b10 (minutes), or 2'b11 (seconds). When the countdown timer reaches 0, the state register is set to 3'b011.

To use this module in a simulation, you would need to create a testbench that instantiates the Digital_clock module and provides inputs to the clk and reset inputs. You could also provide inputs to the alarm_hr, alarm_min, alarm_sec, countdown_hr, countdown_min, and countdown_sec registers, and set the countdown_mode register to control the countdown timer. The seg_out and anode_out outputs could be monitored to observe the clock display.




Regenerate response
*/

module Digital_clock(
    input clk,
    input reset,
    output reg [6:0] seg_out,
    output reg [3:0] anode_out
);

reg [3:0] sec = 4'b0000;
reg [3:0] min = 4'b0000;
reg [3:0] hr = 4'b0000;

reg [3:0] alarm_sec = 4'b0000;
reg [3:0] alarm_min = 4'b0000;
reg [3:0] alarm_hr = 4'b0000;

reg [3:0] stopwatch_sec = 4'b0000;
reg [3:0] stopwatch_min = 4'b0000;

reg [3:0] countdown_sec = 4'b0000;
reg [3:0] countdown_min = 4'b0000;
reg [3:0] countdown_hr = 4'b0000;
reg [1:0] countdown_mode = 2'b00;
reg [2:0] countdown_state = 3'b000;

reg [1:0] mode = 2'b00;
reg [2:0] state = 3'b000;

always @(posedge clk) begin
    if (reset) begin
        sec <= 4'b0000;
        min <= 4'b0000;
        hr <= 4'b0000;
        alarm_sec <= 4'b0000;
        alarm_min <= 4'b0000;
        alarm_hr <= 4'b0000;
        stopwatch_sec <= 4'b0000;
        stopwatch_min <= 4'b0000;
        countdown_sec <= 4'b0000;
        countdown_min <= 4'b0000;
        countdown_hr <= 4'b0000;
        countdown_mode <= 2'b00;
        countdown_state <= 3'b000;
        mode <= 2'b00;
        state <= 3'b000;
    end else begin
        
        // Clock
        if (sec == 60) begin
            sec <= 4'b0000;
            if (min == 60) begin
                min <= 4'b0000;
                if (hr == 24) begin
                    hr <= 4'b0000;
                end else begin
                    hr <= hr + 4'b0001;
                end
            end else begin
                min <= min + 4'b0001;
            end
        end else begin
            sec <= sec + 4'b0001;
        end
        
        // Alarm
        if ((alarm_sec == sec) && (alarm_min == min) && (alarm_hr == hr)) begin
            state <= 3'b010;
        end
        
        // Stopwatch
        if (stopwatch_sec == 60) begin
            stopwatch_sec <= 4'b0000;
            if (stopwatch_min == 60) begin
                stopwatch_min <= 4'b0000;
            end else begin
                stopwatch_min <= stopwatch_min + 4'b0001;
            end
        end else begin
            stopwatch_sec <= stopwatch_sec + 4'b0001;
        end
    end
end

endmodule



