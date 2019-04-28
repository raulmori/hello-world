


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_2to1 is
    Port 
        ( 
        input1    : in std_logic;
        input2    : in std_logic;
        selector  : in std_logic;
        output    : out std_logic       
         );
end mux_2to1;

  
architecture Behavioral of mux_2to1 is

      begin
          output <=
                    input1 WHEN selector ='1' ELSE     --Notice that we don't bother to make a case for "0"
                    input2;                                    --because the other choice than "1" is "0".
end Behavioral;
