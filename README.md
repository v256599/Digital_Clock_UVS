# Digital Clock
Team members
- Patrik Svoboda (responsible for ...)
- Dominik Uherka (responsible for ...)
- Daniel Valčík (responsible for ...)


## Abstract
An abstract is a short summary of your project, usually about a paragraph (6-7 sentences, 150-250 words) long. A well-written abstract serves multiple purposes: (a) an abstract lets readers get the gist or essence of your project quickly; (b) an abstract prepares readers to follow the detailed information, description, and results in your report; (c) and, later, an abstract helps readers remember key points from your project.


## The main contributions of the project are:
-
-
-

[Photo(s) of your application with labels of individual parts.]

[Link to A3 project poster.]

[Optional: Link to your short video presentation.]


## Hardware description of demo application!

Describe your implementation. Put a descriptive top-level schematic of your application.


## Software description
Put flowchats/state diagrams of your algorithm(s) and direct links to source/testbench files in src and sim folders.


## Components simulations
- Component: clk_1hz
- Description: Clock divider for generating a 1 Hz output clock signal.
![tb_clk_1hz](https://github.com/user-attachments/assets/c02687ae-c638-4041-8d1e-12d92fb6eb9b)
- The input clock (clk_in) is a high-frequency signal (e.g., 100 MHz).
- The output clock (clk_out) is divided down to approximately 1 Hz.
=============================================================================
-- Component: clk_1khz
-- Description: Clock divider for generating a 1 kHz output clock signal.
![tb_clk_1khz](https://github.com/user-attachments/assets/9227f120-1a59-4935-969c-b79cf378eaca)
-- The input clock (clk_in) is a high-frequency signal (e.g., 100 MHz).
-- The output clock (clk_out) is frequency-divided to approximately 1 kHz.
-- =============================================================================
-- Entity: clock_counter
-- Description: Core timekeeping module for counting hours, minutes, and seconds.
![tb_clock_counter](https://github.com/user-attachments/assets/bdc06005-2bb1-4675-b828-43d3e1fdb0be)
-- Supports setting mode to adjust hours and minutes using buttons.
-- Allows cursor switching between minutes and hours.
-- =============================================================================
-- Entity: date_display
-- Description: Module for displaying and adjusting the date (day, month, year).
![tb_date_display](https://github.com/user-attachments/assets/6d8f16af-ce0e-4cf0-9479-91a0584bfc94)
-- Supports cursor switching and individual field adjustment using buttons.
-- =============================================================================
-- Entity: decoder
-- Description: BCD to 7-segment decoder for displaying digits 0–9.
![tb_decoder](https://github.com/user-attachments/assets/7bd922a7-bc39-40f3-b1ee-5c9bb98b66a3)
-- Selects between six input digits based on WhichDisplay input.
-- =============================================================================
-- Entity: mod6counter
-- Description: Modulo-6 counter (counts 0 to 5 and wraps around).
  ![tb_mod6counter](https://github.com/user-attachments/assets/a5386d15-6f4c-42e0-8e41-cb1313de5629)
-- Used for multiplexing six 7-segment displays (AN0–AN5).
-- =============================================================================
-- Entity: anode_picker
-- Description: Module to select active anode (AN0–AN5) based on WhichDisplay.
  ![tb_anode_picker](https://github.com/user-attachments/assets/19ddbc8d-4958-4a42-ab0a-cd7471797fad)
-- Controls multiplexing between 7-segment displays.
-- =============================================================================
-- Entity: mode_switch
-- Description: Module for switching between clock, stopwatch, and date modes.
  ![tb_mode_switch](https://github.com/user-attachments/assets/901f5184-3fb4-43f8-a760-74e5e79c8c62)
-- Controlled via a single button; cycles through the modes.
-- =============================================================================
-- Entity: stopwatch
-- Description: Stopwatch module for measuring elapsed time from 00:00.
  ![tb_stopwatch](https://github.com/user-attachments/assets/c1f88b7a-b2a4-404e-97dd-12dd1e235b85)
-- Supports start/stop functionality via a button.
-- Displays seconds, minutes, and hours.
-- =============================================================================
