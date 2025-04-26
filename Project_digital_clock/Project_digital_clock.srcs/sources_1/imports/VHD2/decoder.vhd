library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity decoder is
  port (
    digit1, digit2, digit3, digit4, digit5, digit6 : in  std_logic_vector(3 downto 0);
    WhichDisplay                                  : in  std_logic_vector(2 downto 0);
    segments                                      : out std_logic_vector(7 downto 0)
  );
end decoder;

architecture Behavioral of decoder is
  type disp_arr is array(0 to 9) of std_logic_vector(7 downto 0);
  constant conv : disp_arr := (
    "11000000","11111001","10100100","10110000",
    "10011001","10010010","10000010","11111000",
    "10000000","10010000"
  );
  signal tmp : std_logic_vector(7 downto 0);
begin
  process(WhichDisplay, digit1, digit2, digit3, digit4, digit5, digit6)
  begin
    case WhichDisplay is
      when "000" => tmp <= conv(to_integer(unsigned(digit1)));
      when "001" => tmp <= conv(to_integer(unsigned(digit2)));
      when "010" => tmp <= conv(to_integer(unsigned(digit3)));
      when "011" => tmp <= conv(to_integer(unsigned(digit4)));
      when "100" => tmp <= conv(to_integer(unsigned(digit5)));
      when "101" => tmp <= conv(to_integer(unsigned(digit6)));
      when others => tmp <= (others => '1');
    end case;
  end process;
  segments <= tmp;
end Behavioral;