library ieee;
use ieee.std_logic_1164.all;

entity ROM2 is port (

    address : in  std_logic_vector(3 downto 0);
    data    : out std_logic_vector(15 downto 0));
    
end ROM2;

architecture Rom_Arch of ROM2 is
  
type memory is array (00 to 15) of std_logic_vector(15 downto 0);
constant my_Rom : memory := (

	00 => "0100010101100111",  --4567
	01 => "0100010101110110",  --4576
  02 => "0100011001010111",  --4657
	03 => "0100011001110101",  --4675
	04 => "0100011101010110",  --4756
	05 => "0100011101100101",  --4765
	06 => "0011001001000101",  --3245
	07 => "0011001001010100",  --3254
	08 => "0011010000100101",  --3425
	09 => "0011010001010010",  --3452
  10 => "0011010100100100",  --3524
	11 => "0011010101000010",  --3542
	12 => "0010001101000101",  --2345
	13 => "0010001101010100",  --2354
	14 => "0010010000110101",  --2435
	15 => "0010010001010011"); --2453

	
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