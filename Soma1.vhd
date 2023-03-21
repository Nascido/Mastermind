library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.std_logic_arith.all; 
use IEEE.std_logic_unsigned.all;

entity Soma1 is port (
    Xsum:  in std_logic_vector(3 downto 0);
    S:  out std_logic_vector(3 downto 0));
end Soma1;

architecture behv of Soma1 is
begin
    process(Xsum)
    begin
        S <= Xsum + "0001";
    end process;
end behv;