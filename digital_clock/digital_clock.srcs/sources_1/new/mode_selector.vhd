library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mode_selector is
    Port (
        clk     : in  STD_LOGIC;
        rst     : in  STD_LOGIC;
        btn_mode: in  STD_LOGIC;
        mode    : out STD_LOGIC_VECTOR(1 downto 0)  -- 2 bity = 4 režimy
    );
end mode_selector;

architecture Behavioral of mode_selector is
    signal current_mode : STD_LOGIC_VECTOR(1 downto 0) := "00";
    signal btn_prev     : STD_LOGIC := '0';
begin

    process(clk, rst)
    begin
        if rst = '1' then
            current_mode <= "00";
            btn_prev <= '0';
        elsif rising_edge(clk) then
            -- Detekce náb?žné hrany tla?ítka
            if (btn_prev = '0') and (btn_mode = '1') then
                if current_mode = "11" then
                    current_mode <= "00";
                else
                    current_mode <= current_mode + 1;
                end if;
            end if;
            btn_prev <= btn_mode;
        end if;
    end process;

    mode <= current_mode;

end Behavioral;