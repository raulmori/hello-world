-- fpga4student.com FPGA projects, Verilog projects, VHDL projects
-- VHDL project: VHDL code for car parking system

--Notice that this Parking-System uses two PASSWORDS
--We should remove the "HEX" because we don't know how to use it.

--This is the Main code, We also need  "TOP-Design", a "CLOCK", a "BUTTON", a "CONSTRAIN file"
--Notice here that the "RESET" was to not be Synchronous with the "CLOCK"

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;


entity Car_Parking_System_VHDL is
        port 
              (
              clk                           : in std_logic;                                   -- This is the "CLOCK"
              reset_n                         : in std_logic;                                    -- This is the "RESET", and notice that the BUTTON is Inverted
              front_sensor, back_sensor                 : in std_logic;                             -- two sensor in front and behind the gate of the car parking system   
              password_1, password_2        : in std_logic_vector(1 downto 0);                      -- Two "PASSOWRD's" of 2-bits Each
              
              GREEN_LED,RED_LED             : out std_logic;                                            -- These are the LEDs. Notice we have 2 LEDS
              HEX_1, HEX_2                  : out std_logic_vector(6 downto 0)                     -- Two options for  what will Display on the Screen. Each one has a total of 7-Bits
              );
end Car_Parking_System_VHDL;


architecture Behavioral of Car_Parking_System_VHDL is

        type state_type is (IDLE,WAIT_PASSWORD,WRONG_PASS,RIGHT_PASS,STOP);                 --These are the STATES
        signal current_state,next_state: state_type;                                                  --Here we create TEMPORARY SIGNALS FOR THE "Preset-State" and "Next-State"
        signal counter_wait: std_logic_vector(31 downto 0);                              --This is the TEMPORARY Signal for the 'COUNTER"
        signal red_tmp, green_tmp: std_logic;                                        --These are the TEMPORARY Signals for the "LED's"

        begin
            ----------------------------------------------------
            process(clk,reset_n)                                       --Process for Switching  "Current-State" to "Next-State". We added a "RESET" button that will reset the System back to the "STATE" of "IDLE". This is a Standard-Part of the Code
            
                begin
                     if(reset_n ='0') then                                                    --When the "RESET" button is pressed. Made NOT synchronous.
                          current_state <= IDLE;                                                    --We will go to the "STATE" of "IDLE"   
                     elsif(rising_edge(clk)) then                                            --If the "RESET" Button is not Pressed 
                          current_state <= next_state;                                              --We Continue to the Appropiate "Next-State"
                     end if;
            end process;
            ----------------------------------------------------
            process(clk,reset_n)                                                      --Process for "STATE" of  Waiting  for the "PASSWORD" to be put in 
                 begin
                     if(reset_n ='0') then                                                                --If the "RESET" BUTTON is Pressed (This button is automatically Pressed not PASSWORD is put in and the Car leave). Made NOT synchronous.
                          counter_wait <= (others => '0');                                                        --This RESETS the "COUNTER". Notice we call the Counter "COUNTER_WAIT"
                     elsif(rising_edge(clk))then                                                        --If the "RESET" button is not Pressed, and at the clock Rising Edge
                          if(current_state=WAIT_PASSWORD)then                                                     --And if the Current-State is "WAIT_PASSWORD"
                             counter_wait <= counter_wait + x"00000001";                                                  --We will Start Counting. This will add "1" to the "COUNTER" 
                          else                                                                                    --If the Current-State is any other "STATE" other than "WAIT_PASSWORD" 
                             counter_wait <= (others => '0');                                                             --If will Reset the "COUNTER". Basically The "COUNTER" will not Count
                          end if;
                     end if;
            end process;
           ----------------------------------------------------
            process(current_state, front_sensor, password_1, password_2,back_sensor, counter_wait)                      --Process for Moving between Specific "STATES"
                begin
                     case current_state is      
                             when IDLE =>                                                      --When the Current-State is "IDLE"
                                   if(front_sensor = '1') then                                         -- if the front sensor is on,
                                      next_state <= WAIT_PASSWORD;                                          --If there is a car going to the gate, wait for password. We Set up the System so it can be asserted on the next CLOCK Tick
                                   else                                                                     --If the Front sensor does not detect a car
                                      next_state <= IDLE;                                                        --The "Current-State" remains on "IDLE"
                                   end if;
                             --------------------------------
                             when WAIT_PASSWORD =>                                   --When the Current-State is "WAIT_PASSWORD"
                                   if(counter_wait <= x"00000003") then                          --If there are 4 or less Counts (Also known as Ticks or Clock-Cycles)
                                      next_state <= WAIT_PASSWORD;                                    --The Current-State does NOT change, and we remain on the same "STATE" of "WAIT_PASSWORD"
                                   else                                                                    --The system detects that 4 Counts happened, So it will now require a password to be entered
                                      if((password_1="01") and (password_2="10")) then                            -- if the following "PASSWORDS were entered.
                                         next_state <= RIGHT_PASS;                                                  --It will go to the "STATE' of "RIGHT_PASS" (Opens the GATE)                  
                                      else                                                          --If the Wrong "PASSWORD" was Entered
                                         next_state <= WRONG_PASS;                                   --It will go to the "STATE" of "WRONG_PASS" (holds the GATE closed). The Green LED will Start Blinking  
                                      end if;
                                   end if;
                             --------------------------------
                             when WRONG_PASS =>                                                   --When the Current-State is "WRONG_PASSWORD". This "STATE" Lets Gives the Driver another chance to try another "PASSWORD" again
                                   if((password_1="01") and (password_2="10")) then                    -- if the following "PASSWORDS were entered.
                                      next_state <= RIGHT_PASS;                                       --It will go to the "STATE' of "RIGHT_PASS" (Opens the GATE)  
                                   else                                                                  --If the Wrong "PASSWORD" was Entered
                                      next_state <= WRONG_PASS;                                               --It will go to the "STATE" of "WRONG_PASS" (holds the GATE closed). The Green LED will Start Blinking 
                              end if;
                             -------------------------------- 
                             when RIGHT_PASS =>                                            --When the Current-State is "RIGHT_PASSWORD". This is when the Correct "PASSWORD" was entered.
                                   if(front_sensor='1' and back_sensor = '1') then                          --If "FRONT_SENSOR" detects another car at the GATE, while the "BACK_SENSOR" detects there are cars in the Parking Lot still trying to Park. (If the GATE is opening for the Current Car, and the Next Car comes, the GATE will close for the Next Car )
                                      next_state <= STOP;                                                     --It will go the "STATE" of "STOP" (STOP the Next Car and Require password)
                                   elsif(front_sensor='0' and back_sensor= '1') then                         --If the "BACK_SENSOR" detects there are cars in the Parking Lot still trying to Park. but does not detect other cars waiting at the "GATE". (if the current car passed the gate an going into the car park, and there is no next car)
                                      next_state <= IDLE;                                                       --It will go to the "STATE" of "IDLE"
                                   else                                                                     --If "BACK_SENSOR" is LOW (all the cars inside the Parking Lot have Parked) , and "FRONT_SENSOR" is HIGH (There is a car at the GATE)
                                      next_state <= RIGHT_PASS;                                     --Assuming the Password was entered Correctly, It will go to the "STATE" of "RIGHT_PASS"
                             end if;
                              --------------------------------
                             when STOP =>                                                           --When in the "STATE" of "STOP"  (This works similarly to the "WRONG_PASS" "STATE")
                                  if((password_1="01")and(password_2="10"))then                 --Check password of the next car . If the following "PASSWORD" was Entered.
                                     next_state <= RIGHT_PASS;                                                  --It will go to the "STATE" of "RIGHT_PASS"
                                  else                                                          --If the Wrong "PASSWORD" was entered 
                                     next_state <= STOP;                                    --If the Wrong "PASSWORD" was Entered
                                  end if;                                                           --It will return to the "STATE" of "STOP"
                              --------------------------------
                             when others =>                     --This is just Entered as Good VHDL practice.
                                    next_state <= IDLE;                 --If It happens that we were in any other "STATE" not described above, It will return to the "IDLE" "STATE"
                     end case;
             end process;
             
            ---------------------------------------------------- 
             process(clk)                       --Process for the "OUTPUT" for LED's and DISPLAY ( Note: If you want to change the  LED Blink Period, change the CLOCK-Cycle to make  CLOCK-ENABLE)
                 begin
                     if(rising_edge(clk)) then
                             case(current_state) is
                                     when IDLE =>                                                   --When we are in the "IDLE" "STATE"
                                             green_tmp <= '0';                                              -- The Green LED is LOW
                                             red_tmp <= '0';                                                -- The Red LED is LOW
                                             HEX_1 <= "1111111"; -- off                                              -- The Green LED is LOW
                                             HEX_2 <= "1111111"; -- off
                                     --------------------------------        
                                     when WAIT_PASSWORD =>
                                             green_tmp <= '0';
                                             red_tmp <= '1';                                   -- RED LED turn on and Display 7-segment LED as EN to let the car know they need to input password
                                             HEX_1 <= "0000110"; -- E 
                                             HEX_2 <= "0101011"; -- n 
                                     --------------------------------        
                                     when WRONG_PASS =>                                        -- When we are in the "WRONG_PASS" "STATE" (PASSWORD Entered was Wrong)
                                             green_tmp <= '0';                                           --Green LED is OFF
                                             red_tmp <= not red_tmp;                                     -- Red LED Inverts every CLOCK-Tick (LED Blinks)
                                             HEX_1 <= "0000110"; -- E
                                             HEX_2 <= "0000110"; -- E 
                                     --------------------------------
                                     when RIGHT_PASS =>                                        -- When we are in the "RIGHT_PASS" "STATE" (PASSWORD Entered was Correct)
                                             green_tmp <= not green_tmp;                                 -- Green LED Inverts every CLOCK-Tick (LED Blinks)
                                             red_tmp <= '0';                                             -- Red LED is OFF
                                             HEX_1 <= "0000010"; -- 6
                                             HEX_2 <= "1000000"; -- 0 
                                     --------------------------------
                                     when STOP =>                                              -- When we are in the "STOP" "STATE"
                                             green_tmp <= '0';                                           --Green LED is OFF
                                             red_tmp <= not red_tmp;                                     -- Red LED Inverts every CLOCK-Tick (LED Blinks)
                                             HEX_1 <= "0010010"; -- 5
                                             HEX_2 <= "0001100"; -- P 
                                     --------------------------------
                                     when others =>                                            -- This is just Entered as Good VHDL writing Practice. When we are in the any other "STATE" (It goes back to "IDLE")
                                             green_tmp <= '0';                                               -- The Red LED is LOW
                                             red_tmp <= '0';                                                 -- The Red LED is LOW
                                             HEX_1 <= "1111111"; -- off
                                             HEX_2 <= "1111111"; -- off
                              end case;
                     end if;
             end process;
            ----------------------------------------------------
         
         RED_LED <= red_tmp  ;                                                              --The TEMPORARY Red LED Signal is Converted to the MAIN "RED_LED" "OUTPUT"
         GREEN_LED <= green_tmp;                                                            --The TEMPORARY Green LED Signal is Converted to the MAIN "RED_LED" "OUTPUT"

end Behavioral;
