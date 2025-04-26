library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity clock_counter is
  port (
    clk_1hz      : in  std_logic;
    reset        : in  std_logic;
    btn_up       : in  std_logic;
    btn_down     : in  std_logic;
    btn_next     : in  std_logic;
    setting_mode : in  std_logic;  --  aktivní nastavování
    cursor       : inout integer range 0 to 1;  -- ukazatel hodiny/minuty
    d1, d2, d3, d4, d5, d6 : out std_logic_vector(3 downto 0)
  );
end clock_counter;

architecture Behavioral of clock_counter is
  signal hours   : integer range 0 to 23 := 0;
  signal minutes : integer range 0 to 59 := 0;
  signal seconds : integer range 0 to 59 := 0;

  type int_to_bin is array(0 to 9) of std_logic_vector(3 downto 0);
  constant int_bin : int_to_bin := (
    "0000","0001","0010","0011","0100",
    "0101","0110","0111","1000","1001"
  );
begin
  process(clk_1hz, reset)
  begin
    if reset = '1' then
      hours <= 0;
      minutes <= 0;
      seconds <= 0;
      cursor <= 0;
    elsif rising_edge(clk_1hz) then
      if setting_mode = '0' then
        -- normální režim: běžící čas
        if seconds < 59 then
          seconds <= seconds + 1;
        else
          seconds <= 0;
          if minutes < 59 then
            minutes <= minutes + 1;
          else
            minutes <= 0;
            if hours < 23 then
              hours <= hours + 1;
            else
              hours <= 0;
            end if;
          end if;
        end if;
      else
        -- nastavovací režim
        if btn_next = '1' then
          cursor <= 1 - cursor; -- přepnutí mezi hodinami a minutami
        elsif btn_up = '1' then
          if cursor = 0 then
            if minutes < 59 then minutes <= minutes + 1; else minutes <= 0; end if;
          else
            if hours < 23 then hours <= hours + 1; else hours <= 0; end if;
          end if;
        elsif btn_down = '1' then
          if cursor = 0 then
            if minutes > 0 then minutes <= minutes - 1; else minutes <= 59; end if;
          else
            if hours > 0 then hours <= hours - 1; else hours <= 23; end if;
          end if;
        end if;
      end if;
    end if;
  end process;

  -- Výstupy na displej
  d1 <= int_bin(seconds mod 10);
  d2 <= int_bin(seconds / 10);
  d3 <= int_bin(minutes mod 10);
  d4 <= int_bin(minutes / 10);
  d5 <= int_bin(hours mod 10);
  d6 <= int_bin(hours / 10);
end Behavioral;
