library ieee;
use ieee.std_logic_1164.all;

entity Comp_3 is
    port(
        USER: in std_logic_vector(15 downto 12);
        CODE: in std_logic_vector(15 downto 12);
        ISEQUAL: out std_logic);
end Comp_3;

architecture behavior of Comp_3 is
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