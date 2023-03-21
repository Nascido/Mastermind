library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity usertop is
    port (
        CLK_1Hz, CLK_500Hz  : in std_logic;
        KEY : in std_logic_vector(1 downto 0);
        SW  : in std_logic_vector(15 downto 0);

        LEDR : out std_logic_vector (15 downto 0);

        HEX0, HEX1, HEX2, HEX3 : out  std_logic_vector(6 downto 0);
        HEX4, HEX5, HEX6, HEX7 : out  std_logic_vector(6 downto 0)
    );
end entity;

architecture arch of usertop is
    signal s_enter, s_reset : std_logic;
    signal sR1, sR2, sE1, sE2, sE3, sE4, sE5: std_logic;
    signal s_end_game, s_end_round, s_end_time: std_logic;
    
    component ButtonSync is port(
        KEY0, KEY1, CLK: in  std_logic;
        Enter, Reset   : out std_logic);
    end component;

    component controller is
        port (
            -- Entradas de Fora
            enter, reset: in std_logic;
            clock500: in std_logic;
            
            -- Entradas de Datapath
            end_game: in std_logic;
            end_time: in std_logic;
            end_round: in std_logic;
    
            -- Saídas
            R1, R2: out std_logic;
            E1, E2, E3, E4, E5: out std_logic
        );
    end component;

    component datapath is port( 
    
        Switches                     : in  std_logic_vector(15 downto 0);
        Clock1, Clock500             : in  std_logic;
        R1, R2                       : in  std_logic;
        E1, E2, E3, E4, E5           : in  std_logic;
        ledr                         : out std_logic_vector(15 downto 0);
        hex0, hex1, hex2, hex3       : out std_logic_vector(6 downto 0);
        hex4, hex5, hex6, hex7       : out std_logic_vector(6 downto 0);
        end_game, end_time, end_round: out std_logic);
        
    end component;

begin
    SYNC: ButtonSync port map (KEY(0), KEY(1), CLK_500Hz, s_Enter, s_Reset);
    
    CNTR: Controller port map (s_Enter, s_Reset, CLK_500Hz, 
                            s_end_game, s_end_time, s_end_round,
                            sR1, sR2, sE1, sE2, sE3, sE4, sE5  
                            );

    DATA: Datapath port map (SW, CLK_1Hz, CLK_500Hz, 
                            sR1, sR2, sE1, sE2, sE3, sE4, sE5, 
                            LEDR, HEX0, HEX1, HEX2, HEX3, 
                            HEX4, HEX5, HEX6, HEX7,
                            s_end_game, s_end_time, s_end_round
                            );

end architecture arch;