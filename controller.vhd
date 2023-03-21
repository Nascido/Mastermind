library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity controller is
    port (
        -- Entradas de Fora
        enter, reset: in std_logic;
        clock500: in std_logic;
        
        -- Entradas de Datapath
        end_game: in std_logic;
        end_time: in std_logic;
        end_round: in std_logic;

        -- Saï¿½das
        R1, R2: out std_logic;
        E1, E2, E3, E4, E5: out std_logic

    );
end entity controller;

architecture fsm_arch of controller is
    type STATES is (INIT, SETUP, PLAY, COUNT_ROUND, CHECK, WAIT_PLAY, RESULT);
    signal EstadoAtual, ProximoEstado: STATES;
begin
    REG: process(EstadoAtual, clock500, reset, end_time)
    begin
        if(reset = '1') then
            EstadoAtual <= INIT;
        
        elsif ((EstadoAtual = PLAY) and (end_time = '1')) then
            EstadoAtual <= Result;

        elsif (clock500'event AND clock500 = '1') then
            EstadoAtual <= ProximoEstado;

        end if;
    end process;

    CMB: process(EstadoAtual, enter, end_round, end_game)
    begin
        case EstadoAtual is
            when INIT =>
                R1 <= '1';
                R2 <= '1';
                E1 <= '0';
                E2 <= '0';
                E3 <= '0';
                E4 <= '0';
                E5 <= '0';

                ProximoEstado <= SETUP;
        
            when SETUP =>
                R1 <= '0';
                R2 <= '0';
                E1 <= '1';
                E2 <= '0';
                E3 <= '0';
                E4 <= '0';
                E5 <= '0';

                if (enter = '1') then
                    ProximoEstado <= PLAY;
                else
                    ProximoEstado <= SETUP;
                end if;

            when PLAY =>
                R1 <= '0';
                R2 <= '0';
                E1 <= '0';
                E2 <= '1';
                E3 <= '0';
                E4 <= '0';
                E5 <= '0';

                if (enter = '1') then
                    ProximoEstado <= COUNT_ROUND;
                else
                    ProximoEstado <= PLAY;
                end if;
            
            when COUNT_ROUND =>
                R1 <= '0';
                R2 <= '0';
                E1 <= '0';
                E2 <= '0';
                E3 <= '1';
                E4 <= '0';
                E5 <= '0';
    
                ProximoEstado <= CHECK;

            when CHECk =>
                R1 <= '0';
                R2 <= '0';
                E1 <= '0';
                E2 <= '0';
                E3 <= '0';
                E4 <= '1';
                E5 <= '0';
                
                if ((end_round='1') or (end_game='1')) then
                    ProximoEstado <= RESULT;
                else
                    ProximoEstado <= WAIT_PLAY;
                end if;
            
            when WAIT_PLAY =>
                R1 <= '1';
                R2 <= '0';
                E1 <= '0';
                E2 <= '0';
                E3 <= '0';
                E4 <= '0';
                E5 <= '0';
                
                if (enter = '1') then
                    ProximoEstado <= PLAY;
                else
                    ProximoEstado <= WAIT_PLAY;
                end if;
        
            when RESULT =>
                R1 <= '0';
                R2 <= '0';
                E1 <= '0';
                E2 <= '0';
                E3 <= '0';
                E4 <= '0';
                E5 <= '1';

                if (enter = '1') then
                    ProximoEstado <= INIT;
                else
                    ProximoEstado <= RESULT;
                end if;

        end case;
    end process;

end architecture fsm_arch;