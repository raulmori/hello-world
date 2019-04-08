--We can use a normal clock


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
entity clock_div is port(
clk : in std_logic; -- 125 Mhz
div : out std_logic );
end clock_div;
12
architecture Behavioral of clock_div is
signal prescaler: std_logic_vector(2  downto 0) := "101"; -- 5 in binary signal counter: std_logic_vector(2  downto 0) := "001";
signal newClock : std_logic := '0';
begin
div <= newClock;
process(clk) begin
if rising_edge(clk) then if(counter = prescaler) then
newClock <= '1';
counter <= "001"; else
counter <= counter + 1;
newClock <= '0'; end if;
end if;
end process;
end Behavioral;
