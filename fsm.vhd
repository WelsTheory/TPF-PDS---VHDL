
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity clocked_fsm is
	port(
		clk,reset : in std_logic;
		send: in std_logic;
		waveform_period: in std_logic_vector(1 downto 0);
		CC: out std_logic -- Clear Counter
	);
end clocked_fsm;

architecture clocked_fsm_arch of clocked_fsm is
	type waveform_state_type is (s0, s1, s2, s3);
	signal reg_state, next_state: waveform_state_type;
begin
	--State Register Logic
	process(clk, reset)
	begin
		-- Active Low FSM Reset
		if (reset = '0') 
			then reg_state <=s0;
		elsif (clk'event and clk ='1') 
			then reg_state <= next_state;
		end if; 
	end process;

	--Next State Logic 
	process(reg_state, reset, send)
	begin
		case reg_state is 
			when s0 => 
				if (reset ='1') then next_state <= s1;
				else next_state <= s0; 
				end if;
			when s1 => 
				if (reset ='0') then next_state <= s1;
				else next_state <= s2;
				end if;
			when s2 => 
				if (reset ='0') then next_state <= s2;
				else
					if(send = '1') then next_state <= s3;
					else next_state <= s2;
					end  if;
				end if;
			when s3 => 
				if (reset ='0') then next_state <= s3;
				else next_state <= s1;
				end if;
		end case;
	end process;

	--Moore Output Logic
	process(reg_state)
	begin
		case reg_state is 
			when s0 => 
				CC <= '0';
			when s1 => 
				--P  <= '0';
				CC <= '1';			
			when s2 => 
				--LP <= '1'; 
			when s3 => 
				--LP <= '0';
				--EN <= '1';
				--P <= not clk;
		end case;
	end process;
end clocked_fsm_arch;
