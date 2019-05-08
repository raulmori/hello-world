--Remember that we count depending on THREE conditions (CLOCK, SWITCH, and COUNT)
--There are only two ways the LED can be turned off. When the switch is low, and when the count increased passed the THRESHOLD.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity switcher is
    port(
        clk      : in std_logic;        -- This is the 125 Mhz clock (we know by manufacturer-standards clocks have this frequency standard)
        sw      : in std_logic;        -- when the SWITCH is HIGH as '1' it means "ON" 
        output  : out std_logic      -- when the LED is HIGH as '1' = on
         );
end switcher;

    
architecture behavior of switcher is

        begin
            process(clk)
                    begin
                        if rising_edge(clk) then                                --Remember any action happens on a CLOCK-tick
                                if (sw = '0') then                                 --This means if the SWITCH is OFF
                                    output <= '0';                        --The LED is turned off
                                elsif (sw = '1') then              -- when "SWITCH" is HIGH      
                                    output <= '1';                 
                                end if;
                        end if;
            end process;

end behavior;
