----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.09.2018 20:38:48
-- Design Name: 
-- Module Name: TOP - Behavioral
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

entity TOP is
    Port 
  (
      clk:    in STD_LOGIC; -- 125 mhz clock
      en:     in STD_LOGIC;
      res:    in STD_LOGIC; -- button 
      btn:    in STD_LOGIC;
      sw:     in STD_LOGIC_VECTOR(1 downto 0);
      k_d:     in STD_LOGIC; -- k_d keyboard data bit
      k_clk:  in STD_LOGIC; -- keyboard clock
      led:    out STD_LOGIC_VECTOR(3 downto 0);
      R:      out STD_LOGIC_VECTOR(2 downto 0);
      G:      out STD_LOGIC_VECTOR(2 downto 0);
      B:      out STD_LOGIC_VECTOR(2 downto 0);
      H_vga:  out STD_LOGIC;
      V_vga:  out STD_LOGIC 
   );

end TOP;

architecture Behavioral of TOP is

signal data_8 : STD_LOGIC_VECTOR(7 downto 0);
signal btn_filtered: STD_LOGIC;
signal clk_div: STD_LOGIC; -- 25 Mhz
signal counter_final: STD_LOGIC_VECTOR(3 downto 0);
signal data: STD_LOGIC_VECTOR(15 downto 0);
--sygnaly VGA___________________________
signal row_o, column_o      : std_logic_vector(9 downto 0);

  component pll_125_to_25 is
  Port ( 
    clk_in1 : in STD_LOGIC;
    clk_out1: out STD_LOGIC;
    reset   : in STD_LOGIC;
    locked  : out STD_LOGIC
   );
   end component pll_125_to_25;

--component PS2_Ctrl is
---- --------------------------------------
-- generic (FilterSize : positive := 8);
-- port( Clk : in std_logic; -- System Clock
-- Reset : in std_logic; -- System Reset
-- PS2_Clk : in std_logic; -- Keyboard Clock Line
-- PS2_Data : in std_logic; -- Keyboard Data Line
-- DoRead : in std_logic; -- From outside when reading the scan code
-- Scan_Err : out std_logic; -- To outside : Parity or Overflow error
-- Scan_DAV : out std_logic; -- To outside when a scan code has arrived
-- Scan_Code : out std_logic_vector(7 downto 0) -- Eight bits Data Out
-- );
--end component PS2_Ctrl;


component kolory is
  Port 
  ( 
    code                 : in STD_LOGIC_VECTOR(7 downto 0);
    clk                  : in std_logic;
    row                  : in STD_LOGIC_VECTOR( 9 downto 0);
    column               : in STD_LOGIC_VECTOR( 9 downto 0);
    red, green, blue     : out std_logic_VECTOR( 2 downto 0)
   );
end component kolory;


component display_keyboard is
Port 
( 
    counter_display: in STD_LOGIC_VECTOR(3 downto 0);
    output:      out STD_LOGIC_VECTOR(3 downto 0);
    data_display:    in STD_LOGIC_VECTOR(7 downto 0)
);
end component display_keyboard;

component licznik is
port(   
        clock            : in std_logic;  -- 25.175 Mhz clock
        row, column      : out std_logic_vector(9 downto 0); -- for current pixel
        H, V             : out std_logic
     ); -- VGA 
end component licznik;

component btn_cleaner is
 Port 
 ( 
    clk_i : in STD_LOGIC; -- 1 khz
    btn_i: in STD_LOGIC;
    res:   in   STD_LOGIC;
    btn_o: out STD_LOGIC
 );
end component;

component temporary_counter is
Port 
( 
    clk_i: in STD_LOGIC;
    btn_state: in STD_LOGIC;
    res: in STD_LOGIC;
    q: out STD_LOGIC_VECTOR(3 downto 0)
);
end component;

component keyboard is
 port
 (
 clk25 : in STD_LOGIC;
 clr : in STD_LOGIC;
 PS2C : in STD_LOGIC;
 PS2D : in STD_LOGIC;
 xkey : out STD_LOGIC_VECTOR(7 downto 0)
 );
 
 end component;

component f_div_1 is
Port 
(
    clk : in STD_logic;
    res : in STD_LOGIC;
    clk_o : out STD_LOGIC
);

end component;


begin




licznik_inst : licznik
 port map
 (   
         clock  => clk_div,          
         row    => row_o,
         column => column_o,
         H      => H_vga,
         V      => V_vga
  ); -- VGA 


keyboard_inst : keyboard 
 port map
 (
 clk25 => clk_div,
 clr   => res,
 PS2C  => k_clk,
 PS2D  => k_d,
 xkey  => data_8
 );
 
 
-- f_div_1_0 : f_div_1
-- Port map
-- (
--     clk => clk,
--     res => res,
--     clk_o => clk_div
-- );

pll_125_to_25_inst : pll_125_to_25
Port map
( 
  clk_in1  => clk,
  clk_out1 => clk_div,
  reset    => res,
  locked   => open
 );
kolory_inst : kolory
  Port map
( 
    code => data_8,
    clk  => clk_div,
    row  => row_o,
    column => column_o,
    red     => R, 
    green   => G, 
    blue    => B
);

temporary_counter_1 : temporary_counter
Port map
(
    clk_i     => clk_div,
    btn_state => btn_filtered,
    res       => res,
    q         => counter_final
);

btn_cleaner_inst :btn_cleaner
 Port map
 ( 
    clk_i => clk,
    btn_i => btn,
    res   => res,
    btn_o => btn_filtered
 );
 
 
 display_keyboard_inst : display_keyboard
 Port map
 ( 
     counter_display    => counter_final,
     output          => led,
     data_display    => data_8
 );
 
-- PS2_Ctrl_inst : PS2_Ctrl
-- Port map
-- (
--  Clk        => clk_div,
--  Reset      => res,
--  PS2_Clk    => k_clk,
--  PS2_Data   => k_d,
--  DoRead     => en,
--  Scan_Err   => open,
--  Scan_DAV   => open,
--  Scan_Code  => data_8
--  ); 

end Behavioral;
