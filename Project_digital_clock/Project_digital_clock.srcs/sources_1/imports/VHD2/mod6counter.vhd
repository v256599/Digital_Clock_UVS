library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mod6counter is
  port (
    clk_1khz     : in  std_logic;
    WhichDisplay : out std_logic_vector(2 downto 0)
  );
end mod6counter;

architecture Behavioral of mod6counter is
  signal cnt : unsigned(2 downto 0) := (others => '0');
begin
  process(clk_1khz)
  begin
    if rising_edge(clk_1khz) then
      if cnt = "101" then
        cnt <= (others => '0');
      else
        cnt <= cnt + 1;
      end if;
    end if;
  end process;
  WhichDisplay <= std_logic_vector(cnt);
end Behavioral;