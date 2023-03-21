library ieee;
use ieee.std_Logic_1164.all;
use ieee.std_logic_arith.all; 
use ieee.std_logic_unsigned.all;

entity Counter_round is port(
    RST: in std_logic;
    EN: in std_logic;
    CLK_500hz: in std_logic;
    EndRound: out std_logic;
    X: out std_logic_vector(3 downto 0));
end Counter_round;

architecture behv of Counter_round is
    signal rounds: std_logic_vector(3 downto 0) := "0000";
    signal IsEndRound: std_logic := '0';
begin
    process(CLK_500hz, RST, EN)
    begin
        if (RST = '1') then
            rounds <= "0000";
            IsEndRound <= '0';
        elsif (EN = '1' and IsEndRound = '0') then
            if (CLK_500hz'event and CLK_500hz = '1') then
                rounds <= rounds + "0001";
                if (rounds = "1111") then
                    IsEndRound <= '1';
                end if ;
            end if;
        end if;
    end process;

    EndRound <= IsEndRound;
    X <= rounds;
end behv;