library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_clock_counter is
end tb_clock_counter;

architecture Behavioral of tb_clock_counter is
  signal clk_1hz      : std_logic := '0';
  signal reset        : std_logic := '0';
  signal btn_up       : std_logic := '0';
  signal btn_down     : std_logic := '0';
  signal btn_next     : std_logic := '0';
  signal setting_mode : std_logic := '0';
  signal cursor       : integer range 0 to 1 := 0;
  signal d1, d2, d3, d4, d5, d6 : std_logic_vector(3 downto 0);
begin
  uut: entity work.clock_counter
    port map (
      clk_1hz      => clk_1hz,
      reset        => reset,
      btn_up       => btn_up,
      btn_down     => btn_down,
      btn_next     => btn_next,
      setting_mode => setting_mode,
      cursor       => cursor,
      d1 => d1, d2 => d2, d3 => d3, d4 => d4, d5 => d5, d6 => d6
    );

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
    reset <= '1'; wait for 10 ns; reset <= '0';
    wait for 100 ns;

    -- Necháme sekundy běžet normálně
    wait for 500 ns;

    -- Aktivujeme režim nastavování
    setting_mode <= '1';
    wait for 100 ns;

    -- Přepneme kurzor na hodiny
    btn_next <= '1'; wait for 10 ns; btn_next <= '0';
    wait for 100 ns;

    -- Zvýšíme hodiny
    btn_up <= '1'; wait for 10 ns; btn_up <= '0';
    wait for 100 ns;

    -- Přepneme kurzor zpět na minuty
    btn_next <= '1'; wait for 10 ns; btn_next <= '0';
    wait for 100 ns;

    -- Snížíme minuty
    btn_down <= '1'; wait for 10 ns; btn_down <= '0';
    wait for 100 ns;
    
    -- Deaktivujeme režim nastavování
    setting_mode <= '0';
    wait for 500 ns;
    
    -- Ukončíme simulaci
    wait;
  end process;
end Behavioral;
