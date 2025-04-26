library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_clk_1khz is
end tb_clk_1khz;

architecture Behavioral of tb_clk_1khz is
  signal clk_in  : std_logic := '0';
  signal clk_out : std_logic;
begin
  uut: entity work.clk_1khz
    port map (
      clk_in  => clk_in,
      clk_out => clk_out
    );

  clk_process : process
  begin
    while true loop
      clk_in <= '1'; wait for 20 ns;
      clk_in <= '0'; wait for 20 ns;
    end loop;
  end process;

  stimulus: process
  begin
    wait for 20 ns;
    wait;
  end process;
end Behavioral;
