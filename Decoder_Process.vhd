   decoder : process(SL1)                  --In this case we use "PROCESS" to make the DECODER
                  begin
                      if (SL1 = '0') then
                          LDB <= '1';
                          LDA <= '0';
                      elsif (SL1 = '1') then
                          LDB <= '0';
                          LDA <= '1';
                      else
                          LDA <= '0';
                          LDB <= '0';
                      end if;
        end process; 
