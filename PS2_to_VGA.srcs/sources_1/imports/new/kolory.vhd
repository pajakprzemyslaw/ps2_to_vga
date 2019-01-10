----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.09.2018 17:40:25
-- Design Name: 
-- Module Name: kolory - Behavioral
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


Library IEEE;
use IEEE.STD_Logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity kolory is
  Port 
  ( 
    code                   : in STD_LOGIC_VECTOR(7 downto 0);
    clk                    : in std_logic;
    row                    : in STD_LOGIC_VECTOR( 9 downto 0);
    column                 : in STD_LOGIC_VECTOR( 9 downto 0);
    red, green, blue       : out STD_LOGIC_VECTOR(2 downto 0)
   );
end kolory;

architecture Behavioral of kolory is
signal row1: STD_LOGIC_VECTOR(9 downto 0);
signal col1: STD_LOGIC_VECTOR(9 downto 0);
signal code_temp: STD_LOGIC_VECTOR(7 downto 0);

begin
process(clk) is
begin
row1 <= row;
col1 <= column;
code_temp <= code;
--code_temp <= code;    
end process;


RGB : process(row1, col1, code_temp) is
begin
case code_temp is
    when X"1C" => -- A pressed
       --  wait until clock = '1';
            if(col1 < 640 and  row1 < 480) then
                red <= (others => '0');
                green <= (others => '0');
                blue <= (others => '1');
--                if( col1 >= 290 and col1 <340) then
--                    if(row1  >= 230 and row1 < 240) then
--                        green <= (others => '1');
--                        red <= (others => '1');
--                        blue <= (others => '1');
--                    end if;  
--                if(col1 >= 290 and col1 < 315) then
--                    if(row1 >=240 and row1 < 300) then 
--                        green <= (others => '1');
--                        red <= (others => '1');
--                        blue <= (others => '1');
--                    end if;
--             end if; 
--                if(col1 >= 325 and col1 <340) then
--                    if(row1 >= 250 and row1 < 300) then
--                        green <= (others => '1');
--                        red <= (others => '1');
--                        blue <= (others => '1');
--                    end if;
--                end if;
--                if(col1 >= 315 and col1 < 325 ) then
--                    if(row1 >= 250 and row1 <270) then
--                        green <= (others => '1');
--                        red <= (others => '1');
--                        blue <= (others => '1'); 
--                end if;
            end if;
    when X"32" => -- B
        if(col1 < 640 and  row1 < 480) then
            red <= (others => '1');
            green <= (others => '0');            
            blue <= (others => '0');
        end if;
   when X"21" => -- C
        if(col1 < 640 and  row1 < 480) then
            green <= (others => '0');
            red <= (others => '1');
            blue <= (others => '0');
        end if;
   when X"23" => -- D
        if(col1 < 640 and  row1 < 480) then
            red <= (others => '1');
            green <= (others => '1');            
            blue <= (others => '0');
        end if;
   when X"24" => -- E
        if(col1 < 640 and  row1 < 480) then
            red <= (others => '0');
            green <= (others => '0');            
            blue <= (others => '1');
        end if;
   when X"2B" => -- F
        if(col1 < 640 and  row1 < 480) then
            red <= (others => '1');
            green <= (others => '0');            
            blue <= (others => '1');
        end if;
   when X"34" => -- G
        if(col1 < 640 and  row1 < 480) then
            red <= (others => '0');
            green <= (others => '1');            
            blue <= (others => '1');
        end if;
   when X"33" => -- H
        if(col1 < 640 and  row1 < 480) then
            green <= (others => '1');
            red <= (others => '1');
            blue <= (others => '1');
        end if;
   when X"43" => -- I
        if(col1 < 640 and  row1 < 480) then
            red <= (others => '0');
            green <= (others => '0');            
            blue <= (others => '0');
        end if;
   when X"3B" => -- J
        if(col1 < 640 and  row1 < 480) then
            red <= (others => '1');
            green <= (others => '0');            
            blue <= (others => '0');
        end if;
   when X"42" => -- K
        if(col1 < 640 and  row1 < 480) then
            red <= (others => '0');
            green <= (others => '1');            
            blue <= (others => '0');
        end if;
   when X"4B" => -- L
        if(col1 < 640 and  row1 < 480) then
           red <= (others => '1');
            green <= (others => '1');            
            blue <= (others => '0');
        end if;
   when X"3A" => -- M
        if(col1 < 640 and  row1 < 480) then
            red <= (others => '0');
            green <= (others => '0');            
            blue <= (others => '1');
        end if;
   when X"44" => -- O
        if(col1 < 640 and  row1 < 480) then
           red <= (others => '1');
            green <= (others => '0');            
            blue <= (others => '1');
        end if;
   when X"4D" => -- P
        if(col1 < 640 and  row1 < 480) then
            red <= (others => '0');
            green <= (others => '1');            
            blue <= (others => '1');
        end if;
   when X"15" => -- Q
        if(col1 < 640 and  row1 < 480) then
            red <= (others => '1');
            green <= (others => '1');            
            blue <= (others => '1');
        end if;
   when X"2D" => -- R
        if(col1 < 640 and  row1 < 480) then
            red <= (others => '0');
            green <= (others => '0');            
            blue <= (others => '0');
        end if;
   when X"2C" => -- T
        if(col1 < 640 and  row1 < 480) then
            red <= (others => '1');
            green <= (others => '0');            
            blue <= (others => '0');
        end if;
   when X"3C" => -- U
        if(col1 < 640 and  row1 < 480) then
            red <= (others => '0');
            green <= (others => '1');            
            blue <= (others => '0');
        end if;
   when X"2A" => -- V
        if(col1 < 640 and  row1 < 480) then
            red <= (others => '1');
            green <= (others => '1');            
            blue <= (others => '0');
        end if;
   when X"1D" => -- W
        if(col1 < 640 and  row1 < 480) then
            red <= (others => '0');
            green <= (others => '0');            
            blue <= (others => '1');
        end if;
   when X"22" => -- X
        if(col1 < 640 and  row1 < 480) then
            red <= (others => '1');
            green <= (others => '0');            
            blue <= (others => '1');
        end if;
   when X"35" => -- Y
        if(col1 < 640 and  row1 < 480) then
            red <= (others => '0');
            green <= (others => '1');            
            blue <= (others => '1');
        end if;
   when X"1A" => -- Z
        if(col1 < 640 and  row1 < 480) then
            red <= (others => '1');
            green <= (others => '1');            
            blue <= (others => '1');
        end if;
   when X"45" => -- 0
        if(col1 < 640 and  row1 < 480) then
            red <= (others => '0');
            green <= (others => '0');            
            blue <= (others => '0');
        end if;
   when X"16" => -- 1
        if(col1 < 640 and  row1 < 480) then
            red <= (others => '1');
            green <= (others => '0');            
            blue <= (others => '0');
        end if;
   when X"1E" => -- 2
        if(col1 < 640 and  row1 < 480) then
            red <= (others => '0');
            green <= (others => '1');            
            blue <= (others => '0');
        end if;
   when X"26" => -- 3
        if(col1 < 640 and  row1 < 480) then
            red <= (others => '1');
            green <= (others => '1');            
            blue <= (others => '0');
        end if;
   when X"25" => -- 4
        if(col1 < 640 and  row1 < 480) then
            red <= (others => '0');
            green <= (others => '0');            
            blue <= (others => '1');
        end if;
   when X"2E" => -- 5
        if(col1 < 640 and  row1 < 480) then
            red <= (others => '1');
            green <= (others => '0');            
            blue <= (others => '1');
        end if;
   when X"36" => -- 6
        if(col1 < 640 and  row1 < 480) then
            red <= (others => '0');
            green <= (others => '1');            
            blue <= (others => '1');
        end if;
   when X"3D" => -- 7
        if(col1 < 640 and  row1 < 480) then
            red <= (others => '1');
            green <= (others => '1');            
            blue <= (others => '1');
        end if;
   when X"3E" => -- 8
        if(col1 < 640 and  row1 < 480) then
            red <= (others => '0');
            green <= (others => '0');            
            blue <= (others => '0');
        end if;
   when X"46" => -- 9  
         if(col1 < 640 and  row1 < 480) then
             red <= (others => '1');
             green <= (others => '0');            
             blue <= (others => '0');
           end if;
    when others =>
            red <= (others => '0');
            green <= (others => '1');            
            blue <= (others => '0');
    end case;
end process;

end Behavioral;
