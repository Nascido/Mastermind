library ieee;
use ieee.std_logic_1164.all;

entity Comp_1 is
    port(
        USER: in std_logic_vector(7 downto 4);
        CODE: in std_logic_vector(7 downto 4);
        ISEQUAL: out std_logic);
end Comp_1;

architecture behavior of Comp_1 is
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