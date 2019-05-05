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
        signal pass : std_logic_vector(1 downto 0) := (others => '0');
      
        signal GREEN_LED : std_logic;              --Outputs
        signal RED_LED : std_logic;
    
        constant clk_period : time := 10 ns;          -- Clock period definitions
       
 
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
        
              clk_process :process            -- Clock process definitions
                   begin
                  clk <= '0';
                  wait for clk_period/2;
                  clk <= '1';
                  wait for clk_period/2;
                   end process;
                   -- Stimulus process
                   stim_proc: process
                   begin  
                      reset <= '0';
                  front_sensor <= '0';
                  back_sensor <= '0';
                  Pass <= "0011";
                      wait for clk_period*10;
                  reset <= '1';
                  wait for clk_period*10;
                  front_sensor <= '1';
                  wait for clk_period*10;
                  Pass <= "0011";
                  Pass <= "0011";
                  back_sensor <= '1';
                  Pass <= "0011";
                  front_sensor <= '0';
                  Pass <= "0011";
                  back_sensor <= '1';
                  back_sensor <= '0';
                      -- insert your stimulus here 
                
                      wait;
                   end process;

END;
