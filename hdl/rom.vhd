library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity rom is
	port ( 
		address: in std_logic_vector(6 downto 0);
		value : out std_logic_vector(15 downto 0)
	);
end entity rom;

architecture rom_arch of rom is
	signal F1: std_logic_vector(15 downto 0);

	component sin_entity
		Port (
            address: in std_logic_vector(6 downto 0);
            sine: out std_logic_vector(15 downto 0)
        );
	end component;

begin
	R1: sin_entity port map(address,F1);
    
	value <= 	F1;
end rom_arch;