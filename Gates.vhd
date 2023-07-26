library ieee;
use ieee.std_logic_1164.all;

package Gates is

  component HALF_ADDER is
   port (A, B: in std_logic; S, C: out std_logic);
  end component HALF_ADDER;
  
  
  component FUll_ADDER is
   port (A, B, Cin: in std_logic; S, Cout: out std_logic);
  end component FUll_ADDER;
  
end package Gates;
  
  
  library ieee;
use ieee.std_logic_1164.all;
entity HALF_ADDER is
   port (A, B: in std_logic; S, C: out std_logic);
end entity HALF_ADDER;

architecture Equations of HALF_ADDER is

component and_gate is 
		port(a, b : in std_logic;
			  y : out std_logic);
	end component;
	
	component xor_gate is 
		port(a, b : in std_logic;
			  y 	 : out std_logic);
	end component;

begin
   sum : xor_gate port map(A,B,S);
   carry : and_gate port map(A,B,C);
end Equations;

library ieee;
use ieee.std_logic_1164.all;
entity FULL_ADDER is
   port (A, B,Cin: in std_logic; S, Cout: out std_logic);
end entity FULL_ADDER;

architecture Equations of FULL_ADDER is
component and_gate is 
		port(a, b : in std_logic;
			  y : out std_logic);
	end component;
	
	component xor_gate is 
		port(a, b : in std_logic;
			  y 	 : out std_logic);
	end component;
	
component generate0 is 
		port(a, b, c : in std_logic;
		       y 		 : out std_logic);
end component;

signal x : std_logic ;
begin
fa1 : xor_gate port map(A,B,x);
fa2 : xor_gate port map(x,Cin,S);
car1 : generate0 port map(A,B,Cin,Cout);
end Equations;
  