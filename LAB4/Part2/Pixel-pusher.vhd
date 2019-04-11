
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pixel_pusher is
      Port (
            clk, en, vs, vid : in std_logic;  
            pixel:      in std_logic_vector (7 downto 0);
            hcount:     in std_logic_vector (9 downto 0);
            
            R, B:       out std_logic_vector (4 downto 0);
            G:          out std_logic_vector (5 downto 0);
            addr:       out std_logic_vector (17 downto 0));
end pixel_pusher;


architecture rtl of pixel_pusher is
        signal addrSig : unsigned(17 downto 0) := (others => '0');     --This is a temporary signal
        
        begin
            addr <= std_logic_vector(addrSig);        
            
-------------------------------------------------------------------------------------                
            
            process(clk)begin       --This is the first process
                if(rising_edge(clk)) then if (vs = '0') then
                        addrSig <= (others => '0');
                elsif (en = '1' and hcount < "0111100000" and vid = '1') then -- 480 = "0111100000"
                        addrSig <= addrSig + 1 ;end if;
                end if;end process;
                
-------------------------------------------------------------------------------------                
                
            process(clk)begin       --This is the second process
                if(rising_edge(clk)and en ='1' ) then
                      if( vid = '1' and hcount < "0111100000") then -- 480 = "0111100000"
                           R <= pixel(7 downto 5) & "00";G <= pixel(4 downto 2) & "000";B <= pixel(1 downto 0) & "000";
                else
                      R <= (others => '0');G <= (others => '0');B <= (others => '0');
                end if;end if;
-------------------------------------------------------------------------------------                
                
end process;end rtl;
