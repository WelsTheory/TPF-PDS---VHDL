library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity nine_counter is
  port(
    send: in std_logic;
    reset:in std_logic;
    clk: in std_logic;
    CC: in std_logic; --RESET COUNTER
    period: in std_logic_vector(1 downto 0); -- 00=1ms -- 01=0.01s -- 10=0.1s
    address_bus: out std_logic_vector(6 downto 0)
  );
end entity nine_counter;

architecture counter_arch of nine_counter is
  signal r_reg: unsigned(6 downto 0) := "0000000";
  signal r_next: unsigned(6 downto 0):= "0000000";
begin
  process(clk, CC)
    begin 
    if(reset='0') then 
      r_reg <= r_reg;
    else  
      if(CC = '0') then 
        r_reg <= (others => '0');
      elsif(clk'event and clk='1') then
        r_reg <= r_next;
      end if; 
    end if;
    end process;

    r_next <= r_reg +1 when r_reg/="1100011" and send ='1' else--(dataPoints="00" and send='1') else -- 100 sample rate
              r_reg when reset ='0' or send ='0'
              else (others => '0');

    address_bus <= std_logic_vector(r_reg);
end counter_arch;
