library ieee;
use ieee.std_logic_1164.all;

entity mux2x1 is
    port(
        in00, in01: in std_logic_vector(6 downto 0);
        sele2: in std_logic;
        dataout: out std_logic_vector(6 downto 0)
    );
end mux2x1;

architecture behavior of mux2x1 is
begin
    process(sele2, in00, in01)
    begin
        if sele2 = '0' then
            dataout <= in00;
        elsif sele2 = '1' then
            dataout <= in01;
        end if;
    end process;
end behavior;