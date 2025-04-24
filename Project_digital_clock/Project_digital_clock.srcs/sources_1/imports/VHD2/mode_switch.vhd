library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mode_switch is
  port (
    clk   : in  std_logic;
    reset : in  std_logic;
    btn   : in  std_logic;
    mode  : out std_logic_vector(1 downto 0)
  );
end mode_switch;

architecture Behavioral of mode_switch is
  signal current_mode : unsigned(1 downto 0) := "00";
  signal btn_sync     : std_logic := '0';
  signal btn_last     : std_logic := '0';
  signal btn_edge     : std_logic;
begin
  process(clk)
  begin
    if rising_edge(clk) then
      btn_last <= btn_sync;
      btn_sync <= btn;
    end if;
  end process;

  btn_edge <= '1' when btn_sync = '1' and btn_last = '0' else '0';

  process(clk)
  begin
    if rising_edge(clk) then
      if reset = '1' then
        current_mode <= "00";
      elsif btn_edge = '1' then
        if current_mode = "10" then
          current_mode <= "00";
        else
          current_mode <= current_mode + 1;
        end if;
      end if;
    end if;
  end process;

  mode <= std_logic_vector(current_mode);
end Behavioral;
