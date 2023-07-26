library ieee;
use ieee.std_logic_1164.all;

entity gen_propagate is 
	port(gi, pi, gi_1, pi_1 : in std_logic;
		  gi1, pi1 : out std_logic);
end entity;

architecture struct of gen_propagate is 

	component a_or_bc is 
		port(a, b, c : in std_logic;
		  y : out std_logic);
	end component;
	
	component and_gate is 
		port(a, b : in std_logic;
			  y : out std_logic);
	end component;
	
	begin
		gate1 : a_or_bc port map(gi, pi, gi_1, gi1); 
		gate2 : and_gate port map(pi, pi_1, pi1);
		
end architecture;