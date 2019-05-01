--Remember that We don't have to build our logic using Separated-Multiple PROCESSES, but we choose to do it because it's good VHDL Practice.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pixel_pusher is
      Port (
            clk              : in std_logic;  
            en               : in std_logic;
            vs, vid          : in std_logic;
            pixel            : in std_logic_vector (7 downto 0);
            hcount           : in std_logic_vector (9 downto 0);
            
            R, B:       out std_logic_vector (4 downto 0);
            G:          out std_logic_vector (5 downto 0);
            addr:       out std_logic_vector (17 downto 0));        --This is just a general COUNTER (Wierd Name for a COUNTER, Remember we could name it anything else to make it more Relevant)
end pixel_pusher;


architecture rtl of pixel_pusher is

        signal addrSig : unsigned(17 downto 0) := (others => '0');     --This is a TEMPORARY Signal Initialized to "0"
        
        begin
                        
            process(clk)begin       --This is the first process
                    if(rising_edge(clk)) then 
                            if (vs = '0') then                          --If the "Vertical-Sync" is HIGH
                                     addrSig <= (others => '0');            --Here the COUNTER is "addrSig" is RESET to "0"
                            else                                            
                                 if (en = '1' and hcount < "0111100000" and vid = '1') then                       -- Here the "HORIZONTAL-COUNT" is Less-Than  "480" in Binary
                                     addrSig <= addrSig + 1 ;
                                 end if;    
                            end if;
                    end if;
            end process;
                               
-------------------------------------------------------------------------------------                
            process(clk)begin       --This is the second process
                    if(rising_edge(clk)and en ='1' ) then   
                            if( vid = '1' and hcount < "0111100000") then                               -- Here the "HORIZONTAL-COUNT" is Less-Than  "480" in Binary                   
                                    R <= pixel(7 downto 5) & "00";
                                    G <= pixel(4 downto 2) & "000";
                                    B <= pixel(1 downto 0) & "000";
                            else
                                    R <= (others => '0');
                                    G <= (others => '0');
                                    B <= (others => '0');
                            end if;
                    end if;
            end process;
                   
-------------------------------------------------------------------------------------        

            addr <= std_logic_vector(addrSig);      --Here the TEMPORARY COUNTER "addrSig" is Connected to the Main COUNTER "ADDR"

end rtl;

