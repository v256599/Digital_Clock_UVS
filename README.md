# Digital Clock
### Team members:
- Patrik Svoboda (responsible for Main programs + Diagrams)
- Dominik Uherka (responsible for Main programs + GitHub)
- Daniel Valčík  (responsible for Main programs + Testbenches)


## Abstract
This project implements a fully functional digital clock system using VHDL, designed to operate on the Nexys A7 FPGA development board. The clock features multiple operating modes, including standard time display, stopwatch functionality, and date management (day, month, year). Users can interact with the system through push-buttons to switch modes, set time and date values, and control the stopwatch. The design includes multiple subsystems such as clock dividers, counters, mode selectors, and multiplexed 7-segment display drivers, all integrated under a top-level digital clock module. Comprehensive testbenches were developed for each module to ensure correct functionality before system-level integration. 

## The main contributions of the project are:
- Implementation of a fully functional digital clock system on the Nexys A7 FPGA, featuring clock, stopwatch, and date functionalities.
- Design and integration of modular VHDL components with full user interaction through push-buttons and visual feedback via LEDs and 7-segment displays.
- Complete functional verification using individual testbenches for each module and successful top-level system integration and simulation.




https://github.com/user-attachments/assets/dc616e41-188d-4471-bef7-118ba5829962


## Hardware description
The demo application is a digital clock system implemented on the Nexys A7 FPGA development board. The system integrates multiple functional blocks, including a standard clock (hours, minutes, seconds), a stopwatch module, and a date management module (day, month, year). 

All modules are connected under a top-level entity named `digital_clock`, which coordinates the system operation. A mode-switching module allows users to cycle between clock, stopwatch, and date modes using a dedicated button. 

User interactions such as adjusting time, date, or operating the stopwatch are handled through push-buttons (BTNL, BTNR, BTNU, BTND, BTNC). Mode indication is provided through onboard LEDs, and all data are displayed via multiplexed 7-segment displays. Clock division is performed using internal clock divider modules generating 1 Hz and 1 kHz signals from the main system clock.
### OLD Version of Top_level:
![Top_level](https://github.com/v256599/Digital_Clock_UVS/blob/main/hruby_nakres.png?raw=true)

### FINAL Version of Top_level:
![ObrázekSchema](https://github.com/user-attachments/assets/1b56f615-d6cb-419d-bfb3-4fe53cf0a4d9)

### Mode: Time 
![ObrázekRežimHodin](https://github.com/user-attachments/assets/b8cfb091-9053-499e-88ab-3bc52bd33cff)

### Mode: Stopwatch
![ObrázekRežimStopky](https://github.com/user-attachments/assets/3ab49e9d-6504-4d69-8988-a010069c038b)

### Mode: Date
![ObrázekRežimDatum](https://github.com/user-attachments/assets/591e5af4-396b-475c-a901-5976d313416b)



## Software description
The VHDL implementation is modular, with each functionality developed as a separate entity. The main modules are:
- [`clock_counter.vhd`](Project_digital_clock/Project_digital_clock.srcs/sources_1/imports/VHD2/clock_counter.vhd) — time counting
- [`stopwatch.vhd`](Project_digital_clock/Project_digital_clock.srcs/sources_1/imports/VHD2/stopwatch.vhd) — stopwatch functionality
- [`date_display.vhd`](Project_digital_clock/Project_digital_clock.srcs/sources_1/imports/VHD2/date_display.vhd) — date management 
- [`mode_switch.vhd`](Project_digital_clock/Project_digital_clock.srcs/sources_1/imports/VHD2/mode_switch.vhd)— mode selection 
- [`decoder.vhd`](Project_digital_clock/Project_digital_clock.srcs/sources_1/imports/VHD2/decoder.vhd) — BCD to 7-segment decoder
- [`anode_picker.vhd`](Project_digital_clock/Project_digital_clock.srcs/sources_1/imports/VHD2/anode_picker.vhd)— anode selection for display multiplexing
- [`mod6counter.vhd`](Project_digital_clock/Project_digital_clock.srcs/sources_1/imports/VHD2/mod6counter.vhd) — 0–5 counter for display switching
- [`clk_1hz.vhd`](Project_digital_clock/Project_digital_clock.srcs/sources_1/imports/VHD2/clk_1hz.vhd) and [`clk_1khz.vhd`](Project_digital_clock/Project_digital_clock.srcs/sources_1/imports/VHD2/clk_1khz.vhd) — clock dividers

Each module is verified with a dedicated testbench:
- [`tb_clock_counter.vhd`](Project_digital_clock/Project_digital_clock.srcs/sim_1/imports/tb_VHD2/tb_clock_counter.vhd)
- [`tb_stopwatch.vhd`](Project_digital_clock/Project_digital_clock.srcs/sim_1/imports/tb_VHD2/tb_stopwatch.vhd)
- [`tb_date_display.vhd`](Project_digital_clock/Project_digital_clock.srcs/sim_1/imports/tb_VHD2/tb_date_display.vhd)
- [`tb_mode_switch.vhd`](Project_digital_clock/Project_digital_clock.srcs/sim_1/imports/tb_VHD2/tb_mode_switch.vhd)
- [`tb_decoder.vhd`](Project_digital_clock/Project_digital_clock.srcs/sim_1/imports/tb_VHD2/tb_decoder.vhd)
- [`tb_anode_picker.vhd`](Project_digital_clock/Project_digital_clock.srcs/sim_1/imports/tb_VHD2/tb_anode_picker.vhd)
- [`tb_mod6counter.vhd`](Project_digital_clock/Project_digital_clock.srcs/sim_1/imports/tb_VHD2/tb_mod6counter.vhd)
- [`tb_clk_1hz.vhd`](Project_digital_clock/Project_digital_clock.srcs/sim_1/imports/tb_VHD2/tb_clk_1hz.vhd)
- [`tb_clk_1khz.vhd`](Project_digital_clock/Project_digital_clock.srcs/sim_1/imports/tb_VHD2/tb_clk_1khz.vhd)


## Components simulations
### Component: clk_1hz
- Description: Clock divider for generating a 1 Hz output clock signal.
![tb_clk_1hz](https://github.com/user-attachments/assets/c02687ae-c638-4041-8d1e-12d92fb6eb9b)
- The input clock (clk_in) is a high-frequency signal (e.g., 100 MHz).
- The output clock (clk_out) is divided down to approximately 1 Hz.

### Component: clk_1khz
- Description: Clock divider for generating a 1 kHz output clock signal.
![tb_clk_1khz](https://github.com/user-attachments/assets/9227f120-1a59-4935-969c-b79cf378eaca)
- The input clock (clk_in) is a high-frequency signal (e.g., 100 MHz).
- The output clock (clk_out) is frequency-divided to approximately 1 kHz.

### Component: clock_counter
- Description: Core timekeeping module for counting hours, minutes, and seconds.
![tb_clock_counter](https://github.com/user-attachments/assets/bdc06005-2bb1-4675-b828-43d3e1fdb0be)
- Supports setting mode to adjust hours and minutes using buttons.
- Allows cursor switching between minutes and hours.

### Component: decoder
- Description: BCD to 7-segment decoder for displaying digits 0–9.
![tb_decoder](https://github.com/user-attachments/assets/7bd922a7-bc39-40f3-b1ee-5c9bb98b66a3)
- Selects between six input digits based on WhichDisplay input.

### Component: mod6counter
- Description: Modulo-6 counter (counts 0 to 5 and wraps around).
![tb_mod6counter](https://github.com/user-attachments/assets/a5386d15-6f4c-42e0-8e41-cb1313de5629)
- Used for multiplexing six 7-segment displays (AN0–AN5).

### Component: anode_picker
- Description: Module to select active anode (AN0–AN5) based on WhichDisplay.
![tb_anode_picker](https://github.com/user-attachments/assets/19ddbc8d-4958-4a42-ab0a-cd7471797fad)
- Controls multiplexing between 7-segment displays.

### Component: date_display
- Description: Module for displaying and adjusting the date (day, month, year).
![tb_date_display](https://github.com/user-attachments/assets/6d8f16af-ce0e-4cf0-9479-91a0584bfc94)
- Supports cursor switching and individual field adjustment using buttons.

### Component: stopwatch
- Description: Stopwatch module for measuring elapsed time from 00:00.
![tb_stopwatch](https://github.com/user-attachments/assets/c1f88b7a-b2a4-404e-97dd-12dd1e235b85)
- Supports start/stop functionality via a button.
- Displays seconds, minutes, and hours.

### Component: mode_switch
- Description: Module for switching between clock, stopwatch, and date modes.
![tb_mode_switch](https://github.com/user-attachments/assets/901f5184-3fb4-43f8-a760-74e5e79c8c62)
- Controlled via a single button; cycles through the modes.

