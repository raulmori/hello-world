libraryieee;
useieee.std_logic_1164.all;

entity vga_ctrl_tb is

end vga_ctrl_tb;

architecturetestbench of vga_ctrl_tb is

component vga_ctrl is
Port ( clk	: in std_logic ;
en	: in std _logic; 
hcount, vcount : out std_logic_vector( 9 downto 0 );
vid, vs, hs	: out std_logic);
end component ;

signal clkSig	: std_logic.:='0' ;
signal enSig	: std _logic := '0';
signal hcountSig	: std_logic_vector ( 9 downto 0 ) := ( others => '0') ;
signal vcountSig	: std_logic_vector (9 downto 0 ) := ( others => '0' );
signal vidSig	: std_logic := '0' ;
signal vsSig	: std_logic := '0' ;
signal hsSig	 : std_logic := '0' ;

begin

test : vga_ctrl  port map (
clk	=> clkSig, 
en	 => enSig ,
hcount => hcountSig, 
vcount => vcountSig, 
vid	=> vidSig, 
vs	 => vsSig ,
hs	=> hsSig) ; 

process

begin

for i  in0 to 1000 loop-- i = iteration counter
clkSig <='0';
enSig <='0';

wait for 10 ns ;


clkSig <='1';
enSig <='1';

wait for 10 ns;
endloop;

end process;

end testbench ;
