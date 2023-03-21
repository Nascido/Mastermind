library ieee;
use ieee.std_logic_1164.all;

entity reg6bits is port (
    CLK_500hz: in std_logic;
    EN: in std_logic;
    RST: in std_logic;
    D: in std_logic_vector(5 downto 0);
    Q: out std_logic_vector(5 downto 0));
end reg6bits;

architecture behv of reg6bits is
begin
    process(CLK_500hz, RST)
    begin
        if (RST = '1') then
            Q <= "000000";
        elsif (CLK_500hz'event and CLK_500hz = '1') then
            if (EN = '1') then
                Q <= D;
            end if;
        end if;
    end process;
end behv;