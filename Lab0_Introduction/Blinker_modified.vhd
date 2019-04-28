--Remember that we count depending on THREE conditions (CLOCK, SWITCH, and COUNT)
--There are only two ways the LED can be turned off. When the switch is low, and when the count increased passed the THRESHOLD.

--The 2 counter values for TOTAL, and LED-LOW were halved
--For the LED and SWITCH, since they are variables connected to the "CONSTRAINT" the name is  relevant.


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity blinker is
    port(
        clk  : in std_logic;        -- This is the 125 Mhz clock (we know by manufacturer-standards clocks have this frequency standard)
        sw3  : in std_logic;        -- when the SWITCH is HIGH as '1' it means "ON" 
        led3 : out std_logic        -- when the LED is HIGH as '1' = on
         );
end blinker;

    
architecture behavior of blinker is
        signal counter : std_logic_vector(26 downto 0) := (others => '0');

        begin
            process(clk)
                    begin
                        if rising_edge(clk) then                                --Remember any action happens on a CLOCK-tick
                                if (sw3 = '0') then                                 --This means if the SWITCH is OFF
                                        led3 <= '0';                        --The LED is turned off
                                        counter <= (others => '0');             --COUNT is reset
                                else               -- when "SWITCH" is HIGH
                                        if (unsigned(counter) < 62500000) then     -- This is the second condition that the COUNTER is has to be less than this number. Count one full led period (1 Hz)
                                            counter <= std_logic_vector(unsigned(counter) + 1);     --Here we add one count. 
                                        else                                            --The system here detects that the "COUNTER" passed the threshold count
                                            counter <= (others => '0');                         --As a result the "COUNT" is Reset 
                                        end if;
                                        ----------
                                        if (unsigned(counter) < 31250000) then  -- turn the led on for half of the period (50% duty cycle)
                                            led3 <= '1';                --The LED is only turned ON, when the count is LESS THAN 62500000
                                        else
                                            led3 <= '0';            --otherwise the LED is turned off
                                        end if;
                                end if;
                        end if;
            end process;
    
end behavior;
