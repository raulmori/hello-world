--This was suppose to refer to a 4-bit OUTPUT and 2-bit INPUT

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity decoder4bits is
        port
            (  
            D_IN : in std_logic_vector(3 downto 0);
            SZ_OUT : out std_logic_vector(1 downto 0)
            );
end decoder4bits;

    
architecture Behavioral of decoder4bits is

        begin
            SZ_OUT <=
                "0001" when (D_IN = "00") else
                "0010" when (D_IN = "01") else
                "0100" when (D_IN = "10") else
                "1000" when (D_IN = "11") else
                 "0000";
end Behavioral;
