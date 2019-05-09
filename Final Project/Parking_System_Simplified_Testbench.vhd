-- fpga4student.com FPGA projects, Verilog projects, VHDL projects
-- VHDL project: VHDL code for car parking system
-- Testbench code for car parking system in VHDL



LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY tb_car_parking_system_VHDL IS
END tb_car_parking_system_VHDL;
 
ARCHITECTURE behavior OF tb_car_parking_system_VHDL IS 
 
     
 
        COMPONENT Car_Parking_System_VHDL        -- Component Declaration for the car parking system in VHDL
        PORT(
             clk : IN  std_logic;
             reset : IN  std_logic;
             front_sensor : IN  std_logic;
             back_sensor : IN  std_logic;
             Pass : IN  std_logic_vector(3 downto 0);
             
             GREEN_LED : OUT  std_logic;
             RED_LED : OUT  std_logic
            );
        END COMPONENT;
    
        signal clk : std_logic := '0';
        signal reset : std_logic := '0';
        signal front_sensor : std_logic := '0';
        signal back_sensor : std_logic := '0';
        signal pass : std_logic_vector(3 downto 0) := (others => '0');
      
        signal GREEN_LED : std_logic;              --Outputs
        signal RED_LED : std_logic;
    
        constant clk_period : time := 8 ns;          -- We define our "CLOCK" Period a 8NanoSeconds because we have a Clock-Frequency of 125Mhz
       
 
        BEGIN
         
              Car_park_system: Car_Parking_System_VHDL PORT MAP     -- Instantiate the car parking system in VHDL
                     (      
                      clk => clk,
                      reset => reset,
                      front_sensor => front_sensor,
                      back_sensor => back_sensor,
                      Pass => Pass,
                      GREEN_LED => GREEN_LED,
                      RED_LED => RED_LED
                      );
        
              clk_process :process            --In this Process we control the "CLOCK's" Voltage OUTPUT.
                       begin
                           clk <= '0';                            --Remember that for Half of the Clock-Tick Cycle the Clock is LOW
                           wait for clk_period/2;                 
                           clk <= '1';                            --Remember that for the other Half of the Clock-Tick Cycle the Clock is HIGH
                           wait for clk_period/2;                     --This gives us Half of a Clock Tick Cycle
              end process;
                   
                   
              stim_proc: process                        --Stimulus process. In this Process we control the Voltage OUTPUT  of the Following Signals
                       begin                                        --We Start by Changing all the Signals to LOW
                               reset <= '1';                                    --We Turn "RESET" to HIGH. This will turn all Signals to LOW       
                               front_sensor <= '0';
                               back_sensor <= '0';
                               Pass <= "0000";
                          
                           wait for clk_period*10;                  --We were in an "UNKNOWN" "STATE".  We Wait for some Time, and we are now in the "IDLE" "STATE" 
                               reset <= '0';                                    --The "RESET" is changed back to LOW
                            
                           wait for clk_period*10;                  --We were in an "IDLE" "STATE".  We Wait for some Time, and we continue being in the "IDLE" "STATE" 
                               front_sensor <= '1';                             --The Front-Sensor goes HIGH which means it detects a Car
                          
                           wait for clk_period*10;                  --We were in an "IDLE" "STATE".  We Wait for some Time, and we are now in the "ASK_PASS" "STATE"
                               Pass <= "0011";                                  --Here we type in the Correct Password
                              
                           wait until GREEN_LED = '1';            --We were in an "ASK_PASS" "STATE".  We Wait for some Time, and we are now in the "OPEN_GATE" "STATE"
                               back_sensor <= '1';                              --The Back-Sensor is changed to High which mean the car Crosses the GATE. Remember the Front_Sensor is still HIGH
                               Pass <= "0000";
                           
                           wait until RED_LED = '1';                  --We were in an "OPEN_GATE" "STATE".  We Wait for some Time, and we are now in the "STOP" "STATE"
                               back_sensor <= '0';                              --The Back-Sensor is changed to LOW  which means the car Crossed the GATE. Remember the Front_Sensor is still HIGH
                               
                           wait until RED_LED = '0';                  --We were in an "STOP" "STATE".  We Wait for some Time, and we are now in the "ASK_PASS" "STATE" again
                               Pass <= "0011";                                  --Here we type in the Correct Password
                             
                           wait until GREEN_LED = '1';                  --We were in an "ASK_PASS" "STATE".  We Wait for some Time, and we are now in the "OPEN_GATE" "STATE"
                               back_sensor <= '1';                              --The Back-Sensor is changed to High which mean the car Crosses the GATE. Remember the Front_Sensor is still HIGH
                               front_sensor <= '0';
                               Pass <= "0000";
                               
                           wait until GREEN_LED = '0';                  --We were in an "OPEN_GATE" "STATE".  We Wait for some Time, and we are now in the "STOP" "STATE"
                               back_sensor <= '0';                              --The Back-Sensor is changed to LOW  which means the car Crossed the GATE.     
                               front_sensor <= '0';                             -- The Front_Sensor is changed to LOW
                               
                           wait for clk_period*10;                  --We were in an "STOP" "STATE".  We Wait for some Time, and we are now in the "IDLE" "STATE" 
                               
                               
                               -- insert your stimulus here 
                           wait;
              end process;

END;
