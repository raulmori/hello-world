library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is
port (
  clk : in std_logic;
  cnt : out std_logic_vector (3 downto 0)
);
end counter;

architecture cnt of counter is
  signal count : std_logic_vector (3 downto 0) := (others => '0');
begin

  cnt <= count;
  
  process(clk) begin
    if rising_edge(clk) then
      count <= std_logic_vector( unsigned(count) + 1 );
    end if;
  end process;

end cnt;
