library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity time_counter is
    Port (
        clk_1Hz     : in  STD_LOGIC;    -- hodinový impuls 1 Hz
        rst         : in  STD_LOGIC;    -- reset
        load_time   : in  STD_LOGIC;    -- aktivace nahrání nové hodnoty
        set_hours   : in  STD_LOGIC_VECTOR(4 downto 0); -- 0–23
        set_minutes : in  STD_LOGIC_VECTOR(5 downto 0); -- 0–59
        hours       : out STD_LOGIC_VECTOR(4 downto 0);
        minutes     : out STD_LOGIC_VECTOR(5 downto 0)
    );
end time_counter;

architecture Behavioral of time_counter is
    signal h : STD_LOGIC_VECTOR(4 downto 0) := "00000";
    signal m : STD_LOGIC_VECTOR(5 downto 0) := "000000";
begin
    process(clk_1Hz, rst)
    begin
        if rst = '1' then
            h <= "00000";
            m <= "000000";
        elsif rising_edge(clk_1Hz) then
            if load_time = '1' then
                h <= set_hours;
                m <= set_minutes;
            else
                if m = "111011" then  -- 59
                    m <= "000000";
                    if h = "10111" then  -- 23
                        h <= "00000";
                    else
                        h <= h + 1;
                    end if;
                else
                    m <= m + 1;
                end if;
            end if;
        end if;
    end process;

    hours <= h;
    minutes <= m;
end Behavioral;