library IEEE;
use IEEE.Std_Logic_1164.all;

entity DECODER_TERMOMETRICO is port (
    X:  in std_logic_vector(3 downto 0);
    TERMO:  out std_logic_vector(15 downto 0));
end DECODER_TERMOMETRICO;

architecture behv of DECODER_TERMOMETRICO is
    begin
        process(X)
        begin
            case X is
                when "0000" => TERMO <= "0000000000000001";
                when "0001" => TERMO <= "0000000000000011";
                when "0010" => TERMO <= "0000000000000111";
                when "0011" => TERMO <= "0000000000001111";
                when "0100" => TERMO <= "0000000000011111";
                when "0101" => TERMO <= "0000000000111111";
                when "0110" => TERMO <= "0000000001111111";
                when "0111" => TERMO <= "0000000011111111";
                when "1000" => TERMO <= "0000000111111111";
                when "1001" => TERMO <= "0000001111111111";
                when "1010" => TERMO <= "0000011111111111";
                when "1011" => TERMO <= "0000111111111111";
                when "1100" => TERMO <= "0001111111111111";
                when "1101" => TERMO <= "0011111111111111";
                when "1110" => TERMO <= "0111111111111111";
                when "1111" => TERMO <= "1111111111111111";
                when others => TERMO <= "0000000000000000";
            end case;
        end process;
end behv;
