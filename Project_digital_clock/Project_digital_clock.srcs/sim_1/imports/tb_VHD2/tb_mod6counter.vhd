library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_mod6counter is
end tb_mod6counter;

architecture Behavioral of tb_mod6counter is
  signal clk_1khz     : std_logic := '0';
  signal WhichDisplay : std_logic_vector(2 downto 0);
begin
  uut: entity work.mod6counter
    port map (
      clk_1khz => clk_1khz,
      WhichDisplay => WhichDisplay
    );

  clk_process : process
  begin
    while true loop
      clk_1khz <= '1'; wait for 50 ns;
      clk_1khz <= '0'; wait for 50 ns;
    end loop;
  end process;

  stimulus: process
  begin
    -- necháme counter běžet několik cyklů
    wait for 50 ns;
    wait;
  end process;
end Behavioral;
