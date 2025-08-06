----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/06/2025 05:12:52 PM
-- Design Name: 
-- Module Name: state_machin - Behavioral
-- Project Name: 
-- Target Devices: ++++
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
use IEEE.numeric_std.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity state_machin is
    Port (
         clk : in std_logic;
         led : out std_logic
     );
end state_machin;

architecture Behavioral of state_machin is
    signal cnt : integer range 0 to 99999999;
    signal cnt_periph : integer range 0 to 19999999;
    type state_type is (s25ms,s50ms,s100ms,s200ms,s400ms);
    signal state : state_type := s25ms;
    signal sled :  std_logic := '0';

begin

   process (clk)
   begin
        if(rising_edge(clk)) then
            cnt <= cnt + 1;
            if(cnt = 99999999) then
                cnt <= 0;
                case state is 
                    when s25ms => state <= s50ms;
                    when s50ms => state <= s100ms;
                    when s100ms => state <= s200ms;
                    when s200ms => state <= s400ms;
                    when s400ms => state <= s25ms;
                end case;
            end if;
        end if;
    end process;

    


    -- 
    process (clk)
   begin
        if(rising_edge(clk)) then
                cnt_periph <= cnt_periph + 1;
            
                case state is 
                    when s25ms =>
                        if (cnt_periph = 1249999) then
                            cnt_periph <= 0;
                            sled <= not sled;                            
                        end if;
                    when s50ms => 
                        if (cnt_periph = 2499999) then
                            cnt_periph <= 0;
                            sled <= not sled;                            
                        end if;
                    when s100ms => 
                        if (cnt_periph = 4999999) then
                            cnt_periph <= 0;
                            sled <= not sled;                            
                        end if;
                    when s200ms => 
                        if (cnt_periph = 9999999) then
                            cnt_periph <= 0;
                            sled <= not sled;                            
                        end if;
                    when s400ms =>
                        if (cnt_periph = 19999999) then
                            cnt_periph <= 0;
                            sled <= not sled;
                        end if;
                end case;
        end if;
    end process;
    -- 
    led <= sled;
end Behavioral;



-- signals can read in all processes but you can only change them just
-- in one process execpt you get multisource error
