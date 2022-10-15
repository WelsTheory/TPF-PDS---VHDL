LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.MATH_REAL.ALL;

ENTITY qam_mod is
port (
  i_clk                       : in  std_logic;                      -- System clock
  i_rstb                      : in  std_logic;                      -- Asynchronous active - high reset
  i_fcw                       : in  std_logic_vector(11 downto 0);  -- Frequency Control Word [Phase Increment]
  i_meta_sym                  : in  std_logic_vector(1 downto 0);   -- Input Symbols for 4-QAM
  I_Mixer                     : out std_logic_vector(18 downto 0);
  Q_Mixer                     : out std_logic_vector(18 downto 0));  -- sin Mixer Output
end qam_mod;

ARCHITECTURE rtl of qam_mod is
                        --------------------
    COMPONENT qam_mapper                                                    -- QAM MAPPER
        port (                                                              --------------------
            i_meta_sym      : in std_logic_vector (1 downto 0);             -- Input DATA
            I_symbols		: out std_logic_vector (1 downto 0);
            Q_symbols       : out std_logic_vector (1 downto 0);            -- Quadrature-Phase Symbols
            i_clk           : in  std_logic;                                -- system clock
            i_rstb          : in  std_logic                                 -- Asynchronous active - high reset
            );  
    end COMPONENT;

                                                                            --------------------
    COMPONENT generate_wave is                                                       -- Digital Oscillator
        port(                                                               --------------------
            fw			: in std_logic_vector(11 downto 0);		-- input frequency word
            clk 		: in std_logic;							-- clock of the system 
		    a_rst_h 	: in std_logic;							-- Asynchronous active - high reset
            out_sinWave : out std_logic_vector(15 downto 0);		-- output waveform sin
            out_cosWave : out std_logic_vector(15 downto 0)
        );
    end COMPONENT generate_wave;
 
------------------------------------------------------------------------------------------

    --***************************************
    --START WIRING THE SUB-SYSTEM COMPONENT
    --***************************************
    SIGNAL Q_sine                      : std_logic_vector(15 downto 0);
    SIGNAL I_cos                       : std_logic_vector(15 downto 0);

    SIGNAL I_mapper                    : std_logic_vector(1 downto 0);
    SIGNAL Q_mapper                    : std_logic_vector(1 downto 0);
--    SIGNAL r_molulator                 : signed(11 downto 0);               --modulator output
    SIGNAL I_molulator                 : signed(18 downto 0);
    SIGNAL Q_molulator                 : signed(18 downto 0);               --modulator output

    SIGNAL I_upconverted               : signed(18 downto 0); 
    SIGNAL Q_upconverted               : signed(18 downto 0);                -- 6 + 2 + 1 bit sign always '0'

    begin

        
        Q_Mixer     <= std_logic_vector(Q_molulator);
        I_Mixer     <= std_logic_vector(I_molulator);

        u_mapper_qam : qam_mapper
            port map(
                i_meta_sym      => i_meta_sym,
                I_symbols       => I_mapper,
                Q_symbols       => Q_mapper,
                i_clk           => i_clk ,
                i_rstb          => i_rstb
             );


        u_generate_wave : generate_wave
            port map(
                fw              =>i_fcw,
                clk             =>i_clk,
                a_rst_h         =>i_rstb,
                out_sinWave     =>Q_sine,
                out_cosWave     =>I_cos 
                );


    p_mod_qam : process(i_clk,i_rstb)
    begin
      if(i_rstb='1') then
        I_upconverted          <= (others=>'0');
        Q_upconverted          <= (others=>'0');
        I_molulator            <= (others=>'0');
        Q_molulator            <= (others=>'0');
      elsif(rising_edge(i_clk)) then
        I_upconverted          <= signed(I_cos) * signed('0'&I_mapper);
        Q_upconverted          <= signed(Q_sine) * signed('0'&Q_mapper);
        -- 12 MSB; bit 22 and bit 21 are always the same 
        I_molulator                <= I_upconverted;
        Q_molulator                <= Q_upconverted;

      end if;
    end process p_mod_qam;

end rtl;
