library ieee;
use ieee.std_logic_1164.all;

entity mux4x1 is
    port(
        in00, in01, in10, in11: in std_logic_vector(6 downto 0);
        SelMux: in std_logic_vector(1 downto 0);
        dataout: out std_logic_vector(6 downto 0)
    );
end mux4x1;

architecture behavior of mux4x1 is
begin
    process(SelMux, in00, in01, in10, in11)
    begin
        case SelMux is
            when "00" => dataout <= in00;
            when "01" => dataout <= in01;
            when "10" => dataout <= in10;
            when "11" => dataout <= in11;
            when others => dataout <= "0000000";
        end case;
    end process;
end behavior;