-- ACTUAL IMPLEMENTATION: DIGITAL CLOCK
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity digital_clock is
  port (
    CLK100MHZ : in  std_logic;
    reset     : in  std_logic;
    mode_btn  : in  std_logic;
    btn_up    : in  std_logic;
    btn_down  : in  std_logic;
    btn_next  : in  std_logic;
    btn_startstop : in std_logic;
    anodes    : out std_logic_vector(7 downto 0);
    segments  : out std_logic_vector(7 downto 0);
    led       : out std_logic_vector(2 downto 0)
  );
end digital_clock;

architecture Behavioral of digital_clock is
  signal clk1hz, clk1khz : std_logic;
  signal which_disp      : std_logic_vector(2 downto 0);
  type digit_array is array(0 to 5) of std_logic_vector(3 downto 0);
  signal d_time, d_stop, d_date, decoder_input : digit_array;
  signal dots : std_logic_vector(5 downto 0);
  signal mode : std_logic_vector(1 downto 0);
  signal cursor_time : integer range 0 to 1 := 0;
  signal cursor_date : integer range 0 to 2 := 0;

  component mode_switch
    port (
      clk   : in std_logic;
      reset : in std_logic;
      btn   : in std_logic;
      mode  : out std_logic_vector(1 downto 0)
    );
  end component;
begin
  clk_div1 : entity work.clk_1hz port map (clk_in => CLK100MHZ, clk_out => clk1hz);
  clk_div2 : entity work.clk_1khz port map (clk_in => CLK100MHZ, clk_out => clk1khz);
  disp_ctrl : entity work.mod6counter port map (clk_1khz => clk1khz, WhichDisplay => which_disp);

  counter_inst : entity work.clock_counter
    port map (
      clk_1hz  => clk1hz,
      reset    => reset,
      btn_up   => btn_up,
      btn_down => btn_down,
      btn_next => btn_next,
      d1 => d_time(0), d2 => d_time(1), d3 => d_time(2),
      d4 => d_time(3), d5 => d_time(4), d6 => d_time(5)
    );

  stopwatch_inst : entity work.stopwatch
    port map (
      clk_1hz => clk1hz,
      reset   => reset,
      btn_startstop => btn_startstop,
      d1 => d_stop(0), d2 => d_stop(1), d3 => d_stop(2),
      d4 => d_stop(3), d5 => d_stop(4), d6 => d_stop(5)
    );

  date_inst : entity work.date_display
    port map (
      clk_1hz => clk1hz,
      reset   => reset,
      btn_up  => btn_up,
      btn_down => btn_down,
      btn_next => btn_next,
      d1 => d_date(0), d2 => d_date(1), d3 => d_date(2),
      d4 => d_date(3), d5 => d_date(4), d6 => d_date(5)
    );

  mode_inst : mode_switch port map (
    clk => CLK100MHZ,
    reset => reset,
    btn => mode_btn,
    mode => mode
  );

  process(mode, cursor_time, cursor_date)
  begin
    dots <= (others => '0');
    case mode is
      when "00" =>  -- čas
        if cursor_time = 0 then
          dots(2) <= '1'; dots(3) <= '1';
        else
          dots(4) <= '1'; dots(5) <= '1';
        end if;
      when "10" =>  -- datum
        case cursor_date is
          when 0 => dots(0) <= '1'; dots(1) <= '1';
          when 1 => dots(2) <= '1'; dots(3) <= '1';
          when 2 => dots(4) <= '1'; dots(5) <= '1';
          when others => null;
        end case;
      when others => null;
    end case;
  end process;

  with mode select
    decoder_input <= d_time when "00",
                     d_stop when "01",
                     d_date when "10",
                     (others => "0000") when others;

  with mode select
    led <= "001" when "00",  -- čas
           "010" when "01",  -- stopky
           "100" when "10",  -- datum
           "000" when others;

  anode_inst : entity work.anode_picker port map (WhichDisplay => which_disp, anode => anodes);

  decoder_inst : entity work.decoder
    port map (
      digit1 => decoder_input(0), digit2 => decoder_input(1),
      digit3 => decoder_input(2), digit4 => decoder_input(3),
      digit5 => decoder_input(4), digit6 => decoder_input(5),
      WhichDisplay => which_disp,
      dots => dots,
      segments => segments
    );
end Behavioral;
