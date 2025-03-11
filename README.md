# Clock-and-Alarm_Assembly8086
This program simulates a clock and alarm system using 7 segment displays in assembly language. The program operates based on the following steps:

1. First, memory is allocated for storing the hour, minute, and second values.
2. The second value is incremented every second, and when it reaches 60, the minute is incremented.
3. The minute value is checked for every minute, and when it reaches 60, the hour is incremented.
4. The alarm system checks the specified hour and minute to determine if the alarm should ring.
5. The hour, minute, and second values are displayed on 7 segment displays.

## Installation and Usage

1. Use an appropriate assembler and emulator (e.g., emu8086) to compile and run the program.
2. Compile and run the program.
3. Set the hour, minute, and alarm values and observe the displays.

## Code Structure

- `org 100h`: Specifies the starting point of the program.
- Allocates memory for hour, minute, second, and alarm values.
- Checks for increment every second and increments the minute value.
- Checks for increment every minute and increments the hour value.
- The alarm system determines the alarm status by checking the specified hour and minute.
- Displays the hour, minute, and second values on 7 segment displays.

## Example Photo
![Example Photo](example_photo/photo.PNG)

##### Using Emulation Kit:
```
Download EmulationKit and copy the 
Emulation_Kit.exe file to "DEVICES" directory under the path 
where emu8086 is installed.
