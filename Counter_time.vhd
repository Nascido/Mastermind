library ieee;
use ieee.std_Logic_1164.all;
use ieee.std_logic_arith.all; 
use ieee.std_logic_unsigned.all;

entity Counter_time is port(
    RST: in std_logic;
    EN: in std_logic;
    CLK_1hz: in std_logic;
    EndTime: out std_logic;
    CTime: out std_logic_vector(3 downto 0));
end Counter_time;

architecture behv of Counter_time is
    signal cnt: std_logic_vector(3 downto 0) := "0000";
    signal IsEndTime: std_logic := '0';
begin
    process(CLK_1hz, RST, EN)
    begin
        if (RST = '1') then
            cnt <= "0000";
            IsEndTime <= '0';
        elsif (EN = '1' and IsEndTime = '0') then
            if (CLK_1hz'event and CLK_1hz = '1') then
                cnt <= cnt + "0001";
                if (cnt = "1001") then
                    IsEndTime <= '1';
                end if ;
            end if;
        end if;
    end process;

    EndTime <= IsEndTime;
    CTime <= cnt;
end behv;