library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity date_display is
  port (
    clk_1hz   : in  std_logic;
    reset     : in  std_logic;
    btn_up    : in  std_logic;
    btn_down  : in  std_logic;
    btn_next  : in  std_logic;
    d1, d2, d3, d4, d5, d6 : out std_logic_vector(3 downto 0)
  );
end date_display;

architecture Behavioral of date_display is
  signal day    : integer range 1 to 31 := 1;
  signal month  : integer range 1 to 12 := 1;
  signal year   : integer range 0 to 99 := 24;
  signal cursor : integer range 0 to 2 := 0;

  type int_to_bin is array(0 to 9) of std_logic_vector(3 downto 0);
  constant int_bin : int_to_bin := (
    "0000","0001","0010","0011","0100",
    "0101","0110","0111","1000","1001"
  );
begin
  process(clk_1hz, reset)
  begin
    if reset = '1' then
      day <= 1;
      month <= 1;
      year <= 24;
      cursor <= 0;
    elsif rising_edge(clk_1hz) then
      if btn_next = '1' then
        if cursor = 2 then cursor <= 0;
        else cursor <= cursor + 1;
        end if;
      elsif btn_up = '1' then
        case cursor is
          when 0 => if day < 31 then day <= day + 1; end if;
          when 1 => if month < 12 then month <= month + 1; end if;
          when 2 => if year < 99 then year <= year + 1; end if;
          when others => null;
        end case;
      elsif btn_down = '1' then
        case cursor is
          when 0 => if day > 1 then day <= day - 1; end if;
          when 1 => if month > 1 then month <= month - 1; end if;
          when 2 => if year > 0 then year <= year - 1; end if;
          when others => null;
        end case;
      end if;
    end if;
  end process;

  d1 <= int_bin(day mod 10);
  d2 <= int_bin(day / 10);
  d3 <= int_bin(month mod 10);
  d4 <= int_bin(month / 10);
  d5 <= int_bin(year mod 10);
  d6 <= int_bin(year / 10);
end Behavioral;
