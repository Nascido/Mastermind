library ieee;
use ieee.std_Logic_1164.all;
use ieee.std_logic_arith.all; 
use ieee.std_logic_unsigned.all;

entity datapath is port( 
    
    Switches                     : in  std_logic_vector(15 downto 0);
    Clock1, Clock500             : in  std_logic;
    R1, R2                       : in  std_logic;
    E1, E2, E3, E4, E5           : in  std_logic;
    ledr                         : out std_logic_vector(15 downto 0);
    hex0, hex1, hex2, hex3       : out std_logic_vector(6 downto 0);
    hex4, hex5, hex6, hex7       : out std_logic_vector(6 downto 0);
    end_game, end_time, end_round: out std_logic);
    
end datapath;


architecture arc_data of datapath is


signal code, user, s_dec_term, rom0_s, rom1_s, rom2_s, rom3_s: std_logic_vector(15 downto 0); 
signal result: std_logic_vector(7 downto 0);
signal h0_00, h0_01, h0_10, h0_11, h1_01, h1_11, h2_00, h2_01, h2_10, h2_11, h3_01, h3_11, h4_1, h6_1, h7_1: std_logic_vector(6 downto 0);
signal sel: std_logic_vector(5 downto 0);
signal time_c, X, s_soma, F: std_Logic_vector(3 downto 0);
signal bits4_sel, bits4p_reg, bits4e_reg: std_Logic_vector(3 downto 0);
signal P, P_reg, E, E_reg: std_logic_vector(2 downto 0);
signal sel_mux: std_logic_vector(1 downto 0);
signal end_gamee, end_timee, cmp0_s, cmp1_s, cmp2_s, cmp3_s: std_logic;

component reg3bits is port (
    CLK_500hz: in std_logic;
    EN: in std_logic;
    RST: in std_logic;
    D: in std_logic_vector(2 downto 0);
    Q: out std_logic_vector(2 downto 0));
end component;

component reg16bits is port(   
    CLK_500hz: in std_logic;
    EN: in std_logic;
    RST: in std_logic;
    D: in std_logic_vector(15 downto 0);
    Q: out std_logic_vector(15 downto 0));
end component;

component reg6bits is port(
    CLK_500hz: in std_logic;
    EN: in std_logic;
    RST: in std_logic;
    D: in std_logic_vector(5 downto 0);
    Q: out std_logic_vector(5 downto 0));
end component;

component ROM0 is port(
    address : in  std_logic_vector(3 downto 0);
    data    : out std_logic_vector(15 downto 0));
end component;

component ROM1 is port(
    address : in  std_logic_vector(3 downto 0);
    data    : out std_logic_vector(15 downto 0));
end component;

component ROM2 is port(
    address : in  std_logic_vector(3 downto 0);
    data    : out std_logic_vector(15 downto 0));
end component;

component ROM3 is port(
    address : in  std_logic_vector(3 downto 0);
    data    : out std_logic_vector(15 downto 0));
end component;

component mux4x1bits16 is port (
    in00, in01, in10, in11: in std_logic_vector(15 downto 0);
    SEL_MUX_ROM: in std_logic_vector(1 downto 0);
    dataout: out std_logic_vector(15 downto 0));
end component;

component mux4x1 is port (
    in00, in01, in10, in11: in std_logic_vector(6 downto 0);
    SelMux: in std_logic_vector(1 downto 0);
    dataout: out std_logic_vector(6 downto 0));
end component;

component mux2x1 is port (
    in00, in01: in std_logic_vector(6 downto 0);
    sele2: in std_logic;
    dataout: out std_logic_vector(6 downto 0));
end component;

component Comp_0 is port (        
    USER: in std_logic_vector(3 downto 0);
    CODE: in std_logic_vector(3 downto 0);
    ISEQUAL: out std_logic);
end component;

component Comp_1 is port (        
    USER: in std_logic_vector(7 downto 4);
    CODE: in std_logic_vector(7 downto 4);
    ISEQUAL: out std_logic);
end component;

component Comp_2 is port (        
    USER: in std_logic_vector(11 downto 8);
    CODE: in std_logic_vector(11 downto 8);
    ISEQUAL: out std_logic);
end component;

component Comp_3 is port (        
    USER: in std_logic_vector(15 downto 12);
    CODE: in std_logic_vector(15 downto 12);
    ISEQUAL: out std_logic);
end component;

component Soma_P is port (
    P0, P1, P2, P3: in std_logic;
    P: out std_logic_vector(2 downto 0));
end component;

component Soma1 is port (    
    Xsum:  in std_logic_vector(3 downto 0);
    S:  out std_logic_vector(3 downto 0));
end component;

component comp_e is port (    
    inc, inu: in  std_logic_vector(15 downto 0);
    E : out std_logic_vector(2 downto 0));
end component;

component decod_7seg is port (
    dec_in:  in std_logic_vector(3 downto 0);
    out_7seg:  out std_logic_vector(6 downto 0));
end component;

component CompIsEqual4 is port (
    P: in std_logic_vector(2 downto 0);
    EndGame: out std_logic);
end component;

component Counter_round is port (
    RST: in std_logic;
    EN: in std_logic;
    CLK_500hz: in std_logic;
    EndRound: out std_logic;
    X: out std_logic_vector(3 downto 0));
end component;

component Counter_time is port(
    RST: in std_logic;
    EN: in std_logic;
    CLK_1hz: in std_logic;
    EndTime: out std_logic;
    CTime: out std_logic_vector(3 downto 0));
end component;

component DECODER_TERMOMETRICO is port (
    X:  in std_logic_vector(3 downto 0);
    TERMO:  out std_logic_vector(15 downto 0));
end component;

component selector is port (   
    in0, in1, in2, in3: in  std_logic;
    saida: out std_logic_vector(1 downto 0));
end component;

begin

end_game <= end_gamee; --ao interligar a saida do comp=4, usar o signal end_gamee para evitar erros
end_time <= end_timee; --ao interligar a saida do counter_time, usar o signal end_timee para evitar erros

    selectHEXByMux: selector port map (
        in0 => E1, 
        in1 => E2,
        in2 => R1, 
        in3 => E5,
        saida => sel_mux(1 downto 0));

    sumOne: Soma1 port map (
        Xsum => X(3 downto 0),
        S => s_soma(3 downto 0));

    F(3 downto 0) <= "0000" when end_timee = '1' else not(s_soma(3 downto 0)) + "0010"; -- soma 1 para o complemento
                                                                                        -- soma 1 para o ajuste da diferenÃ§a de round no diagrama de estados
    result(7 downto 0) <= "000" & end_gamee & F(3 downto 0);
    -- Set user choice with reg16bits component 
    reguser: reg16bits port map(
                                CLK_500hz => Clock500,
                                EN => E2,
                                RST => R2, 
                                D => Switches(15 downto 0),
                                Q => user);

    --  set sel signal to ROMs
    regcode: reg6bits port map(
                                CLK_500hz => Clock500, 
                                EN => E1, 
                                RST => R2, 
                                D => Switches(5 downto 0), 
                                Q => sel(5 downto 0));

    -- Get rom sequence by sel key
    ROM0Sequence: ROM0 port map(
                                address => sel(5 downto 2), 
                                data => rom0_s(15 downto 0));

    ROM1Sequence: ROM1 port map(
                                address => sel(5 downto 2), 
                                data => rom1_s(15 downto 0));

    ROM2Sequence: ROM2 port map(
                                address => sel(5 downto 2), 
                                data => rom2_s(15 downto 0));

    ROM3Sequence: ROM3 port map(
                                address => sel(5 downto 2), 
                                data => rom3_s(15 downto 0));

    --Select CODE by ROM trough sel
    GetCodeSelected: mux4x1bits16 port map(
        in00 => rom0_s(15 downto 0), 
        in01 => rom1_s(15 downto 0), 
        in10 => rom2_s(15 downto 0), 
        in11 => rom3_s(15 downto 0), 
        SEL_MUX_ROM => sel(1 downto 0), 
        dataout => code(15 downto 0));

    IsEqualSequence0: Comp_0 port map(        
        USER => user(3 downto 0),
        CODE => code(3 downto 0),
        ISEQUAL => cmp0_s);
    
    IsEqualSequence1: Comp_1 port map(
        USER => user(7 downto 4),
        CODE => code(7 downto 4),
        ISEQUAL => cmp1_s);

    IsEqualSequence2: Comp_2 port map(
        USER => user(11 downto 8),
        CODE => code(11 downto 8),
        ISEQUAL => cmp2_s);

    IsEqualSequence3: Comp_3 port map(
        USER => user(15 downto 12),
        CODE => code(15 downto 12),
        ISEQUAL => cmp3_s);

    SumElementsEquals: Soma_P port map(
        P0 => cmp0_s, 
        P1 => cmp1_s, 
        P2 => cmp2_s, 
        P3 => cmp3_s, 
        P => P(2 downto 0));

    IsExistInMyCodeButInWrongPosition: comp_e port map(
        inc => code(15 downto 0), 
        inu => user(15 downto 0), 
        E => E(2 downto 0));

    isEndGame: CompIsEqual4 port map(
        P => P(2 downto 0),
        EndGame => end_gamee);

    regP: reg3bits port map (
        CLK_500hz => Clock500,
        EN => E4,
        RST => R2,
        D => P(2 downto 0),
        Q => P_reg(2 downto 0));

    regE: reg3bits port map(
        CLK_500hz => Clock500,
        EN => E4,
        RST => R2,
        D => E(2 downto 0),
        Q => E_reg(2 downto 0));

    isEndTime: Counter_time port map(    
        RST => R1,
        EN => E2,
        CLK_1hz => Clock1,
        EndTime => end_timee,
        CTime => time_c(3 downto 0));

    isEndRound: Counter_round port map (
        RST => R2,
        EN => E3,
        CLK_500hz => Clock500,
        EndRound => end_round,
        X => X(3 downto 0));

    SetRounds: DECODER_TERMOMETRICO port map (    
        X => X(3 downto 0),
        TERMO => s_dec_term(15 downto 0));
    
    ledr(15 downto 0) <= s_dec_term(15 downto 0) when E1 = '0' else "0000000000000000";

    -- format HEX0
    bits4_sel(3 downto 0) <= "00" & sel(1 downto 0);
    fh0_00dec7seg: decod_7seg port map (    
        dec_in => bits4_sel(3 downto 0),
        out_7seg => h0_00(6 downto 0));

    fh0_01dec7seg: decod_7seg port map (    
        dec_in => user(3 downto 0),
        out_7seg => h0_01(6 downto 0));
    
    bits4e_reg(3 downto 0) <= '0' & E_reg(2 downto 0);
    fh0_10dec7seg: decod_7seg port map (    
        dec_in => bits4e_reg(3 downto 0),
        out_7seg => h0_10(6 downto 0));
        
    fh0_11dec7seg: decod_7seg port map (    
        dec_in => code(3 downto 0),
        out_7seg => h0_11(6 downto 0));

    fHEX0: mux4x1 port map (    
        in00 => h0_00(6 downto 0), 
        in01 => h0_01(6 downto 0), 
        in10 => h0_10(6 downto 0), 
        in11 => h0_11(6 downto 0),
        SelMux => sel_mux(1 downto 0),
        dataout => hex0(6 downto 0));

    --format HEX1
    fh1_01dec7seg: decod_7seg port map (    
        dec_in => user(7 downto 4),
        out_7seg => h1_01(6 downto 0));

    fh1_11dec7seg: decod_7seg port map (    
        dec_in => code(7 downto 4),
        out_7seg => h1_11(6 downto 0));

    fHEX1: mux4x1 port map (        
        in00 => "1000111", 
        in01 => h1_01(6 downto 0), 
        in10 => "0000110",
        in11 => h1_11(6 downto 0),
        SelMux => sel_mux(1 downto 0),
        dataout => hex1(6 downto 0));

    --format HEX2
    fh2_00dec7seg: decod_7seg port map (    
        dec_in => sel(5 downto 2),
        out_7seg => h2_00(6 downto 0));

    fh2_01dec7seg: decod_7seg port map (
        dec_in => user(11 downto 8),
        out_7seg => h2_01(6 downto 0));

    bits4p_reg(3 downto 0) <= '0' & P_reg(2 downto 0);
    fh2_10dec7seg: decod_7seg port map (
        dec_in => bits4p_reg(3 downto 0),
        out_7seg => h2_10(6 downto 0));

    fh2_11dec7seg: decod_7seg port map (
        dec_in => code(11 downto 8),
        out_7seg => h2_11(6 downto 0));

    fHEX2: mux4x1 port map (        
        in00 => h2_00(6 downto 0), 
        in01 => h2_01(6 downto 0), 
        in10 => h2_10(6 downto 0),
        in11 => h2_11(6 downto 0),
        SelMux => sel_mux(1 downto 0),
        dataout => hex2(6 downto 0));

    --format HEX3
    fh3_01dec7seg: decod_7seg port map (
        dec_in => user(15 downto 12),
        out_7seg => h3_01(6 downto 0));
    
    fh3_11dec7seg: decod_7seg port map (
        dec_in => code(15 downto 12),
        out_7seg => h3_11(6 downto 0));

    fHEX3: mux4x1 port map (        
        in00 => "1000110", 
        in01 => h3_01(6 downto 0), 
        in10 => "0001100",
        in11 => h3_11(6 downto 0),
        SelMux => sel_mux(1 downto 0),
        dataout => hex3(6 downto 0));

    --format HEX4
    fh4_1dec7seg: decod_7seg port map (
        dec_in => time_c(3 downto 0),
        out_7seg => h4_1(6 downto 0));

    fHEX4: mux2x1 port map (        
        in00 => "1111111", 
        in01 => h4_1(6 downto 0),
        sele2 => E2,
        dataout => hex4(6 downto 0));
    
    --format HEX5
    fHEX5: mux2x1 port map (
        in00 => "1111111", 
        in01 => "0000111",
        sele2 => E2,
        dataout => hex5(6 downto 0));

    --format HEX6
    
    fh6_1dec7seg: decod_7seg port map (
        dec_in => result(3 downto 0),
        out_7seg => h6_1(6 downto 0));
    
    fHEX6: mux2x1 port map (
        in00 => "1111111", 
        in01 => h6_1(6 downto 0),
        sele2 => E5,
        dataout => hex6(6 downto 0));

    --format HEX7
    fh7_1dec7seg: decod_7seg port map (
        dec_in => result(7 downto 4),
        out_7seg => h7_1(6 downto 0));

    fHEX7: mux2x1 port map (
        in00 => "1111111", 
        in01 => h7_1(6 downto 0),
        sele2 => E5,
        dataout => hex7(6 downto 0));
end arc_data;
-- C 1000110
-- E 0000110
-- L 1000111
-- t 0000111
-- P 0001100