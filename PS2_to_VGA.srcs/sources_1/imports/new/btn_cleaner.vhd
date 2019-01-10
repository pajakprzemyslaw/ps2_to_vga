----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.09.2018 13:56:00
-- Design Name: 
-- Module Name: btn_cleaner - Behavioral
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

entity btn_cleaner is
 Port 
 ( 
    clk_i : in STD_LOGIC; -- 1 khz
    btn_i: in STD_LOGIC;
    res:   in   STD_LOGIC;
    btn_o: out STD_LOGIC
 );
end btn_cleaner;

architecture Behavioral of btn_cleaner is
signal licznik: Integer:=0;
signal btn_i_reg: STD_LOGIC:='0';
constant N: integer:= 125000*5;

begin
process(clk_i, res)
begin
    if(res = '1') then
        licznik <= 0;
    elsif(rising_edge(clk_i)) then
        if(licznik < N-1 and btn_i_reg /= btn_i) then
            licznik <= licznik +1;
        elsif(licznik = N-1) then
            licznik <= 0;
            btn_i_reg <= btn_i;
        else
            licznik <= 0;
        end if;
    end if;
end process;
btn_o <= btn_i_reg;
end Behavioral;
