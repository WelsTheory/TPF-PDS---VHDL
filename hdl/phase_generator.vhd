LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;


ENTITY PhaseGenerator is
	port (
		clk 			: in std_logic;							--system clock
		rst 			: in std_logic;							-- Asynchronous active - high reset
		phase_increment : in std_logic_vector(11 downto 0);		-- FCW: Freq Control Word: phase increment: We Fix to 1
		phase_cos       : out std_logic_vector(11 downto 0);    -- Cos oscillator
		phase_sin    	: out std_logic_vector(11 downto 0)	-- wave1: sin Oscillator
	);
END PhaseGenerator;


------------------------------------------------------------------------------------------
-- ARCHITICTURE OF PHASE ACCUMLATOR
------------------------------------------------------------------------------------------
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
				accum_cos <= "010000000010";	-- @pi/2 to index the cosine waveform so count from 1024
				--phase_int    <= (others => '0');
			elsif (rising_edge(clk)) then
				signal_sin    <= signal_sin + unsigned(phase_increment);
				signal_cos    <= signal_sin + accum_cos;
			end if;
	end process;

	phase_cos   <= std_logic_vector(signal_cos); 	-- fetch the cosine waveform by addresses
	phase_sin   <= std_logic_vector(signal_sin);			-- fetch the cosine waveform by addresses

end arch;