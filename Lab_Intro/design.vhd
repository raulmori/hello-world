------------------------------------
-- Lab 1 Sample
-- Prepared by: Gregory Leonberg
------------------------------------

-------------------------------------------------------------
-- required library include and use statement in order to use std_logic_vector type
-------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

-------------------------------------------------------------
-- entity "black-box declaration"
-------------------------------------------------------------
entity lab1 is
        port 
          (
            swt : in std_logic_vector (7 downto 0);             --Notice here we use 8 "SWITCH's"
            led : out std_logic_vector (7 downto 0)             --Notice here we use 8 "LED's" 
          );
end lab1;

-------------------------------------------------------------
-- architecture "internal implementation"
-------------------------------------------------------------
architecture simple of lab1 is

	signal val : std_logic_vector(7 downto 0) := (others => '0');              --This is a TEMPORARY Signal
	
        begin
            val(0) <= not swt(0);
            val(1) <= swt(1) and not swt(2);
            val(3) <= swt(2) and swt(3);
            val(2) <= val(1) or val(3);
            val(7 downto 4) <= swt(7 downto 4);
            
         led <= val;                                                        --Here the TEMPORARY "VAL" is Put into the Main OUTPUT "LED"
end simple;
