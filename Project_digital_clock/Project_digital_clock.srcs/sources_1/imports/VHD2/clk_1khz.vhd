library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity clk_1khz is
  port (
    clk_in  : in  std_logic;  -- 100MHz
    clk_out : out std_logic   -- 1kHz
  );
end clk_1khz;

architecture Behavioral of clk_1khz is
  constant DIVIDER : natural := 50_000;
  signal counter   : unsigned(15 downto 0) := (others => '0');
  signal tick      : std_logic := '0';
begin
  process(clk_in)
  begin
    if rising_edge(clk_in) then
      if counter = DIVIDER-1 then
        counter <= (others => '0');
        tick    <= not tick;
      else
        counter <= counter + 1;
      end if;
    end if;
  end process;
  clk_out <= tick;
end Behavioral;