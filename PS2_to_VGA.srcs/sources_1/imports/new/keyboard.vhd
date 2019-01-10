-- Example 41a: keyboard
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity keyboard is
 port(
 clk25 : in STD_LOGIC;
 clr : in STD_LOGIC;
 PS2C : in STD_LOGIC;
 PS2D : in STD_LOGIC;
 xkey : out STD_LOGIC_VECTOR (7 downto 0)
 );
end keyboard;

architecture keyboard of keyboard is

--type states is ( s_idle, wtclk_l_1, wtclk_h_1, getkey_1, wtclk_l_2, wtclk_h_2, getkey_2);
type states is ( start, stop, parity, data);

signal state: states;
--__________________________________
signal PS2Cf, PS2Df: std_logic;
signal ps2c_filter, ps2d_filter: std_logic_vector(7 downto 0);
signal shift1, shift2: std_logic_vector(10 downto 0);
--_______________________________________________________
signal r_Bit_Index : integer range 0 to  7:= 0;  -- 8 Bits Total
signal data1, data2 : STD_LOGIC_VECTOR(7 downto 0);
--______________________________________________
signal counter_value: integer := 8;
signal counter: STD_LOGIC_VECTOR(3 downto 0);
--signal Bit_Cnt : unsigned (3 downto 0);
--________________________________________________
signal parity_bit, start_bit, stop_bit: STD_LOGIC;
--_________________________________________________
signal PS2_low: STD_LOGIC;
signal PS2Cf_reg: STD_LOGIC;



begin

-- filter for PS2 clock and data
filter: process(clk25, clr)
begin
if clr = '1' then
 ps2c_filter <= (others => '0');
 ps2d_filter <= (others => '0');
 PS2Cf <= '1';
 PS2Df <= '1';
elsif clk25'event and clk25 = '1' then
 ps2c_filter(7) <= PS2C;
 ps2c_filter(6 downto 0) <= ps2c_filter(7 downto 1);
 ps2d_filter(7) <= PS2D;
 ps2d_filter(6 downto 0) <= ps2d_filter(7 downto 1);
 if ps2c_filter = X"FF" then
 PS2Cf <= '1';
 elsif ps2c_filter = X"00" then
 PS2Cf <= '0';
 end if;
 if ps2d_filter = X"FF" then
 PS2Df <= '1';
 elsif ps2d_filter = X"00" then
 PS2Df <= '0';
 end if;
end if;
end process filter; 
--Shift Registers used to clock in scan codes from PS2--

falling_edge_detection: process(clk25,clr)
begin
    if(clr = '1') then
        PS2Cf_reg <= '1';
    elsif(rising_edge(clk25)) then
        PS2Cf_reg <= PS2Cf;
     end if;
end process;
PS2_low <= PS2Cf_reg and not PS2Cf;
process(clr,clk25)
begin
    if(clr = '1') then
        Shift1 <= (others => '0');
        Shift2 <= (others => '0');
        data1  <= (others => '0');
        data2  <= (others => '0');
        counter <= (others => '0');
        state <= start;
        r_Bit_Index <= 0;
        xkey <= (others => '0');
          
    elsif(rising_edge(clk25)) then
--            case state is
--                when s_idle =>
--                         -- note that we dont need to clear the Shift Register
--                         if PS2Df='0' then -- Start bit
--                             state <= wtclk_l_1;
--                         else
--                            state <= s_idle;
--                         end if;
--                when wtclk_l_1 =>
--                     if(counter < value) then
--                        if(PS2Cf = '0') then
--                            state <= wtclk_h_1;
--                            shift1 <= PS2Df & shift1(10 downto 1); -- przesuwamy 0000, 0001, 0010, 0100, 1000
--                        end if;
--                     else
--                        state <= getkey_1;
--                     end if;
--                when wtclk_h_1 =>
--                    if(PS2Cf = '0') then
--                        state <= wtclk_h_1;
--                    else
--                        state <= wtclk_l_1;
--                        counter <= counter +1;
--                    end if;
--               when getkey_1 =>
--                    data1 <= shift1(8 downto 1);
--                    counter <=(others => '0');
--                    state <= wtclk_l_2;
--               when wtclk_l_2 =>
--                 if(counter < value) then
--                    if(PS2Cf = '0') then
--                        state <= wtclk_h_2;
--                        shift2 <= PS2Df & shift2(10 downto 1); -- przesuwamy 0000, 0001, 0010, 0100, 1000
--                    end if;
--                 else
--                    state <= getkey_2;
--                 end if;
--            when wtclk_h_2 =>
--                if(PS2Cf = '0') then
--                    state <= wtclk_h_2;
--                else
--                    state <= wtclk_l_2;
--                    counter <= counter +1;
--                end if;
--           when getkey_2 =>
--                data2 <= shift2(8 downto 1);
--                counter <=(others => '0');
--                state <= wtclk_l_1;
--            end case;
--___________________________________________________________________
         if (PS2_low = '1') then   
            case state is
                      
                when start =>
                     -- note that we dont need to clear the Shift Register
                     if PS2Df='0' then -- Start bit
                        Shift1(0) <= PS2Df;
                        state <= data;
                     end if;

                when data =>
                    if(r_Bit_Index < counter_value -1) then
                        data1(r_Bit_Index) <= PS2Df;
                        r_Bit_Index <= r_Bit_Index+1;
                    else
                        r_Bit_Index <= 0;
                        state <= parity;
                    end if;
                    
               when parity =>
                    shift1(9) <= PS2Df;
                    state <= stop;
                   
               when stop =>
                    shift1(10) <= PS2Df;
                    xkey  <= data1(7 downto 0);
                    state <= start;
                    
               when others =>
                    state <= start;
                    
            end case;
          end if;
        end if;
end process;
--_____________________________________

--shift: process(PS2Cf, clr)
--begin
-- if (clr = '1') then
--     Shift1 <= (others => '0');
--     Shift2 <= (others => '0');
-- elsif (PS2Cf'event and PS2Cf = '0') then
--     Shift1 <= PS2Df & Shift1(10 downto 1);
--     Shift2 <= Shift1(0) & Shift2(10 downto 1);
-- end if;
--end process shift;


--________________________________________
--shift: process(clk25, clr)
--begin
-- if (clr = '1') then
--     Shift1 <= (others => '0');
--     Shift2 <= (others => '0');
-- elsif (rising_edge(clk25)) then
--     if(PS2_low = '1') then
--         Shift1 <= PS2Df & Shift1(10 downto 1);
--         Shift2 <= Shift1(0) & Shift2(10 downto 1);
--     end if;
-- end if;
--end process shift;




end keyboard; 