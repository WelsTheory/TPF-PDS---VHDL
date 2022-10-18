LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.MATH_REAL.ALL;


ENTITY generate_wave is 
	port( 
		fw			: in std_logic_vector(11 downto 0);		-- input frequency word
		clk 		: in std_logic;							-- clock of the system 
		a_rst_h 	: in std_logic;							-- Asynchronous active - high reset
		out_sinWave : out std_logic_vector(15 downto 0);		-- output waveform sin
		out_cosWave : out std_logic_vector(15 downto 0)		-- output waveform sin
		);
END generate_wave;



ARCHITECTURE struct of generate_wave is

   -- Output of of the phase accumulator counter
	SIGNAL S_phase_sine 	: std_logic_vector(11 downto 0);
	SIGNAL S_phase_cos      : std_logic_vector(11 downto 0);

   -- Output of the LUT table
	SIGNAL lut_output_sin 	: std_logic_vector(15 downto 0);
	SIGNAL lut_output_cos   : std_logic_vector(15 downto 0);
   -- Output register for the output synchronization
	SIGNAL sine_out 		: std_logic_vector(15 downto 0);
	SIGNAL cos_out          : std_logic_vector(15 downto 0);

	-- RESERVED
	--SIGNAL start_phase 		: std_logic_vector(11 downto 0);


																	--------------------
	COMPONENT PhaseGenerator is										--PhaseGenerator
		port (														--------------------
			 clk 			: in std_logic;							--system clock
		     rst 			: in std_logic;							-- Asynchronous active - high reset
		     phase_increment : in std_logic_vector(11 downto 0);		-- FCW: Freq Control Word: phase increment: We Fix to 1
		     phase_cos       : out std_logic_vector(11 downto 0);    -- Cos oscillator
		     phase_sin    	: out std_logic_vector(11 downto 0)	-- wave1: sin Oscillator
			);
	END COMPONENT PhaseGenerator;
------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
    																--------------------
    COMPONENT sin_entity is 										-- Sinsoidal LUTCH/ROM
   		port(														--------------------
   			address: in std_logic_vector(11 downto 0);
            sine: out std_logic_vector(15 downto 0)
			);
    END COMPONENT;
    
    COMPONENT cos_entity is 										-- Sinsoidal LUTCH/ROM
   		port(														--------------------
   			address: in std_logic_vector(11 downto 0);
            cos: out std_logic_vector(15 downto 0)
			);
    END COMPONENT;

	begin


  		PHASE_ACCUMLATOR: PhaseGenerator 
			port map (
				clk 			=> clk,
				rst 			=> a_rst_h,
				phase_increment => fw,
				phase_cos 		=> S_phase_cos,
				phase_sin 		=> S_phase_sine
				);



		LUT_4096_SIN : sin_entity 
			port map(
				address => S_phase_sine,
				sine => lut_output_sin
		  );
		  
		LUT_4096_COS : cos_entity 
			port map(
				address => S_phase_cos,
				cos => lut_output_cos
		  );

     	
      DDFS_OUTPUT_REG: process(a_rst_h,clk)
			begin
			if(a_rst_h ='1') then
				sine_out <= (others => '0');
				cos_out <= (others => '0');
			elsif(rising_edge(clk)) then
			   sine_out <= lut_output_sin;
			   cos_out <= lut_output_cos;
			end if;			
		end process;
		
		out_sinWave <= sine_out;
		out_cosWave <= cos_out;

END struct;