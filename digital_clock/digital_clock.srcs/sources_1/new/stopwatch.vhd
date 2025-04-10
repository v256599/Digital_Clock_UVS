library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity stopwatch is
    Port (
        clk_100Hz : in  STD_LOGIC;  -- 100Hz (z clock_divider)
        rst       : in  STD_LOGIC;
        start     : in  STD_LOGIC;
        stop      : in  STD_LOGIC;
        clear     : in  STD_LOGIC;
        sw_minutes : out STD_LOGIC_VECTOR(5 downto 0); -- max 59
        sw_seconds : out STD_LOGIC_VECTOR(5 downto 0); -- max 59
        sw_hundreds: out STD_LOGIC_VECTOR(6 downto 0)  -- max 99
    );
end stopwatch;

architecture Behavioral of stopwatch is
    signal running    : STD_LOGIC := '0';
    signal min        : STD_LOGIC_VECTOR(5 downto 0) := (others => '0');
    signal sec        : STD_LOGIC_VECTOR(5 downto 0) := (others => '0');
    signal hund       : STD_LOGIC_VECTOR(6 downto 0) := (others => '0');
begin

    process(clk_100Hz, rst)
    begin
        if rst = '1' then
            running <= '0';
            min     <= (others => '0');
            sec     <= (others => '0');
            hund    <= (others => '0');

        elsif rising_edge(clk_100Hz) then
            if clear = '1' then
                min  <= (others => '0');
                sec  <= (others => '0');
                hund <= (others => '0');
            end if;

            if start = '1' then
                running <= '1';
            elsif stop = '1' then
                running <= '0';
            end if;

            if running = '1' then
                if hund = "1100011" then  -- 99
                    hund <= (others => '0');
                    if sec = "111011" then  -- 59
                        sec <= (others => '0');
                        if min = "111011" then  -- 59
                            min <= (others => '0');  -- p?ete?ení
                        else
                            min <= min + 1;
                        end if;
                    else
                        sec <= sec + 1;
                    end if;
                else
                    hund <= hund + 1;
                end if;
            end if;
        end if;
    end process;

    sw_minutes  <= min;
    sw_seconds  <= sec;
    sw_hundreds <= hund;

end Behavioral;