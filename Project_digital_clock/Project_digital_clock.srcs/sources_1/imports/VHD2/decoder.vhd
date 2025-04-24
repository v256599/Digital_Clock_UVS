library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity decoder is
  port (
    digit1, digit2, digit3, digit4, digit5, digit6 : in  std_logic_vector(3 downto 0);
    WhichDisplay                                  : in  std_logic_vector(2 downto 0);
    dots                                          : in  std_logic_vector(5 downto 0);
    segments                                      : out std_logic_vector(7 downto 0)
  );
end decoder;

architecture Behavioral of decoder is
  type disp_arr is array(0 to 9) of std_logic_vector(6 downto 0);
  constant conv : disp_arr := (
    "1000000", "1111001", "0100100", "0110000",
    "0011001", "0010010", "0000010", "1111000",
    "0000000", "0010000"
  );
  signal tmp : std_logic_vector(7 downto 0);
begin
  process(WhichDisplay, digit1, digit2, digit3, digit4, digit5, digit6, dots)
    variable digit_value : std_logic_vector(3 downto 0);
  begin
    case WhichDisplay is
      when "000" => digit_value := digit1;
      when "001" => digit_value := digit2;
      when "010" => digit_value := digit3;
      when "011" => digit_value := digit4;
      when "100" => digit_value := digit5;
      when "101" => digit_value := digit6;
      when others => digit_value := "0000";
    end case;

    if to_integer(unsigned(digit_value)) >= 0 and to_integer(unsigned(digit_value)) <= 9 then
      tmp(6 downto 0) <= conv(to_integer(unsigned(digit_value)));
    else
      tmp(6 downto 0) <= "1111111";
    end if;

    case WhichDisplay is
      when "000" => tmp(7) <= not dots(0);
      when "001" => tmp(7) <= not dots(1);
      when "010" => tmp(7) <= not dots(2);
      when "011" => tmp(7) <= not dots(3);
      when "100" => tmp(7) <= not dots(4);
      when "101" => tmp(7) <= not dots(5);
      when others => tmp(7) <= '1';
    end case;
  end process;
  segments <= tmp;
end Behavioral;
