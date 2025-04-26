library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_date_display is
end tb_date_display;

architecture Behavioral of tb_date_display is
  signal clk_1hz      : std_logic := '0';
  signal reset        : std_logic := '0';
  signal btn_up       : std_logic := '0';
  signal btn_down     : std_logic := '0';
  signal btn_next     : std_logic := '0';
  signal setting_mode : std_logic := '0';
  signal cursor       : integer range 0 to 2 := 0;
  signal d1, d2, d3, d4, d5, d6 : std_logic_vector(3 downto 0);
begin
  uut: entity work.date_display
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
    reset <= '1'; wait for 50 ns; reset <= '0';
    wait for 100 ns;
    
    -- Test, jestli funguje setting režim
    btn_up <= '1'; wait for 20 ns; btn_up <= '0';
    wait for 100 ns;

    -- Aktivujeme setting režim
    setting_mode <= '1';
    wait for 100 ns;

    -- Zvýšíme den
    btn_up <= '1'; wait for 10 ns; btn_up <= '0';
    wait for 100 ns;

    -- Přepneme na měsíc
    btn_next <= '1'; wait for 10 ns; btn_next <= '0';
    wait for 100 ns;

    -- Zvýšíme měsíc
    btn_up <= '1'; wait for 10 ns; btn_up <= '0';
    wait for 100 ns;

    -- Přepneme na rok
    btn_next <= '1'; wait for 10 ns; btn_next <= '0';
    wait for 100 ns;

    -- Zvýšíme rok
    btn_up <= '1'; wait for 10 ns; btn_up <= '0';
    wait for 500 ns;

    -- Deaktivujeme setting režim
    setting_mode <= '0';
    wait for 500 ns;
    
    wait;
  end process;
end Behavioral;
