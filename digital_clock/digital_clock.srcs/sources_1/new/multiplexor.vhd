library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity multiplexor is
    Port (
        mode        : in  STD_LOGIC_VECTOR(1 downto 0);  -- 00=?as, 01=datum, 10=budík, 11=stopky

        -- Vstupy:
        time_hours    : in  STD_LOGIC_VECTOR(4 downto 0);
        time_minutes  : in  STD_LOGIC_VECTOR(5 downto 0);
        time_seconds  : in  STD_LOGIC_VECTOR(5 downto 0);

        date_day      : in  STD_LOGIC_VECTOR(4 downto 0);
        date_month    : in  STD_LOGIC_VECTOR(3 downto 0);
        date_year     : in  STD_LOGIC_VECTOR(11 downto 0); -- nap?. 2025

        alarm_hours   : in  STD_LOGIC_VECTOR(4 downto 0);
        alarm_minutes : in  STD_LOGIC_VECTOR(5 downto 0);

        sw_minutes    : in  STD_LOGIC_VECTOR(5 downto 0);
        sw_seconds    : in  STD_LOGIC_VECTOR(5 downto 0);
        sw_ms         : in  STD_LOGIC_VECTOR(6 downto 0);

        digits        : out STD_LOGIC_VECTOR(31 downto 0); -- 8 ?íslic (8x 4 bity)
        dp            : out STD_LOGIC_VECTOR(7 downto 0)   -- desetinné te?ky
    );
end multiplexor;

architecture Behavioral of multiplexor is

    -- pomocná funkce
    function bin_to_bcd(val : STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
        variable num : integer := to_integer(unsigned(val));
        variable bcd : STD_LOGIC_VECTOR(7 downto 0);
    begin
        bcd(7 downto 4) := std_logic_vector(to_unsigned(num / 10, 4));
        bcd(3 downto 0) := std_logic_vector(to_unsigned(num mod 10, 4));
        return bcd;
    end function;

    signal dig : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal dots : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');

begin

    process(mode, time_hours, time_minutes, time_seconds,
            date_day, date_month, date_year,
            alarm_hours, alarm_minutes,
            sw_minutes, sw_seconds, sw_ms)
        variable h_bcd, m_bcd, s_bcd, d_bcd, mo_bcd, y_hi, y_lo, ms_bcd : STD_LOGIC_VECTOR(7 downto 0);
    begin
        -- výchozí
        dig  <= (others => '0');
        dots <= (others => '0');

        case mode is
            when "00" =>  -- ?AS: HHMMSS
                h_bcd := bin_to_bcd(time_hours);
                m_bcd := bin_to_bcd(time_minutes);
                s_bcd := bin_to_bcd(time_seconds);

                dig(31 downto 28) <= h_bcd(7 downto 4);
                dig(27 downto 24) <= h_bcd(3 downto 0);
                dig(23 downto 20) <= m_bcd(7 downto 4);
                dig(19 downto 16) <= m_bcd(3 downto 0);
                dig(15 downto 12) <= s_bcd(7 downto 4);
                dig(11 downto  8) <= s_bcd(3 downto 0);

            when "01" =>  -- DATUM: DD.MM.RRRR
                d_bcd  := bin_to_bcd(date_day);
                mo_bcd := bin_to_bcd(date_month);
                y_hi   := bin_to_bcd(date_year(11 downto 6));
                y_lo   := bin_to_bcd(date_year(5 downto 0));

                dig(31 downto 28) <= d_bcd(7 downto 4);
                dig(27 downto 24) <= d_bcd(3 downto 0);
                dig(23 downto 20) <= mo_bcd(7 downto 4);
                dig(19 downto 16) <= mo_bcd(3 downto 0);
                dig(15 downto 12) <= y_hi(7 downto 4);
                dig(11 downto  8) <= y_hi(3 downto 0);
                dig( 7 downto  4) <= y_lo(7 downto 4);
                dig( 3 downto  0) <= y_lo(3 downto 0);

                -- desetinné te?ky za dnem a m?sícem (pozice AN[6] a AN[4] nap?.)
                dots(6) <= '1';
                dots(4) <= '1';

            when "10" =>  -- BUDÍK: HHMM
                h_bcd := bin_to_bcd(alarm_hours);
                m_bcd := bin_to_bcd(alarm_minutes);

                dig(31 downto 28) <= h_bcd(7 downto 4);
                dig(27 downto 24) <= h_bcd(3 downto 0);
                dig(23 downto 20) <= m_bcd(7 downto 4);
                dig(19 downto 16) <= m_bcd(3 downto 0);

            when others =>  -- STOPKY: MMSSMS
                m_bcd   := bin_to_bcd(sw_minutes);
                s_bcd   := bin_to_bcd(sw_seconds);
                ms_bcd  := bin_to_bcd(sw_ms(6 downto 0));  -- stovky milisekund

                dig(31 downto 28) <= m_bcd(7 downto 4);
                dig(27 downto 24) <= m_bcd(3 downto 0);
                dig(23 downto 20) <= s_bcd(7 downto 4);
                dig(19 downto 16) <= s_bcd(3 downto 0);
                dig(15 downto 12) <= ms_bcd(7 downto 4);
                dig(11 downto  8) <= ms_bcd(3 downto 0);
        end case;
    end process;

    digits <= dig;
    dp     <= dots;

end Behavioral;