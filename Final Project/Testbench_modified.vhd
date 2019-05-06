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
                   
                   
              stim_proc: process              --Stimulus process. In this Process we control the Voltage OUTPUT  of the Following Signals
                       begin  
                           reset <= '1';
                           front_sensor <= '0';
                           back_sensor <= '0';
                           Pass <= "0000";
                                 wait for clk_period*10;
                          
                           reset <= '0';
                                 wait for clk_period*10;
                        
                           front_sensor <= '1';                             --The Front-Sensor goes HIGH because it detects a Car
                                 wait for clk_period*10;                          --We Wait for 10 Clock-Periods (80ns), Then We will go to the Next State
                           Pass <= "0011";                                  --We then Type in the Correct Password, Then we go to the Next State
                                 wait for clk_period*10; 
                                
                           back_sensor <= '1';                                     --The Back-Sensor goes High because it detects a Car

                           front_sensor <= '0';
                           Pass <= "0011";
                           back_sensor <= '1';
                           back_sensor <= '0';
                               -- insert your stimulus here 
                           wait;
              end process;

END;
