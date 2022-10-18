LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;


ENTITY PhaseGenerator is
	port (
		clk 			: in std_logic;							--system clock
		rst 			: in std_logic;
		phase_increment : in std_logic_vector(11 downto 0);		-- FCW: Freq Control Word: phase increment
		phase_cos       : out std_logic_vector(11 downto 0);    -- Cos oscillator
		phase_sin    	: out std_logic_vector(11 downto 0)	-- wave1: sin Oscillator
	);
END PhaseGenerator;


ARCHITECTURE arch of PhaseGenerator is

	SIGNAL signal_sin 			: unsigned(11 downto 0);
	SIGNAL accum_cos        : unsigned(11 downto 0);
	SIGNAL signal_cos 		: unsigned(11 downto 0);
	--SIGNAL phase_offset_d 	: unsigned(11 downto 0);

begin

	--Main Phase Accumulation process
	main : process(clk,rst)
	begin
			if rst = '1' then
				signal_sin    <= (others => '0');
				accum_cos <= "010000000010";
				--phase_int    <= (others => '0');
			elsif (rising_edge(clk)) then
				signal_sin    <= signal_sin + unsigned(phase_increment);
				signal_cos    <= signal_sin + accum_cos;
			end if;
	end process;

	phase_cos   <= std_logic_vector(signal_cos);
	phase_sin   <= std_logic_vector(signal_sin);

end arch;