--Remember We don't have to Test every Single "STATE", only the Most Relevant ones


LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY tb_car_parking_system_VHDL IS
END tb_car_parking_system_VHDL;

 
ARCHITECTURE behavior OF tb_car_parking_system_VHDL IS 
 
        COMPONENT Car_Parking_System_VHDL                -- Component Declaration for the car parking system in VHDL
        PORT(
             clk : IN  std_logic;
             reset_n : IN  std_logic;
             front_sensor : IN  std_logic;
             back_sensor : IN  std_logic;
             password_1 : IN  std_logic_vector(1 downto 0);
             password_2 : IN  std_logic_vector(1 downto 0);
             GREEN_LED : OUT  std_logic;
             RED_LED : OUT  std_logic;
             HEX_1 : OUT  std_logic_vector(6 downto 0);
             HEX_2 : OUT  std_logic_vector(6 downto 0)
            );
        END COMPONENT;
        

       signal clk : std_logic := '0';                                       --TEMPORARY Signals
       signal reset_n : std_logic := '0';
       signal front_sensor : std_logic := '0';
       signal back_sensor : std_logic := '0';
       signal password_1 : std_logic_vector(1 downto 0) := (others => '0');
       signal password_2 : std_logic_vector(1 downto 0) := (others => '0');
    
      
       signal GREEN_LED : std_logic;                                        --Outputs
       signal RED_LED : std_logic;
       signal HEX_1 : std_logic_vector(6 downto 0);
       signal HEX_2 : std_logic_vector(6 downto 0);
    
       
       constant clk_period : time := 10 ns;                         -- Clock period definitions
 
        BEGIN
         
           Car_park_system: Car_Parking_System_VHDL PORT MAP (              --PORT-MAP Instantiate the car parking system in VHDL
                  clk => clk,
                  reset_n => reset_n,
                  front_sensor => front_sensor,
                  back_sensor => back_sensor,
                  password_1 => password_1,
                  password_2 => password_2,
                  GREEN_LED => GREEN_LED,
                  RED_LED => RED_LED,
                  HEX_1 => HEX_1,
                  HEX_2 => HEX_2
                );
        
           
           clk_process :process                                     -- Clock process definitions
                   begin
                       clk <= '0';
                       wait for clk_period/2;               
                       clk <= '1';
                       wait for clk_period/2;
           end process;
           
           stim_proc: process                                     -- Stimulus process
                   begin  
                          reset_n <= '0';                                   --Here the "RESET" BUTTON is Pressed, so that everything Starts Fresh, and  We Start at the "IDLE" "STATE"    
                          front_sensor <= '0';
                          back_sensor <= '0';
                          password_1 <= "00";
                          password_2 <= "00";              
                     
                      wait for clk_period*10;                   --We were in an "UNKNOWN" "STATE".  We Wait for some Time, and we are now in the "IDLE" "STATE" 
                          reset_n <= '1';                                   --Here the RESET button Goes to LOW
                     
                      wait for clk_period*10;                                   --We wait for some time, and we are still in the "IDLE" "STATE"
                          front_sensor <= '1';                                              --The GATE detects a Car
                      
                      wait for clk_period*10;                    --We were in an "IDLE" "STATE".  We Wait for some Time, and we are now in the "WAIT_PASS" "STATE"     
                          password_1 <= "01";                                               --We Enter the Correct Passwords
                          password_2 <= "10";
                     
                      wait until HEX_1 = "0000010";                   --This mean we wait until we get the Message of what "STATE" we are in  This message means we are in the "RIGHT_PASS" "STATE"
                          password_1 <= "00";                                              --No Password is Necessary
                          password_2 <= "00";
                          back_sensor <= '1';                                            --The Back-Sensor is HIGH the car passes the GATE. Remember the Front_Sensor is still HIGH
                      
                      wait until HEX_1 = "0010010";                   --This mean we wait until we get the Message of what "STATE" we are in  This message means we are in the "STOP" "STATE" (because the "Front_Sensor" is still HIGH)
                      password_1 <= "01";                                               --The new Car Enters the Correct Passwords
                      password_2 <= "10";
                      front_sensor <= '0';                                              --Another Car is not Detected at the GATE. Remember the Back_Sensor is still HIGH
                      
                      wait until HEX_1 = "0000010";                --This means we wait until we get the Message of what "STATE" we are in  This message means we are in the "RIGHT_PASS" "STATE"
                          password_1 <= "00";                                               --No Password is Necessary
                          password_2 <= "00";
                          back_sensor <= '1';                                               --The GATE detects car going through it. Remember the Front_Sensor is still LOW
                     
                      wait until HEX_1 = "1111111";                --This means we wait until we get the Message of what "STATE" we are in  This message means we are in the "IDLE" "STATE"
                      back_sensor <= '0';
                      
                      
                          -- insert your stimulus here 
                      wait;
           end process;
END;
