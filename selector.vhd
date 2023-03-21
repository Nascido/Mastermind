library ieee;
use ieee.std_logic_1164.all;

entity selector is port(

   in0, in1, in2, in3: in  std_logic;
   saida             : out std_logic_vector(1 downto 0));
    
end selector;


architecture arc_selector of selector is begin

 Saida <= "00" when in0 = '1' else
          "01" when in1 = '1' else
          "10" when in2 = '1' else
          "11" when in3 = '1' else
			 "01";
	
end arc_selector;
