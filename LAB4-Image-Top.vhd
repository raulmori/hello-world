--This is the TOP-DESIGN part

library ieee;
use ieee.std_logic_1164.all;
entity image_top isPort (
clk : in std_logic;
vga_hs, vga_vs : out std_logic;
vga_r, vga_b : out std_logic_vector (4 downto 0);vga_g : out std_logic_vector (5 downto 0));
end image_top;
architecture rtl of image_top is
component pixel_pusher is
Port ( clk, en, vs, vid : in std_logic;
10
: in std_logic_vector (7 downto 0);
: in std_logic_vector (9 downto 0);: out std_logic_vector (4 downto 0);
: out std_logic_vector (5 downto 0);
: out std_logic_vector (17 downto 0));
component vga_ctrl is
Port ( clk : in std_logic;
en : in std_logic;
hcount, vcount : out std_logic_vector(9 downto 0);vid, vs, hs : out std_logic) ;
end component;
component clock_div isport(
clk : in std_logic;
div : out std_logic);
end component;
component picture ISPORT (
clka : IN STD_LOGIC;
addra : IN STD_LOGIC_VECTOR(1 7 DOWNTO 0);douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
);
end component;
signal addrSig : std_logic_vector(17 downto 0);signal pixelSig : std_logic_vector(7 downto 0);
pixel hcount R, B
G addr
end component;
11
signal vsSig
signal hsSig
signal vidSig
signal hcountSig : std_logic_vector(9 downto 0);signal vcountSig : std_logic_vector(9 downto 0);signal enSig : std_logic;
begin
pixelPusher: pixel_pusher port map(clk => clk,
en => enSig,
: std_logic;: std_logic;: std_logic;
vs => vsSig,
pixel => pixelSig,hcount => hcountSig,vid => vidSig,
R => vga_r,
B => vga_b,
G => vga_g,
addr => addrSig);
my_picture: picture port map(clka => clk,
addra => addrSig,douta => pixelSig);
clockDiv: clock_div port map(clk => clk,
div => enSig);
vgaCTRL: vga_ctrl port map(clk => clk,
en => enSig,
hcount => hcountSig,vcount => vcountSig,vid => vidSig,
vs => vsSig,
hs => hsSig);
vga_vs <= vsSig;vga_hs <= hsSig;
end rtl;
