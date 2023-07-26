library ieee;
use ieee.std_logic_1164.all;

entity generate0 is
port(a, b, c : in std_logic;
		y 		 : out std_logic);
end entity;

architecture dataflow of generate0 is 
	begin
		y <= (a and b) or (c and (a or b)) after 76ps;
end architecture;
