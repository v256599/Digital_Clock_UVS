library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_stopwatch is
end tb_stopwatch;

architecture Behavioral of tb_stopwatch is
  signal clk_1hz       : std_logic := '0';
  signal reset         : std_logic := '0';
  signal btn_startstop : std_logic := '0';
  signal d1, d2, d3, d4, d5, d6 : std_logic_vector(3 downto 0);
begin
  uut: entity work.stopwatch
    port map (
      clk_1hz       => clk_1hz,
      reset         => reset,
      btn_startstop => btn_startstop,
      d1 => d1, d2 => d2, d3 => d3, d4 => d4, d5 => d5, d6 => d6
    );

  -- Hodiny 1Hz (rychlejší v simulaci)
  clk_process : process
  begin
    while true loop
      clk_1hz <= '1'; wait for 5 ns;
      clk_1hz <= '0'; wait for 5 ns;
    end loop;
  end process;

  stimulus : process
  begin
    -- Reset systému
    reset <= '1'; wait for 50 ns; reset <= '0';
    wait for 100 ns;

    -- Start stopek
    btn_startstop <= '1'; wait for 20 ns; btn_startstop <= '0';
    wait for 300 ns; -- necháme běžet

    -- Stop stopek
    btn_startstop <= '1'; wait for 20 ns; btn_startstop <= '0';
    wait for 200 ns; -- stopky stojí

    -- Znovu start stopek
    btn_startstop <= '1'; wait for 20 ns; btn_startstop <= '0';
    wait;

  end process;
end Behavioral;
