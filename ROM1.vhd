library ieee;
use ieee.std_logic_1164.all;

entity ROM1 is port (

    address : in  std_logic_vector(3 downto 0);
    data    : out std_logic_vector(15 downto 0));
    
end ROM1;

architecture Rom_Arch of ROM1 is

type memory is array (00 to 15) of std_logic_vector(15 downto 0);
constant my_Rom : memory := (

	00 => "0010001101000101",  --2345
	01 => "0010001101010100",  --2354
  02 => "0010010000110101",  --2435
	03 => "0010010001010011",  --2453
	04 => "0010010100110100",  --2534
	05 => "0010010101000011",  --2543
	06 => "0001001101000101",  --1345
	07 => "0001001101010100",  --1354
	08 => "0001010000110101",  --1435
	09 => "0001010001010011",  --1453
  10 => "0001010100110100",  --1534
	11 => "0001010101000011",  --1543
	12 => "0001001000110100",  --1234
	13 => "0001001001000011",  --1243
	14 => "0001000000100011",  --1023
	15 => "0001000000110010"); --1032

	
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