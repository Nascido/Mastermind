library ieee;
use ieee.std_logic_1164.all;

entity CompIsEqual4 is
    port(
        P: in std_logic_vector(2 downto 0);
        EndGame: out std_logic);
end CompIsEqual4;

architecture behavior of CompIsEqual4 is
begin
    process(P)
    begin
        if (P = "100") then
            EndGame <= '1';
        else
            EndGame <= '0';
        end if;
    end process;
end behavior;