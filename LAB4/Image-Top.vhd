--This is the TOP-DESIGN part

library ieee;
use ieee.std_logic_1164.all;


entity image_top is 
    Port (
          clk             : in std_logic;    --This is the clock
          vga_hs, vga_vs  : out std_logic;    --These are the horizontal and vertical parts
          vga_r, vga_b    : out std_logic_vector (4 downto 0);vga_g : out std_logic_vector (5 downto 0));
end image_top;
  
  
architecture rtl of image_top is
  
      signal addrSig : std_logic_vector(17 downto 0);
      signal pixelSig : std_logic_vector(7 downto 0);
      signal vsSig : std_logic;
      signal hsSig :  std_logic;
      signal vidSig : std_logic;
      signal hcountSig : std_logic_vector(9 downto 0);
      signal vcountSig : std_logic_vector(9 downto 0);
      signal enSig : std_logic;

------------------------------------------------------------
      component pixel_pusher is
            Port (
                  clk, en, vs, vid : in std_logic;
                  pixel   : in std_logic_vector (7 downto 0);
                  hcount  : in std_logic_vector (9 downto 0);
                  R, B    : out std_logic_vector (4 downto 0);
                  G       : out std_logic_vector (5 downto 0);
                  addr    : out std_logic_vector (17 downto 0));
      end component;

      ------------------------------------------------------------
      component vga_ctrl is
            Port (
                clk : in std_logic;
                en : in std_logic;
                hcount, vcount : out std_logic_vector(9 downto 0);
                vid, vs, hs : out std_logic) ;
      end component;

      ------------------------------------------------------------

      component clock_div is      --This calls the clock
          port(
              clk : in std_logic;
              div : out std_logic);
      end component;

      ------------------------------------------------------------

      component picture IS
          PORT (
              clka : IN STD_LOGIC;
              addra : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
              douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
      );
      end component;


      begin       --Here we start declaring port maps
          pixelPusher: pixel_pusher port map(                  --This port map is for PIXER-PUSHER (Part 2)
                clk => clk,
                en => enSig,
                vs => vsSig,
                pixel => pixelSig,hcount => hcountSig,vid => vidSig,
                R => vga_r,
                B => vga_b,
                G => vga_g,
                addr => addrSig);

          my_picture: picture port map(
                clka => clk, --Port map for picture
                addra => addrSig,douta => pixelSig);

          clockDiv: clock_div port map(             --This is the port map for clock-divider
                clk => clk,
                div => enSig);

          vgaCTRL: vga_ctrl port map(clk => clk,    --Port map for VGA-CTRL (Part 1)
                en => enSig,
                hcount => hcountSig,vcount => vcountSig,vid => vidSig,
                vs => vsSig,
                hs => hsSig);
                vga_vs <= vsSig;vga_hs <= hsSig;
end rtl;
