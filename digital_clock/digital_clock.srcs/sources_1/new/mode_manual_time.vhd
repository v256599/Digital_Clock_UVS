library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mode_manual_time is
    Port (
        clk         : in  STD_LOGIC;
        rst         : in  STD_LOGIC;
        sel_left    : in  STD_LOGIC;  -- BTNL
        sel_right   : in  STD_LOGIC;  -- BTNR
        btn_up      : in  STD_LOGIC;  -- BTNU
        btn_down    : in  STD_LOGIC;  -- BTND
        btn_ok      : in  STD_LOGIC;

        set_hours   : out STD_LOGIC_VECTOR(4 downto 0);
        set_minutes : out STD_LOGIC_VECTOR(5 downto 0);
        load_time   : out STD_LOGIC;
        active_field: out STD_LOGIC   -- '0' = hodiny, '1' = minuty
    );
end mode_manual_time;

architecture Behavioral of mode_manual_time is
    type FIELD_TYPE is (HOURS, MINUTES);
    signal current_field : FIELD_TYPE := HOURS;

    signal h : STD_LOGIC_VECTOR(4 downto 0) := "00000";
    signal m : STD_LOGIC_VECTOR(5 downto 0) := "000000";

    signal load_time_int : STD_LOGIC := '0';
begin

    process(clk, rst)
    begin
        if rst = '1' then
            current_field <= HOURS;
            h <= (others => '0');
            m <= (others => '0');
            load_time_int <= '0';

        elsif rising_edge(clk) then
            load_time_int <= '0';

            -- Výb?r pole: hodiny / minuty
            if sel_left = '1' then
                current_field <= HOURS;
            elsif sel_right = '1' then
                current_field <= MINUTES;
            end if;

            -- Inkrementace / dekrementace
            if btn_up = '1' then
                if current_field = HOURS then
                    if h = "10111" then
                        h <= "00000";
                    else
                        h <= h + 1;
                    end if;
                else
                    if m = "111011" then
                        m <= "000000";
                    else
                        m <= m + 1;
                    end if;
                end if;
            elsif btn_down = '1' then
                if current_field = HOURS then
                    if h = "00000" then
                        h <= "10111";
                    else
                        h <= h - 1;
                    end if;
                else
                    if m = "000000" then
                        m <= "111011";
                    else
                        m <= m - 1;
                    end if;
                end if;
            end if;

            -- Potvrzení
            if btn_ok = '1' then
                load_time_int <= '1';
            end if;
        end if;
    end process;

    set_hours    <= h;
    set_minutes  <= m;
    load_time    <= load_time_int;
    active_field <= '0' when current_field = HOURS else '1';

end Behavioral;