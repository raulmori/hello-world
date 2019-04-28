

library IEEE;
use IEEE.std_logic_1164.all;


entity encoder4bits is      -- entity
       port ( 
             D_IN : in std_logic_vector(15 downto 0);
             SZ_OUT : out std_logic_vector(3 downto 0)
             );
end encoder4bits;
  
  
architecture Behavioral of encoder4bits is
      begin
          SZ_OUT <=
                  "0000" when (D_IN = "0000000000000001") else
                  "0001" when (D_IN = "0000000000000010") else
                  "0010" when (D_IN = "0000000000000100") else
                  "0011" when (D_IN = "0000000000001000") else
                  "0100" when (D_IN = "0000000000010000") else
                  "0101" when (D_IN = "0000000000100000") else
                  "0110" when (D_IN = "0000000001000000") else
                  "0111" when (D_IN = "0000000010000000") else
                  "1000" when (D_IN = "0000000100000000") else
                  "1001" when (D_IN = "0000001000000000") else
                  "1010" when (D_IN = "0000010000000000") else
                  "1011" when (D_IN = "0000100000000000") else
                  "1100" when (D_IN = "0001000000000000") else
                  "1101" when (D_IN = "0010000000000000") else
                  "1110" when (D_IN = "0100000000000000") else
                  "1111" when (D_IN = "1000000000000000") else
                      "0000" ;
            
end Behavioral;
