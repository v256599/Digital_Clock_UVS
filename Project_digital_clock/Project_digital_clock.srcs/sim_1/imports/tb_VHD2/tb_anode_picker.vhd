library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_anode_picker is
end tb_anode_picker;

architecture Behavioral of tb_anode_picker is
  signal WhichDisplay : std_logic_vector(2 downto 0) := (others => '0');
  signal anode        : std_logic_vector(7 downto 0);
begin
  uut: entity work.anode_picker
    port map (
      WhichDisplay => WhichDisplay,
      anode => anode
    );

  stimulus : process
  begin
    for i in 0 to 5 loop
      WhichDisplay <= std_logic_vector(to_unsigned(i, 3));
      wait for 50 ns;
    end loop;
    wait;
  end process;
end Behavioral;
