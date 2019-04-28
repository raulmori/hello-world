library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity counter is
      port (
          clk : in std_logic;
          cnt : out std_logic_vector (3 downto 0)       --Notice here we created an ENITITY for the "COUNTER"
          );
end counter;

  
architecture cnt of counter is
      signal count : std_logic_vector (3 downto 0) := (others => '0');  --Remember our temporary Signal Counter always has to have this

      begin
        cnt <= count;             --Here we replace the Entity value for the TEMPORARY VALUE. (This is not necessary because we can eliminate the the ENITITY-counter and this line)

        process(clk) begin
              if rising_edge(clk) then      --Notice any action only happens on a rising clock edge.
                   count <= std_logic_vector( unsigned(count) + 1 );  --Notice here we have to use both "STD-LOGIC-VECTOR" and "UNSIGNED" so we can alter the counter 
              end if;
        end process;
end cnt;
