----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.09.2018 17:39:40
-- Design Name: 
-- Module Name: licznik - Behavioral
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
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity licznik is
port(   
        clock            : in std_logic;  -- 25.175 Mhz clock
        row, column      : out std_logic_vector(9 downto 0); -- for current pixel
        H, V             : out std_logic
     ); -- VGA 
end licznik;

architecture Behavioral of licznik is
-- names are referenced from Altera University Program Design
  -- Laboratory Package  November 1997, ver. 1.1  User Guide Supplement
  -- clock period = 39.72 ns; the constants are integer multiples of the
  -- clock frequency and are close but not exact
  -- row counter will go from 0 to 524; column counter from 0 to 799
  
  signal vertical: std_logic_vector(9 downto 0);
  signal horizontal: std_logic_vector(9 downto 0);
  constant S_H     : natural := 96;  -- SYNCHRONIZATION HORIZONTAL 
  constant F_P_H   : natural := 16;  -- FRONT PORCH HORIZONTAL
  constant B_P_H   : natural := 48;  -- BACK PORCH HROZIONTAL
  constant D_H     : natural := 640; -- DISPLAY_HORIZONTAL
  constant F_H     : natural := 800; -- FULL HORIZONTAL
  constant S_V     : natural := 2;   -- SYNCHRONIZATION VERTICAL
  constant F_P_V   : natural := 10;  -- FRONT PORCH VERTICAL
  constant B_P_V   : natural := 33;  -- BACK PORCH VERTICAL
  constant D_V     : natural := 480; -- DISPLAY VERTICAL
  constant F_V     : natural := 525; -- FULL HORIZONTAL
begin


  process  -- define counters
  
  begin
    wait until clock = '1';

  -- increment counters
      if  horizontal < F_H - 1  then -- 0...799
        horizontal <= horizontal + 1;
      else
        horizontal <= (others => '0');

        if  vertical < F_V - 1  then -- less than oh
          vertical <= vertical + 1;
        else
          vertical <= (others => '0');       -- is set to zero
        end if;
      end if;

  -- define H pulse
      if  horizontal >= (D_H + F_P_H)  and  horizontal < (D_H + F_P_H + S_H)  then  -- <640+16=656 ; 96+640)
        H <= '0';
      else
        H <= '1';
      end if;

  -- define V pulse
      if  vertical >= (D_V + F_P_V)  and  vertical < (D_V + F_P_V + S_V)  then -- <480+10 ; 490+2)
        V <= '0';
      else
        V <= '1';
      end if;

    -- mapping of the variable to the signals
     -- negative signs are because the conversion bits are reversed
    row <= vertical;
    column <= horizontal;

  end process;

end Behavioral;
