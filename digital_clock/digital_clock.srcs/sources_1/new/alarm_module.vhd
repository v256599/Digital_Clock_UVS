library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity alarm_module is
    Port (
        clk           : in  STD_LOGIC;
        rst           : in  STD_LOGIC;
        load_alarm    : in  STD_LOGIC;  -- uloží nastavení
        set_hours     : in  STD_LOGIC_VECTOR(4 downto 0); -- 0-23
        set_minutes   : in  STD_LOGIC_VECTOR(5 downto 0); -- 0-59
        current_hours : in  STD_LOGIC_VECTOR(4 downto 0);
        current_minutes : in  STD_LOGIC_VECTOR(5 downto 0);
        alarm_trigger : out STD_LOGIC
    );
end alarm_module;

architecture Behavioral of alarm_module is
    signal alarm_h : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');
    signal alarm_m : STD_LOGIC_VECTOR(5 downto 0) := (others => '0');
    signal trigger : STD_LOGIC := '0';
begin

    process(clk, rst)
    begin
        if rst = '1' then
            alarm_h <= (others => '0');
            alarm_m <= (others => '0');
            trigger <= '0';
        elsif rising_edge(clk) then
            -- Uložení nového ?asu budíku
            if load_alarm = '1' then
                alarm_h <= set_hours;
                alarm_m <= set_minutes;
            end if;

            -- Aktivace p?i shod?
            if (current_hours = alarm_h) and (current_minutes = alarm_m) then
                trigger <= '1';
            else
                trigger <= '0';
            end if;
        end if;
    end process;

    alarm_trigger <= trigger;
end Behavioral;