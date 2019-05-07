library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity sender_top is
        Port (
                   clk : in STD_LOGIC;               --This is the "CLOCK"
                   btn : in STD_LOGIC;  
                   LED : out STD_LOGIC_VECTOR (1 downto 0);

          
architecture Structural of sender_top is
          
          
          
          ---------------------------------
          component Car_Parking_System_VHDL                       --Here we call "UART" which is another TOP-DESIGN
                port 
                      (
                      clk                           : in std_logic;                                   -- This is the "CLOCK"
                      reset                         : in std_logic;                                    -- This is the "RESET", and notice that the BUTTON is Inverted
                      front_sensor, back_sensor                 : in std_logic;                             -- two sensor in front and behind the gate of the car parking system   
                      pass                          : in std_logic_vector(3 downto 0);                      --  "PASSOWRD's" of 4-bits 

                      GREEN_LED, RED_LED             : out std_logic                                            -- These are the LEDs. Notice we have 2 LEDS
                     );
          end component;
          
          ---------------------------------
          component debounce              --Here we call the "BUTTON"
                Port (
                       clk : in STD_LOGIC;
                       btn : in STD_LOGIC;
                       dbnc : out STD_LOGIC);
          end component;
          ---------------------------------
          begin
          
          rstdbnc: debounce port map(
                                     clk => clk,        --Here we connect the MAIN-CLOCK to one of the "BUTTONS"
                                     btn => btn,     --Here we connect one of the MAIN "Bit-Button" to the INPUT of one of our BUTTON called "BTN"
                                     dbnc => rstbtn
                                    );

            Pass1: debounce port map(
                                     clk => clk,        --Here we connect the MAIN-CLOCK to one of the "BUTTONS"
                                     btn => btn,     --Here we connect one of the MAIN "Bit-Button" to the INPUT of one of our BUTTON called "BTN"
                                     dbnc => Front
                                    );
          
           Pass2: debounce port map(
                                     clk => clk,        --Here we connect the MAIN-CLOCK to one of the "BUTTONS"
                                     btn => btn,     --Here we connect one of the MAIN "Bit-Button" to the INPUT of one of our BUTTON called "BTN"
                                     dbnc => Front
                                    );
            
          CarParking:  Car_Parking_System_VHDL port map
                                    (
                                    clk => clk,
                                    rstbtn => reset,
                                    front_sensor =>             --we are going to have to hook up the sensors to Switches
                                    back_sensor =>              --we are going to have to hook up the sensors to switches
                                    pass = >                    --we must use a smaller passwor because we will use 2 buttons
                                    GREEN_LED =>
                                    RED_LED =>
