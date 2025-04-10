library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mode_manual_date is
    Port (
        clk        : in  STD_LOGIC;
        rst        : in  STD_LOGIC;
        sel_left   : in  STD_LOGIC;  -- BTNL
        sel_right  : in  STD_LOGIC;  -- BTNR
        btn_up     : in  STD_LOGIC;  -- BTNU
        btn_down   : in  STD_LOGIC;  -- BTND
        btn_ok     : in  STD_LOGIC;

        set_day    : out STD_LOGIC_VECTOR(4 downto 0);  -- 1-31
        set_month  : out STD_LOGIC_VECTOR(3 downto 0);  -- 1-12
        set_year   : out STD_LOGIC_VECTOR(11 downto 0); -- 0-4095 (nap?. 2025)
        load_date  : out STD_LOGIC
    );
end mode_manual_date;

architecture Behavioral of mode_manual_date is
    type FIELD_TYPE is (DAY, MONTH, YEAR);
    signal current_field : FIELD_TYPE := DAY;

    signal d : STD_LOGIC_VECTOR(4 downto 0) := "00001";  -- 1
    signal m : STD_LOGIC_VECTOR(3 downto 0) := "0001";   -- 1
    signal y : STD_LOGIC_VECTOR(11 downto 0) := "011111010001"; -- 2025

    signal load_date_int : STD_LOGIC := '0';
begin

    process(clk, rst)
    begin
        if rst = '1' then
            current_field <= DAY;
            d <= "00001";
            m <= "0001";
            y <= "011111010001"; -- 2025
            load_date_int <= '0';

        elsif rising_edge(clk) then
            load_date_int <= '0';

            -- Výb?r pole
            if sel_left = '1' then
                case current_field is
                    when MONTH => current_field <= DAY;
                    when YEAR  => current_field <= MONTH;
                    when others => null;
                end case;
            elsif sel_right = '1' then
                case current_field is
                    when DAY   => current_field <= MONTH;
                    when MONTH => current_field <= YEAR;
                    when others => null;
                end case;
            end if;

            -- Inkrementace / dekrementace
            if btn_up = '1' then
                case current_field is
                    when DAY =>
                        if d = "11111" then d <= "00001"; else d <= d + 1; end if;
                    when MONTH =>
                        if m = "1100" then m <= "0001"; else m <= m + 1; end if;
                    when YEAR =>
                        if y = "111111111111" then y <= "000000000000"; else y <= y + 1; end if;
                end case;
            elsif btn_down = '1' then
                case current_field is
                    when DAY =>
                        if d = "00001" then d <= "11111"; else d <= d - 1; end if;
                    when MONTH =>
                        if m = "0001" then m <= "1100"; else m <= m - 1; end if;
                    when YEAR =>
                        if y = "000000000000" then y <= "111111111111"; else y <= y - 1; end if;
                end case;
            end if;

            -- Potvrzení
            if btn_ok = '1' then
                load_date_int <= '1';
            end if;
        end if;
    end process;

    set_day   <= d;
    set_month <= m;
    set_year  <= y;
    load_date <= load_date_int;

end Behavioral;