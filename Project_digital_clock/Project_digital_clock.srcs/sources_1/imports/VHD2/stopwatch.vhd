library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity stopwatch is
  port (
    clk_1hz       : in  std_logic;
    reset         : in  std_logic;
    btn_startstop : in  std_logic;
    d1, d2, d3, d4, d5, d6 : out std_logic_vector(3 downto 0)
  );
end stopwatch;

architecture Behavioral of stopwatch is
  signal seconds : integer range 0 to 3599 := 0;
  signal running : std_logic := '0';
  signal last_btn : std_logic := '0';

  type int_to_bin is array(0 to 9) of std_logic_vector(3 downto 0);
  constant int_bin : int_to_bin := (
    "0000","0001","0010","0011","0100",
    "0101","0110","0111","1000","1001"
  );
begin
  process(clk_1hz, reset)
  begin
    if reset = '1' then
      seconds <= 0;
      running <= '0';
      last_btn <= '0';
    elsif rising_edge(clk_1hz) then
      if btn_startstop = '1' and last_btn = '0' then
        running <= not running;
      end if;
      last_btn <= btn_startstop;

      if running = '1' then
        if seconds < 3599 then
          seconds <= seconds + 1;
        else
          seconds <= 0;
        end if;
      end if;
    end if;
  end process;

  d1 <= int_bin((seconds mod 60) mod 10);
  d2 <= int_bin((seconds mod 60) / 10);
  d3 <= int_bin(((seconds / 60) mod 10));
  d4 <= int_bin(((seconds / 60) / 10));
  d5 <= "0000";
  d6 <= "0000";
end Behavioral;
