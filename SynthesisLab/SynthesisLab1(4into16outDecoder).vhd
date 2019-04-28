--

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
            SZ_OUT : out std_logic_vector(15 downto 0)
            );
end decoder4bits;

    
architecture Behavioral of decoder4bits is

        begin
            SZ_OUT <=
                "0000000000000001" when (D_IN = "0000") else
                "0000000000000010" when (D_IN = "0001") else
                "0000000000000100" when (D_IN = "0010") else
                "0000000000001000" when (D_IN = "0011") else
                "0000000000010000" when (D_IN = "0100") else
                "0000000000100000" when (D_IN = "0101") else
                "0000000001000000" when (D_IN = "0110") else
                "0000000010000000" when (D_IN = "0111") else
                "0000000100000000" when (D_IN = "1000") else
                "0000001000000000" when (D_IN = "1001") else
                "0000010000000000" when (D_IN = "1010") else
                "0000100000000000" when (D_IN = "1011") else
                "0001000000000000" when (D_IN = "1100") else
                "0010000000000000" when (D_IN = "1101") else
                "0100000000000000" when (D_IN = "1110") else
                "1000000000000000" when (D_IN = "1111") else
                "0000000000000000";
end Behavioral;
