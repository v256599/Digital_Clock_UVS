library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_mode_switch is
end tb_mode_switch;

architecture Behavioral of tb_mode_switch is
  signal clk   : std_logic := '0';
  signal reset : std_logic := '0';
  signal btn   : std_logic := '0';
  signal mode  : std_logic_vector(1 downto 0);
begin
  uut: entity work.mode_switch
    port map (
      clk   => clk,
      reset => reset,
      btn   => btn,
      mode  => mode
    );

  clk_process : process
  begin
    while true loop
      clk <= '1'; wait for 5 ns;
      clk <= '0'; wait for 5 ns;
    end loop;
  end process;

  stimulus : process
  begin
    -- Reset systému
    reset <= '1'; wait for 20 ns; reset <= '0';
    wait for 50 ns;

    -- Stisk tlačítka -> změna režimu
    btn <= '1'; wait for 20 ns; btn <= '0';
    wait for 50 ns;

    btn <= '1'; wait for 20 ns; btn <= '0';
    wait for 50 ns;

    btn <= '1'; wait for 20 ns; btn <= '0'; -- zpět na začátek (loop)

    wait;
  end process;
end Behavioral;
