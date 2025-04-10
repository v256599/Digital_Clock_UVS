-- top_level.vhd - propojení všech komponent digitálních hodin (opraveno)

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top_level is
    Port (
        CLK100MHZ : in  STD_LOGIC;
        BTNC      : in  STD_LOGIC;
        BTNU      : in  STD_LOGIC;
        BTND      : in  STD_LOGIC;
        BTNL      : in  STD_LOGIC;
        BTNR      : in  STD_LOGIC;

        -- 7-segment display
        CA, CB, CC, CD, CE, CF, CG, DP : out STD_LOGIC;
        AN : out STD_LOGIC_VECTOR(7 downto 0);

        -- RGB LED (nap?. LED16)
        LED16_R, LED16_G, LED16_B : out STD_LOGIC
    );
end top_level;

architecture Structural of top_level is

    -- Clock signals
    signal clk_1Hz, clk_100Hz : STD_LOGIC;

    -- Mode selector
    signal mode : STD_LOGIC_VECTOR(1 downto 0);

    -- Time counter
    signal current_hours  : STD_LOGIC_VECTOR(4 downto 0);
    signal current_minutes: STD_LOGIC_VECTOR(5 downto 0);

    -- Date register
    signal day   : STD_LOGIC_VECTOR(4 downto 0);
    signal month : STD_LOGIC_VECTOR(3 downto 0);
    signal year  : STD_LOGIC_VECTOR(11 downto 0);

    -- Alarm
    signal alarm_trigger : STD_LOGIC;
    signal alarm_h : STD_LOGIC_VECTOR(4 downto 0);
    signal alarm_m : STD_LOGIC_VECTOR(5 downto 0);

    -- Stopwatch
    signal sw_minutes, sw_seconds : STD_LOGIC_VECTOR(5 downto 0);
    signal sw_hundreds : STD_LOGIC_VECTOR(6 downto 0);

    -- Display
    signal digits : STD_LOGIC_VECTOR(31 downto 0);
    signal dp_vec : STD_LOGIC_VECTOR(7 downto 0);
    signal segs : STD_LOGIC_VECTOR(6 downto 0);
    signal current_digit : STD_LOGIC_VECTOR(3 downto 0);
    signal digit_index : INTEGER range 0 to 7 := 0;
    signal refresh_counter : STD_LOGIC_VECTOR(19 downto 0) := (others => '0');

    -- Blikání
    signal blink_counter : STD_LOGIC_VECTOR(25 downto 0) := (others => '0');
    signal blink_state   : STD_LOGIC := '1';

    -- Manuální nastavení ?asu
    signal set_hours_manual   : STD_LOGIC_VECTOR(4 downto 0);
    signal set_minutes_manual : STD_LOGIC_VECTOR(5 downto 0);
    signal load_manual_time   : STD_LOGIC;
    signal active_field_time  : STD_LOGIC;

    signal manual_enable : STD_LOGIC := '1'; -- p?epnout pozd?ji pomocí SW[0]

begin

    -- Clock divider
    clkdiv: entity work.clock_divider
        port map (
            clk        => CLK100MHZ,
            clk_1Hz    => clk_1Hz,
            clk_100Hz  => clk_100Hz
        );

    -- Mode selector
    modeselect: entity work.mode_selector
        port map (
            clk      => CLK100MHZ,
            rst      => '0',
            btn_mode => BTNC,
            mode     => mode
        );

    -- Time counter s volbou zdroje
    timecore: entity work.time_counter
        port map (
            clk_1Hz     => clk_1Hz,
            rst         => '0',
            load_time   => load_manual_time,
            set_hours   => set_hours_manual,
            set_minutes => set_minutes_manual,
            hours       => current_hours,
            minutes     => current_minutes
        );

    -- Date register
    datecore: entity work.date_register
        port map (
            clk           => CLK100MHZ,
            rst           => '0',
            load_date     => '0',
            set_day       => (others => '0'),
            set_month     => (others => '0'),
            set_year      => (others => '0'),
            current_day   => day,
            current_month => month,
            current_year  => year
        );

    -- Alarm module
    alarm: entity work.alarm_module
        port map (
            clk             => CLK100MHZ,
            rst             => '0',
            load_alarm      => '0',
            set_hours       => (others => '0'),
            set_minutes     => (others => '0'),
            current_hours   => current_hours,
            current_minutes => current_minutes,
            alarm_trigger   => alarm_trigger
        );

    -- Stopwatch
    stopwatch_inst: entity work.stopwatch
        port map (
            clk_100Hz   => clk_100Hz,
            rst         => '0',
            start       => BTNU,
            stop        => BTND,
            clear       => BTNR,
            sw_minutes  => sw_minutes,
            sw_seconds  => sw_seconds,
            sw_hundreds => sw_hundreds
        );

    -- Manuální nastavování ?asu
    mode_manual_time_inst: entity work.mode_manual_time
        port map (
            clk         => CLK100MHZ,
            rst         => '0',
            sel_left    => BTNL,
            sel_right   => BTNR,
            btn_up      => BTNU,
            btn_down    => BTND,
            btn_ok      => BTNC,
            set_hours   => set_hours_manual,
            set_minutes => set_minutes_manual,
            load_time   => load_manual_time,
            active_field => active_field_time
        );

    -- Blikání - 1Hz
    process(CLK100MHZ)
    begin
        if rising_edge(CLK100MHZ) then
            blink_counter <= blink_counter + 1;
            if blink_counter = X"2FAF080" then  -- cca 1 Hz
                blink_counter <= (others => '0');
                blink_state <= not blink_state;
            end if;
        end if;
    end process;

    -- Multiplexor
    multiplexer: entity work.multiplexor
        port map (
            mode          => mode,
            time_hours    => current_hours,
            time_minutes  => current_minutes,
            time_seconds  => (others => '0'),
            date_day      => day,
            date_month    => month,
            date_year     => year,
            alarm_hours   => alarm_h,
            alarm_minutes => alarm_m,
            sw_minutes    => sw_minutes,
            sw_seconds    => sw_seconds,
            sw_ms         => sw_hundreds,
            blink_state   => blink_state,
            active_field  => active_field_time,
            digits        => digits,
            dp            => dp_vec
        );

    -- 7-segment multiplexing
    process(CLK100MHZ)
    begin
        if rising_edge(CLK100MHZ) then
            refresh_counter <= refresh_counter + 1;
            digit_index <= to_integer(unsigned(refresh_counter(19 downto 17)));
        end if;
    end process;

    current_digit <= digits(digit_index*4 + 3 downto digit_index*4);

    b2s: entity work.bin2seg
        port map (
            bin => current_digit,
            clear => '0',
            seg   => segs
        );

    CA <= segs(0);
    CB <= segs(1);
    CC <= segs(2);
    CD <= segs(3);
    CE <= segs(4);
    CF <= segs(5);
    CG <= segs(6);
    DP <= dp_vec(digit_index);

    AN <= (others => '1');
    AN(digit_index) <= '0';

    -- RGB LED podle módu
    LED16_R <= mode(1);
    LED16_G <= not mode(1) and mode(0);
    LED16_B <= not mode(1) and not mode(0);

end Structural;