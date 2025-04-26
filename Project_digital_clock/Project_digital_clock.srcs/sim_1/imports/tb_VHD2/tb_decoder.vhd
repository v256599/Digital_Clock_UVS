library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_decoder is
end tb_decoder;

architecture Behavioral of tb_decoder is
  signal digit1, digit2, digit3, digit4, digit5, digit6 : std_logic_vector(3 downto 0) := (others => '0');
  signal WhichDisplay : std_logic_vector(2 downto 0) := "000";
  signal segments     : std_logic_vector(7 downto 0);
begin
  uut: entity work.decoder
    port map (
      digit1 => digit1,
      digit2 => digit2,
      digit3 => digit3,
      digit4 => digit4,
      digit5 => digit5,
      digit6 => digit6,
      WhichDisplay => WhichDisplay,
      segments => segments
    );

  stimulus : process
  begin
    -- Nastavíme hodnoty na jednotlivé číslice
    digit1 <= "0000"; -- 0
    digit2 <= "0001"; -- 1
    digit3 <= "0010"; -- 2
    digit4 <= "0011"; -- 3
    digit5 <= "0100"; -- 4
    digit6 <= "0101"; -- 5
    wait for 50 ns;

    -- Projdeme všechny číslice přes WhichDisplay
    for i in 0 to 5 loop
      WhichDisplay <= std_logic_vector(to_unsigned(i, 3));
      wait for 50 ns;
    end loop;

    wait;
  end process;
end Behavioral;
