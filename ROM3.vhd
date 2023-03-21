library ieee;
use ieee.std_logic_1164.all;

entity ROM3 is port (

    address : in  std_logic_vector(3 downto 0);
    data    : out std_logic_vector(15 downto 0));
    
end ROM3;

architecture Rom_Arch of ROM3 is
  
type memory is array (00 to 15) of std_logic_vector(15 downto 0);
constant my_Rom : memory := (

	00 => "0110011110001001",  --6789
	01 => "0110011110011000",  --6798
  02 => "0110100001111001",  --6879
	03 => "0110100010010111",  --6897
	04 => "0110100101111000",  --6978
	05 => "0110100110000111",  --6987
	06 => "0100001000111001",  --4239
	07 => "0100001010010011",  --4293
	08 => "0100001100101001",  --4329
	09 => "0100001110010010",  --4392
  10 => "0100100100100011",  --4923
	11 => "0100100100110010",  --4932
	12 => "0010010001101000",  --2468
	13 => "0010010010000110",  --2486
	14 => "0010011001001000",  --2648
	15 => "0010011010000100"); --2684

	
begin
  process (address)
  begin
    case address is
      when "0000" => data <= my_rom(00);
      when "0001" => data <= my_rom(01);
      when "0010" => data <= my_rom(02);
      when "0011" => data <= my_rom(03);
      when "0100" => data <= my_rom(04);
      when "0101" => data <= my_rom(05);
      when "0110" => data <= my_rom(06);
      when "0111" => data <= my_rom(07);
      when "1000" => data <= my_rom(08);
      when "1001" => data <= my_rom(09);
      when "1010" => data <= my_rom(10);
      when "1011" => data <= my_rom(11);
      when "1100" => data <= my_rom(12);
      when "1101" => data <= my_rom(13);
      when "1110" => data <= my_rom(14);
      when others => data <= my_rom(15);
    end case;
  end process;
end architecture Rom_Arch;