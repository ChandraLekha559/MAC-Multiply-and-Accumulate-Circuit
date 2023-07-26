library ieee;
use ieee.std_logic_1164.all;

entity brent_kung is 
	port(a, b : in  std_logic_vector(15 downto 0);
		  cin  : in  std_logic;
		  cout : out std_logic;
		  sum  : out std_logic_vector(15 downto 0));
end entity;

architecture structural of brent_kung is

	component and_gate is 
		port(a, b : in std_logic;
			  y : out std_logic);
	end component;
	
	component xor_gate is 
		port(a, b : in std_logic;
			  y 	 : out std_logic);
	end component; 
	
	component sum_carry is 
		port(gi, pi, ci : in  std_logic;
			  ci1, si1   : out std_logic);
	end component;

	component gen_propagate is 
		port(gi, pi, gi_1, pi_1 : in  std_logic;
			  gi1, pi1           : out std_logic);
	end component;
	
	component generate0 is 
		port(a, b, c : in std_logic;
		y 		 : out std_logic);
	end component;
	
	component a_or_bc is 
		port(a, b, c : in  std_logic;
			  y       : out std_logic);
	end component;
	
	signal g1, p1 : std_logic_vector(15 downto 0);
	signal g2, p2 : std_logic_vector(7 downto 0);
	signal g3, p3 : std_logic_vector(3 downto 0);
	signal g4, p4 : std_logic_vector(1 downto 0);
	signal g5, p5 : std_logic;
	signal c      : std_logic_vector(16 downto 0);

	begin
	c(0) <= cin;
		 s0: generate0 port map(a(0),b(0),c(0),g1(0));
		s00: xor_gate port map (a(0),b(0),p1(0));
		stage1 : for i in 1 to 15 generate
			s1 : and_gate port map(a(i), b(i), g1(i));
			s2 : xor_gate port map(a(i), b(i), p1(i));
		end generate;

		stage2 : for i in 0 to 7 generate
			s3 : gen_propagate port map(g1(2*i+1), p1(2*i+1), g1(2*i), p1(2*i), g2(i), p2(i));
		end generate;

		stage3 : for i in 0 to 3 generate
			s4 : gen_propagate	port map(g2(2*i+1), p2(2*i+1), g2(2*i), p2(2*i), g3(i), p3(i));
		end generate;

		stage4 : for i in 0 to 1 generate
			s5 : gen_propagate port map(g3(2*i+1), p3(2*i+1), g3(2*i), p3(2*i), g4(i), p4(i));
		end generate;

		  s6 : gen_propagate port map(g4(1), p4(1), g4(0), p4(0), g5, p5);


		carry1  : a_or_bc port map (g1(0), p1(0), c(0), c(1)) ;
		carry2  : a_or_bc port map (g2(0), p2(0), c(0), c(2)) ;
		carry4  : a_or_bc port map (g3(0), p3(0), c(0), c(4)) ;
		carry8  : a_or_bc port map (g4(0), p4(0), c(0), c(8)) ;
		carry16 : a_or_bc port map (g5, p5, c(0), c(16)) ;
		

		carry3  : a_or_bc port map (g1(2), p1(2), c(2), c(3)) ;
		carry5  : a_or_bc port map (g1(4), p1(4), c(4), c(5)) ;
		carry7  : a_or_bc port map (g1(6), p1(6), c(6), c(7)) ;
		carry9  : a_or_bc port map (g1(8), p1(8), c(8), c(9)) ;
		carry11 : a_or_bc port map (g1(10), p1(10), c(9), c(11)) ;
		carry13 : a_or_bc port map (g1(12), p1(12), c(12), c(13)) ;
		carry15 : a_or_bc port map (g1(14), p1(14), c(14), c(15)) ;
		
		carry6  : a_or_bc port map (g2(2), p2(2), c(4), c(6)) ;
		carry10 : a_or_bc port map (g2(4), p2(4), c(8), c(10)) ;
		carry14 : a_or_bc port map (g2(6), p2(6), c(12), c(14)) ;
		

		carry12 : a_or_bc port map (g3(2), p3(2), c(8), c(12)) ;
		
		cout <= c(16);

		
		sum_generate : for i in 0 to 15 generate
			sum0generate: if(i=0) generate
				sum0 : xor_gate port map (p1(i), c(i), sum(i));
			end generate ;
		
			sum1generate: if(i>0) generate
				sum1 : xor_gate port map (p1(i), c(i), sum(i));
			end generate;
		end generate;

end architecture;