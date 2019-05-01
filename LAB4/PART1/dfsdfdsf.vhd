library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity vga_ctrl is
    Port( 
          clk : in std_logic;
          en : in std_logic;            --This is the "CLOCK-ENABLE" (OUTPUT of The Clock-Divider we made)
          
          hcount, vcount : out std_logic_vector(9 downto 0);
          vid, vs, hs :out std_logic) ;
end vga_ctrl;


architecture rtl of vga_ctrl is
        signal hcountSig : unsigned(9 downto 0) := (others => '0'); -- 10 bit counter to count up to 800 pixels
        signal vcountSig : unsigned(9 downto 0) := (others =>'0'); -- 10 bit counter to count up to 525 pixels

 
        Begin
            process(clk, en)  -- process to increment horizontal counter and vertical counter
                   begin
                        if rising_edge(clk) then
                            if en = '1' then             
                                    if (hcountSig = "1100011111") then               -- This is the Number 799 in Binary
                                            hcountSig <= (others => '0');                  --When the "HORIZONTAL-COUNTER"  has reached 799, the "HORIZONTAL-COUNTER" will RESET
                                    else
                                            hcountSig <= hcountSig + 1;
                                    end if;
                                    -------------------------------------
                                    if (vcountSig = "1000001100") then         -- This is the Number 524 in Binary.
                                             vcountSig <= (others => '0');             --When the "VERTICAL-COUNTER" has reached 524, the "HORIZONTAL-COUNTER" will RESET
                                    else
                                             vcountSig <= vcountSig + 1;        --When the "VERTICAL-COUNTER" has NOT yet reached 524, it will add "1" to the "VERTICAL-COUNTER"
                                    end if;    
                            end if;
                        end if;
            end process;
-------------------------------------------------------------------------------
            
            process(hcountSig, vcountSig) -- process to control display
                    Begin
                            if (hcountSig <= "1001111111" and vcountSig <= "0111011111") 
                                then -- 629 = "1001111111", 479 = "0111011111"
                                    vid <= '1'; -- display on
                            else
                                 vid <= '0'; -- output black
                            end if;
            end process;
--------------------------------------------------------------------------------                          
               
            process(hcountSig, vcountSig) -- process to control horizontal sync and vertical sync
                begin
                    if (hcountSig >= "1010010000" and hcountSig <= "1011101111")
                         then -- 656 = "1010010000", 751 = "1011101111"
                                 hs <= '0';
                    else
                         hs <= '1';
                    end if;
                    
                    if (vcountSig >= "0111101010" and vcountSig <= "0111101011")
                         then -- 490 = "0111101010", 491 = "0111101011"
                                vs <= '0';
                    else
                        vs <= '1';
                    end if;
            end process;
            
        
            hcount <= std_logic_vector(hcountSig);      --This is one of the Final outputs
            vcount <= std_logic_vector(vcountSig);      --This is the other Final output
                
end rtl;                        --This ends the ARCHITECTURE