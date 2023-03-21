library ieee;
use ieee.std_logic_1164.all;

entity Comp_2 is
    port(
        USER: in std_logic_vector(11 downto 8);
        CODE: in std_logic_vector(11 downto 8);
        ISEQUAL: out std_logic);
end Comp_2;

architecture behavior of Comp_2 is
begin
    process(USER, CODE)
    begin
        if USER = CODE then
            ISEQUAL <= '1';
        else
            ISEQUAL <= '0';
        end if;
    end process;
end behavior;