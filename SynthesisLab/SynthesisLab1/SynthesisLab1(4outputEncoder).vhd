--Here we use "CONDITIONAL-SIGNAL-ASSIGNMENT"

library IEEE;
use IEEE.std_logic_1164.all;


entity encoder4bits is      -- entity
       port ( 
             D_IN : in std_logic_vector(3 downto 0);
             SZ_OUT : out std_logic_vector(1 downto 0)
             );
end encoder4bits;
  
  
architecture Behavioral of encoder4bits is
      begin
          SZ_OUT <=
                  "00" when (D_IN = "0001") else
                  "01" when (D_IN = "0010") else
                  "10" when (D_IN = "0100") else
                  "11" when (D_IN = "1000") else
                      "00" ;         
end Behavioral;
