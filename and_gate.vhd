library ieee;
use ieee.std_logic_1164.all;

entity and_gate is 
	port(a, b : in std_logic;
		  y : out std_logic);
end entity;

architecture and_arch of and_gate is 
	begin
		y <= a and b after 48ps;
end architecture;
