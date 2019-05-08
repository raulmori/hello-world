library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity sender_top is
        Port (
                   clk : in STD_LOGIC;               --This is the "CLOCK"
                   btn : in STD_LOGIC_VECTOR (2 downto 0); 
                   sw : in STD_LOGIC_VECTOR (1 downto 0);      --Constrains INPUTS are Case-Sensitive
                   led : out STD_LOGIC_VECTOR (1 downto 0)          --Constrains OUTPUTS are Case-Sensitive
             );
end sender_top; 
          
          
architecture Structural of sender_top is
          
          signal rstbtn                   : std_logic;
          signal PassOut1, PassOut2       : std_logic;
          signal Front_Sense, Back_Sense  : std_logic;
          
          
          ---------------------------------
          component Car_Parking_System_VHDL                       --Here we call "UART" which is another TOP-DESIGN
                port 
                      (
                      clk                           : in std_logic;                                   -- This is the "CLOCK"
                      reset                         : in std_logic;                                    -- This is the "RESET", and notice that the BUTTON is Inverted
                      front_sensor, back_sensor                 : in std_logic;                             -- two sensor in front and behind the gate of the car parking system   
                      pass                          : in std_logic_vector(1 downto 0);                      --  "PASSOWRD's" of 4-bits 

                      GREEN_LED, RED_LED             : out std_logic                                            -- These are the LEDs. Notice we have 2 LEDS
                     );
          end component;
          
          ---------------------------------
          component debounce              --Here we call the "BUTTON"
                Port (
                       clk        : in STD_LOGIC;
                       btn        : in STD_LOGIC;
                       dbnc       : out STD_LOGIC
                       ); 
          end component;
          ---------------------------------
          component switcher 
               port(
                     clk      : in std_logic;        -- This is the 125 Mhz clock (we know by manufacturer-standards clocks have this frequency standard)
                     sw      : in std_logic;         -- when the SWITCH is HIGH as '1' it means "ON" 
                     output  : out std_logic      -- whe
                    );
          end component;
          ---------------------------------

                    
          begin
          
          rstdbnc: debounce port map(
                                     clk => clk,        --Here we connect the MAIN-CLOCK to one of the "BUTTONS"
                                     btn => btn(0),     --Here we connect one of the MAIN "Bit-Button" to the INPUT of one of our BUTTON called "BTN"
                                     dbnc => rstbtn
                                    );

            Pass1: debounce port map(
                                     clk => clk,        --Here we connect the MAIN-CLOCK to one of the "BUTTONS"
                                     btn => btn(1),     --Here we connect one of the MAIN "Bit-Button" to the INPUT of one of our BUTTON called "BTN"
                                     dbnc => PassOut1
                                    );
          
           Pass2: debounce port map(
                                     clk => clk,        --Here we connect the MAIN-CLOCK to one of the "BUTTONS"
                                     btn => btn(2),     --Here we connect one of the MAIN "Bit-Button" to the INPUT of one of our BUTTON called "BTN"
                                     dbnc => PassOut2
                                    );
           switcheroo1: switcher port map
                                    (                       
                                    clk => clk,
                                    sw => sw(0),
                                    output => Front_Sense
                                   ); 
                                   
           switcheroo2: switcher port map
                                    (                       
                                    clk => clk,
                                    sw => sw(1),
                                    output => Back_Sense
                                   );  
            
          CarParking:  Car_Parking_System_VHDL port map
                                    (
                                    clk => clk,
                                    reset => rstbtn,
                                    front_sensor => Front_Sense,            --we are going to have to hook up the sensors to Switches
                                    back_sensor => Back_Sense,             --we are going to have to hook up the sensors to switches
                                    pass (0) => PassOut1,                   --we must use a smaller passwor because we will use 2 buttons
                                    pass (1) => PassOut2,
                                    GREEN_LED => led(0),
                                    RED_LED => led(1)
                                    );
         
end Structural;     
