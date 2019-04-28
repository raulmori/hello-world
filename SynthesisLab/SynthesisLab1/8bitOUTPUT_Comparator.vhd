--the output is 8-bits, so the INPUT must be 3 bits
-- 8-bit comparator

--This comparator is missing information

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Comparator entity
entity comparator_8bit is
    Port ( Input_A : in STD_LOGIC_VECTOR (7 downto 0);  -- 8-bit Bus for first input
           Input_B : in STD_LOGIC_VECTOR (7 downto 0);  -- 8-bit Bus for second input
           COMPARE_OUT : out STD_LOGIC);                -- Output
end comparator_8bit;

-- Comparator architecture
architecture comparator_8bit_arch of comparator_8bit is
begin

    compare: process(Input_A, Input_B)      -- Process statement to compare inputs A and B
    begin
        if (Input_A = Input_B) then       -- if statement, compare inputs and update output if equal
            COMPARE_OUT <= '1';
        else
            COMPARE_OUT <= '0';
        end if;
    end process;

end comparator_8bit_arch;
