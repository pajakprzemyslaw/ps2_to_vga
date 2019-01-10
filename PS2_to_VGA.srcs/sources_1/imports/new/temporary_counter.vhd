----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.09.2018 23:44:40
-- Design Name: 
-- Module Name: temporary_counter - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity temporary_counter is
Port 
( 
    clk_i: in STD_LOGIC;
    btn_state: in STD_LOGIC;
    res: in STD_LOGIC;
    q: out STD_LOGIC_VECTOR(3 downto 0)
);
end temporary_counter;
--maszyna stanow i jej stany
--_________________________________________________
architecture Behavioral of temporary_counter is
TYPE counter_states is(START, STOP, RESET);
signal counter_state: counter_states;

signal led_temp: STD_LOGIC_VECTOR(3 downto 0):="0000";
signal btn_state_reg: STD_LOGIC;
signal button_toggle:STD_LOGIC;
--_________________________________________ licznik
signal one_tick: STD_LOGIC;
signal led_state: STD_LOGIC_VECTOR(3 downto 0);
constant N: integer:= 25000000;
signal licznik: integer;

begin

button_toggle <= btn_state and (not btn_state_reg);

licznik_1khz: process(clk_i, res) is
begin
    if(res='1') then
        one_tick <= '0';
    elsif(rising_edge(clk_i)) then
        if(licznik < N-1) then
            licznik <= licznik +1;
            one_tick <='0';
        else
            licznik <= 0;
            one_tick <='1';
        end if;
    end if;
end process;


--btn_1 <= btn_state and (not btn_state_reg);

definicja_stanow :process(clk_i, res, btn_state)
begin
    if(res ='1') then
        btn_state_reg <= '0';
        counter_state <= RESET;
    elsif(rising_edge(clk_i)) then
        btn_state_reg <= btn_state;
    
        case counter_state is
            when RESET =>
                if(button_toggle ='1') then
                    counter_state <= START;
                end if;
            when START =>
                 if(button_toggle ='1') then
                    counter_state <= STOP;
                end if;
            when STOP =>
                 if(button_toggle ='1') then
                    counter_state <= RESET;
                 end if;
            when OTHERS =>
                counter_state <= RESET;
        end case;
    end if;
end process;

licznik_counter:process (clk_i,res, btn_state )
begin
    if(res = '1') then
        led_temp <= (others => '0');
    elsif rising_edge (clk_i) then
        case counter_state is
            when RESET =>
                led_temp <= (others => '0');
            when START =>
            if(one_tick ='1') then
                   led_temp <= led_temp+1;
                if(led_temp = "1111") then
                    led_temp <= "0000";
                end if;
            end if;
            when STOP =>
            when OTHERS =>
                led_temp <= "0000";
        end case;
    end if;
end process;

q <= led_temp;

end Behavioral;
