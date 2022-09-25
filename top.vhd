library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity top is
	port ( 
		CLOCK_100: in std_logic;
		reset: in std_logic;
		wave_period: in std_logic_vector(1 downto 0);
		val: out std_logic_vector(15 downto 0)
  	);
end top;

architecture top_arch of top is
	signal address_sig: std_logic_vector(6 downto 0);
	signal data_sig: real;

	signal counterClear: std_logic; --CC

	signal DOutput: std_logic_vector(15 downto 0); --Q

	signal sender: std_logic:='0';

	component clocked_fsm is
		port(
			clk,reset : in std_logic;
			send: in std_logic; -- waiter
			waveform_period: in std_logic_vector(1 downto 0);
			CC: out std_logic -- Clear Counter
		);
	end component;

	component nine_counter
	  port(
	    send: in std_logic;
	    reset:in std_logic;
	    clk: in std_logic;
	    CC: in std_logic; --RESET COUNTER
	    period: in std_logic_vector(1 downto 0); -- 00=1ms -- 01=0.01s -- 10=0.1s
	    address_bus: out std_logic_vector(6 downto 0)
	  );
	end component;

	component rom is
		port ( 
			 address: in std_logic_vector(6 downto 0);
		     value : out std_logic_vector(15 downto 0)
		);
	end component rom;

	component waiter is
	  port(
	    clk: in std_logic;
	    CC: in std_logic; --RESET COUNTER
	    period: in std_logic_vector(1 downto 0); -- 00=1ms -- 01=0.01s -- 10=0.1s
	    max: out std_logic
	  );
	  end component waiter;

begin
	L0: clocked_fsm port map(CLOCK_100, reset, sender, wave_period, counterClear);
	L1: waiter port map(CLOCK_100,counterClear,wave_period,sender);
	L2: nine_counter port map(sender,reset, CLOCK_100, counterClear,wave_period,address_sig);
	L3: rom port map(address_sig, DOutput);
	val <= DOutput;
end top_arch;