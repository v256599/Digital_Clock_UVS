library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity clock_divider is
    Port ( clk       : in  STD_LOGIC;
           clk_1Hz   : out STD_LOGIC;
           clk_100Hz : out STD_LOGIC);
end clock_divider;

architecture Behavioral of clock_divider is
    signal counter_1Hz   : INTEGER := 0;
    signal counter_100Hz : INTEGER := 0;
    signal clk_1Hz_int   : STD_LOGIC := '0';
    signal clk_100Hz_int : STD_LOGIC := '0';
begin
    process(clk)
    begin
        if rising_edge(clk) then
            -- 1Hz clock
            if counter_1Hz = 50_000_000 - 1 then
                counter_1Hz <= 0;
                clk_1Hz_int <= not clk_1Hz_int;
            else
                counter_1Hz <= counter_1Hz + 1;
            end if;

            -- 100Hz clock
            if counter_100Hz = 500_000 - 1 then
                counter_100Hz <= 0;
                clk_100Hz_int <= not clk_100Hz_int;
            else
                counter_100Hz <= counter_100Hz + 1;
            end if;
        end if;
    end process;

    clk_1Hz   <= clk_1Hz_int;
    clk_100Hz <= clk_100Hz_int;
end Behavioral;