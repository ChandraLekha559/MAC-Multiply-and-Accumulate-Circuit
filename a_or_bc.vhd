library ieee;
use ieee.std_logic_1164.all;

entity a_or_bc is 
	port(a, b, c : in std_logic;
		  y : out std_logic);
end entity;

architecture dataflow of a_or_bc is 
	begin
		y <= a or (b and c) after 66ps;
end architecture;
