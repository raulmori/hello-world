--The OUTPUT of the "BUTTON" being HIGH or LOW depends only on the number of "COUNTS"
--Since we have a 125Mhz Clock, then our debounce time is 6250000 Clock-Ticks (1Hz, or 1 second)

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity debounce is          --Remember the entitiy values are values that the user manually inputs into the system
          Port (
                clk: in std_logic;
                btn: in std_logic;
                dbnc: out std_logic      --Remember this is the Main Output
                ); 
end debounce;

architecture DEB of debounce is
            --Remember that when we assign a "0" to a more than one bit value, we must use the "others" command
          signal counter: std_logic_vector (25 downto 0) := (others => '0');    --This is the TEMPORARY "COUNTER", Notice it use 26 bits to be able to count to 6.25 million 
          signal sft_Reg: std_logic_vector(1 downto 0);                          -- we create a 2-bit  shift register
          
          begin
                process(clk, btn) begin --declare process. Notice we have two temporaries  (a clock period is a loop)
                        if rising_edge(clk) then  --This is the loop of one period       
                                 sft_Reg(1) <= sft_Reg(0);       --bit-1 gets value from bit-0
                                 sft_Reg(0) <= btn;        --Here we put the entity "btn" into register bit-0 (this happens no matter what the value of entity "btn" is)
                                 
                                 if(unsigned(counter) < 6250000) then         --In this case (indepedent of the value of "btn") if temporary "counter" is less than 6.25 million
                                        dbnc <= '0';           -- A "0" is put into the  output entity port "dbnc" 
                                                if(sft_Reg(1) = '1' ) then    --Addttionally, if bit-1 register is high
                                                     counter <= std_logic_vector( unsigned(counter) + 1 ); --We add a "1-integer" to temporary "counter"
                                                else
                                                     counter <= (others => '0'); -- This just puts a 26-bit "0" in the temporary "counter" (same as resetting the counter)
                                                end if; 
                                 else    -- This is if the counter has reached exaclty 6.25 million counts or more  
                                         dbnc <= '1';           --A value of high is put on the output entity for the "BUTTON"
                                                if(btn = '0') then  --Additionaly, if a "0" is detected for  ENTITY "BTN"
                                                     dbnc <= '0';            --we get an BUTTON OUTPUT ( "DBNC" ) of "0"  
                                                     counter <= (others => '0');    --We give a "0" to the temporary 26-bit "counter" (resets counter)
                                                end if;   
                                 end if;  --This end the "if/else" condition. Remember the 2nd Main if condition is part of the first "if" because there is no "endif"
                        end if;  --This ends the first "if" condition             
                end process;
end DEB;
