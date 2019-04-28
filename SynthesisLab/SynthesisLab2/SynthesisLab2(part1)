
----------------------------------------------------------------------------------
--WE ARE GOING TO USE A D FLIP FLOP SINCE IT IS THE MOST COMMON.
--REMEMBER THAT D-FLIPFLOPS CREATE AN OUTPUT ON RISING EDGE ONLY

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity flip_flopD is
  Port (

CLK,D : in std_logic;
Reset : in std_logic;
Q : out std_logic

 );
end flip_flopD;

architecture Behavioral of flip_flopD is

begin


process (CLK)
begin
   if (CLK'event and CLK ='1') then
      if Reset='1' then
        Q <= '0';
      else
         Q <= D;
      end if;
   end if;
end process;

end Behavioral;

--Remember that VIVADO assumed we were looking to make a flip flop
