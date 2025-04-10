library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity date_register is
    Port (
        clk           : in  STD_LOGIC;
        rst           : in  STD_LOGIC;
        load_date     : in  STD_LOGIC;
        set_day       : in  STD_LOGIC_VECTOR(4 downto 0);
        set_month     : in  STD_LOGIC_VECTOR(3 downto 0);
        set_year      : in  STD_LOGIC_VECTOR(11 downto 0);
        current_day   : out STD_LOGIC_VECTOR(4 downto 0);
        current_month : out STD_LOGIC_VECTOR(3 downto 0);
        current_year  : out STD_LOGIC_VECTOR(11 downto 0)
    );
end date_register;

architecture Behavioral of date_register is
    signal day_reg   : STD_LOGIC_VECTOR(4 downto 0) := "00001";   -- 1
    signal month_reg : STD_LOGIC_VECTOR(3 downto 0) := "0001";    -- 1
    signal year_reg  : STD_LOGIC_VECTOR(11 downto 0) := "011111010001"; -- 2025
begin

    process(clk, rst)
    begin
        if rst = '1' then
            day_reg   <= "00001";
            month_reg <= "0001";
            year_reg  <= "011111010001"; -- 2025
        elsif rising_edge(clk) then
            if load_date = '1' then
                day_reg   <= set_day;
                month_reg <= set_month;
                year_reg  <= set_year;
            end if;
        end if;
    end process;

    current_day   <= day_reg;
    current_month <= month_reg;
    current_year  <= year_reg;

end Behavioral;