library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all; 
use ieee.std_logic_unsigned.all;

entity Soma_P is
    port(
        P0, P1, P2, P3: in std_logic;
        P: out std_logic_vector(2 downto 0));
end Soma_P;

architecture behavior of Soma_P is
    signal cnt: std_logic_vector(2 downto 0);
    
begin
    process(P0, P1, P2, P3)
    variable ref: std_logic_vector(2 downto 0) := "000";
    begin
        ref := "000";
        if (P0 = '1') then
            ref := ref + "001";
        end if;
        if (P1 = '1') then
            ref := ref + "001";
        end if;
        if (P2 = '1') then
            ref := ref + "001";
        end if;
        if (P3 = '1') then
            ref := ref + "001";
        end if;
        cnt <= ref;
    end process;

    P <= cnt;
end behavior;