----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.09.2018 17:20:04
-- Design Name: 
-- Module Name: f_div_1 - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity f_div_1 is
Port (  clk : in STD_logic;
        res : in STD_LOGIC;
        clk_o : out STD_LOGIC
     );
end f_div_1;


architecture Behavioral of f_div_1 is
constant N: integer:=5; -- 1 khz
signal clk_o_u: STD_LOGIC :='0';
signal licznik: integer:=0;


begin

proces: process(clk,res) is
begin
	if res='1' then
	clk_o_u<='0';
	licznik<=0;

		else if rising_edge(clk) then

			if licznik<(N/2 -1) then
			clk_o_u<='0';
			licznik <= licznik+1;
			end if;

			if licznik >=(N/2 -1) and licznik < (N-1) then
			clk_o_u<='1';
			licznik <= licznik +1;
			end if;
			if licznik >= (N-1) then
			clk_o_u<= not clk_o_u;
			licznik <= 0;
			end if;
		end if;
	end if;
end process proces;
clk_o<=clk_o_u;


end Behavioral;
