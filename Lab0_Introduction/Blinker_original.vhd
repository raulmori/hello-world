--Remember that we count depending on THREE conditions (CLOCK, SWITCH, and COUNT)
--There are only two ways the LED can be turned off. When the switch is low, and when the count increased passed the THRESHOLD.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity blinker is
    port(
        clk  : in std_logic;        -- This is the 125 Mhz clock (we know by manufacturer-standards clocks have this frequency standard)
        sw0  : in std_logic;        -- when the SWITCH is HIGH as '1' it means "ON" 
        led0 : out std_logic        -- when the LED is HIGH as '1' = on
         );
end blinker;

    
architecture behavior of blinker is
        signal counter : std_logic_vector(26 downto 0) := (others => '0');

        begin
            process(clk)
                    begin
                        if rising_edge(clk) then                                --Remember any action happens on a CLOCK-tick
                                if (sw0 = '0') then                                 --This means if the SWITCH is OFF
                                        led0 <= '0';                        --The LED is turned off
                                        counter <= (others => '0');             --COUNT is reset
                                else               -- when "SWITCH" is HIGH
                                        if (unsigned(counter) < 124999999) then     -- This is the second condition that the COUNTER is has to be less than this number. Count one full led period (1 Hz)
                                            counter <= std_logic_vector(unsigned(counter) + 1);     --Here we add one count. 
                                        else                                            --The system here detects that the "COUNTER" passed the threshold count
                                            counter <= (others => '0');                         --As a result the "COUNT" is Reset 
                                        end if;
                                        ----------
                                        if (unsigned(counter) < 62500000) then  -- turn the led on for half of the period (50% duty cycle)
                                            led0 <= '1';                --The LED is only turned ON, when the count is LESS THAN 62500000
                                        else
                                            led0 <= '0';            --otherwise the LED is turned off
                                        end if;
                                end if;
                        end if;
            end process;
    
end behavior;
