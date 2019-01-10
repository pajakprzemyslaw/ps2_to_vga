----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.09.2018 16:03:49
-- Design Name: 
-- Module Name: display_keyboard - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity display_keyboard is
  Port 
  ( counter_display: in STD_LOGIC_VECTOR(3 downto 0);
    data_display:    in STD_LOGIC_VECTOR(7 downto 0);
    output:          out STD_LOGIC_VECTOR(3 downto 0)
   );
end display_keyboard;

architecture Behavioral of display_keyboard is
signal output1: STD_LOGIC_VECTOR(3 downto 0);

begin
process(counter_display)
begin
    case(counter_display) is
--            when "0000" =>
--                output1 <= data_display(15 downto 12);
--            when "0001" =>
--                output1 <= data_display(15 downto 12);
--            when "0010" =>
--                output1 <= data_display(15 downto 12);
--            when "0011" =>
--                output1 <= data_display(15 downto 12);
----__________________________________________________________                
--            when "0100" =>
--                output1 <= data_display(11 downto 8);
--            when "0101" =>
--                output1 <= data_display(11 downto 8);
--            when "0110" =>
--                output1 <= data_display(11 downto 8);
--            when "0111" =>
--                output1 <= data_display(11 downto 8);
----__________________________________________________________                
            when "1000" =>
                output1 <= data_display(7 downto 4);
            when "1001" =>
                output1 <= data_display(7 downto 4);
            when "1010" =>
                output1 <= data_display(7 downto 4);
            when "1011" =>
                output1 <= data_display(7 downto 4);
--__________________________________________________________                
            when "1100" =>
                output1 <= data_display(3 downto 0);
            when "1101" =>
                output1 <= data_display(3 downto 0);
            when "1110" =>
                output1 <= data_display(3 downto 0);
            when "1111" =>
                output1 <= data_display(3 downto 0);
--        when "1001" =>
--            output1 <= data_display(7 downto 4);
--        when "1010" =>
--            output1 <= data_display(7 downto 4);
--        when "1011" =>
--            output1 <= data_display(7 downto 4);
--        when "1100" =>
--            output1 <= data_display(3 downto 0);
--        when "1101" =>
--            output1 <= data_display(3 downto 0);
--        when "1110" =>
--            output1 <= data_display(3 downto 0);
--        when "1111" =>
--            output1 <= data_display(3 downto 0);
        when others =>
            output1 <= "0000";
    end case;
end process;

output<= output1;

end Behavioral;
