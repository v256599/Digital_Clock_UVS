library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity anode_picker is
  port (
    WhichDisplay : in  std_logic_vector(2 downto 0);
    anode        : out std_logic_vector(7 downto 0)
  );
end anode_picker;

architecture Behavioral of anode_picker is
begin
  process(WhichDisplay)
  begin
    case WhichDisplay is
      when "000" => anode <= "01111111";
      when "001" => anode <= "10111111";
      when "010" => anode <= "11011111";
      when "011" => anode <= "11101111";
      when "100" => anode <= "11110111";
      when "101" => anode <= "11111011";
      when others => anode <= (others => '1');
    end case;
  end process;
end Behavioral;
