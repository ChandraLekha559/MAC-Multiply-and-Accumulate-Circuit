library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all ;
use work.Gates.all;

entity mac_ckt is
	port (A, B: in std_logic_vector(7 downto 0);
			ac : in std_logic_vector(15 downto 0);
			res: out std_logic_vector(15 downto 0);
			cout:out std_logic);
end mac_ckt;

architecture mac_arch of mac_ckt is
   
	component brent_kung is 
	port(a, b : in  std_logic_vector(15 downto 0);
		  cin  : in  std_logic;
		  cout : out std_logic;
		  sum  : out std_logic_vector(15 downto 0));
end component;
 
 component and_gate is 
	port(a, b : in std_logic;
		  y : out std_logic);
end component;
	
	signal y0 : std_logic_vector(7 downto 0);
	signal y1 : std_logic_vector(8 downto 1);
	signal y2 : std_logic_vector(9 downto 2);
	signal y3 : std_logic_vector(10 downto 3);
	signal y4 : std_logic_vector(11 downto 4);
	signal y5 : std_logic_vector(12 downto 5);
	signal y6 : std_logic_vector(13 downto 6);
	signal y7 : std_logic_vector(14 downto 7);
	signal sh,ch : std_logic_vector(8 downto 1);
	signal sf,cf : std_logic_vector(49 downto 2);
	signal cin: std_logic := '0';
	signal x,y : std_logic_vector(15 downto 0);
	
	begin 
	
	cap9_1: for i in 0 to 7 generate
	and1 : and_gate port map(A(i),B(0),y0(i));
	end generate;
	cap9_2 : for i in 0 to 7 generate 
	and2 : and_gate port map(A(i),B(1),y1(i+1));
	end generate;
	cap9_3: for i in 0 to 7 generate 
	and3 : and_gate port map(A(i),B(2),y2(i+2));
	end generate;
	cap9_4: for i in 0 to 7 generate 
	and4 : and_gate port map(A(i),B(3),y3(i+3));
	end generate;
	cap9_5: for i in 0 to 7 generate 
	and5 : and_gate port map(A(i),B(4),y4(i+4));
	end generate;
	cap9_6: for i in 0 to 7 generate 
	and6 : and_gate port map(A(i),B(5),y5(i+5));
	end generate;
	cap9_7: for i in 0 to 7 generate 
	and7 : and_gate port map(A(i),B(6),y6(i+6));
	end generate;
	cap9_8: for i in 0 to 7 generate 
	and8 : and_gate port map(A(i),B(7),y7(i+7));
	end generate;

   HA1 : HALF_ADDER port map(ac(5),y0(5),sh(1),ch(1));
	HA2 : HALF_ADDER port map(y2(6),y3(6),sh(2),ch(2));
	HA3 : HALF_ADDER port map(y6(7),y5(7),sh(3),ch(3));
	HA4 : HALF_ADDER port map(y6(8),y7(8),sh(4),ch(4));
	FA1 : FULL_ADDER port map(ac(6),y0(6),y1(6),sf(2),cf(2));
	FA2 : FULL_ADDER port map(ac(7),y0(7),y1(7),sf(3),cf(3));
	FA3 : FULL_ADDER port map(y4(7),y3(7),y2(7),sf(4),cf(4));
	FA4 : FULL_ADDER port map(ac(8),y1(8),y2(8),sf(5),cf(5));
	FA5 : FULL_ADDER port map(y3(8),y4(8),y5(8),sf(6),cf(6));
	FA6 : FULL_ADDER port map(ac(9),y2(9),y3(9),sf(7),cf(7));
	FA7 : FULL_ADDER port map(y4(9),y5(9),y6(9),sf(8),cf(8));
	FA8 : FULL_ADDER port map(ac(10),y3(10),y4(10),sf(9),cf(9));
------------------------------------------------------------------------

   HA5 : HALF_ADDER port map(ac(3),y0(3),sh(5),ch(5));
	HA6 : HALF_ADDER port map(y2(4),y3(4),sh(6),ch(6));
	FA9  : FULL_ADDER port map(ac(4),y0(4),y1(4),sf(10),cf(10));
	FA10 : FULL_ADDER port map(sh(1),y1(5),y2(5),sf(11),cf(11));
	FA11 : FULL_ADDER port map(y3(5),y4(5),y5(5),sf(12),cf(12));
	FA12 : FULL_ADDER port map(sf(2),ch(1),sh(2),sf(13),cf(13));
	FA13 : FULL_ADDER port map(y4(6),y5(6),y6(6),sf(14),cf(14));
	FA14 : FULL_ADDER port map(sf(3),cf(2),sf(4),sf(15),cf(15));
	FA15 : FULL_ADDER port map(ch(2),sh(3),y7(7),sf(16),cf(16));
   FA16 : FULL_ADDER port map(sf(5),cf(3),sf(6),sf(17),cf(17));
	FA17 : FULL_ADDER port map(cf(4),sh(4),ch(3),sf(18),cf(18));
	FA18 : FULL_ADDER port map(sf(7),cf(5),sf(8),sf(19),cf(19));
	FA19 : FULL_ADDER port map(cf(6),ch(4),y7(9),sf(20),cf(20));
	FA20 : FULL_ADDER port map(sf(9),cf(7),y5(10),sf(21),cf(21));
	FA21 : FULL_ADDER port map(y6(10),y7(10),cf(8),sf(22),cf(22));
	FA22 : FULL_ADDER port map(ac(11),cf(9),y4(11),sf(23),cf(23));
	FA23 : FULL_ADDER port map(y5(11),y6(11),y7(11),sf(24),cf(24));
	FA24 : FULL_ADDER port map(ac(12),y5(12),y6(12),sf(25),cf(25));	
-------------------------------------------------------------------------
   HA7 : HALF_ADDER port map(ac(2),y0(2),sh(7),ch(7));
	FA25 :FULL_ADDER port map(sh(5),y1(3),y2(3),sf(26),cf(26));
	FA26 : FULL_ADDER port map(sf(10),ch(5),sh(6),sf(27),cf(27));
	FA27 : FULL_ADDER port map(sf(11),cf(10),sf(12),sf(28),cf(28));
	FA28 : FULL_ADDER port map(sf(13),cf(11),sf(14),sf(29),cf(29));
	FA29 : FULL_ADDER port map(sf(15),cf(13),sf(16),sf(30),cf(30));
	FA30 : FULL_ADDER port map(sf(17),cf(15),sf(18),sf(31),cf(31));
	FA31 : FULL_ADDER port map(sf(19),cf(17),sf(20),sf(32),cf(32));
   FA32 : FULL_ADDER port map(sf(21),cf(19),sf(22),sf(33),cf(33));
   FA33 : FULL_ADDER port map(sf(23),cf(21),sf(24),sf(34),cf(34));
   FA34 : FULL_ADDER port map(sf(25),cf(23),y7(12),sf(35),cf(35));
   FA35 : FULL_ADDER port map(ac(13),cf(25),y6(13),sf(36),cf(36));
---------------------------------------------------------------------------
   HA8 : HALF_ADDER port map(ac(1),y0(1),x(1),y(2));
	FA36 : FULL_ADDER port map(sh(7),y1(2),y2(2),x(2),y(3));
	FA37 : FULL_ADDER port map(sf(26),ch(7),y3(3),x(3),y(4));
	FA38 : FULL_ADDER port map(sf(27),cf(26),y4(4),x(4),y(5));
	FA39 : FULL_ADDER port map(sf(28),cf(27),ch(6),x(5),y(6));
	FA40 : FULL_ADDER port map(sf(29),cf(28),cf(12),x(6),y(7));
	FA41 : FULL_ADDER port map(sf(30),cf(29),cf(14),x(7),y(8));
	FA42 : FULL_ADDER port map(sf(31),cf(30),cf(16),x(8),y(9));
   FA43 : FULL_ADDER port map(sf(32),cf(31),cf(18),x(9),y(10));
   FA44 : FULL_ADDER port map(sf(33),cf(32),cf(20),x(10),y(11));
   FA45 : FULL_ADDER port map(sf(34),cf(33),cf(22),x(11),y(12));
   FA46 : FULL_ADDER port map(sf(35),cf(34),cf(24),x(12),y(13));
   FA47 : FULL_ADDER port map(sf(36),cf(35),y7(13),x(13),y(14));
   FA48 : FULL_ADDER port map(ac(14),cf(36),y7(14),x(14),y(15));
---------------------------------------------------------------------------
   x(0) <= ac(0);
	x(15) <= ac(15);
	y(0) <= y0(0);
	y(1) <= y1(1);
   
	brent : brent_kung port map(x,y,cin,cout,res) ;
	
   
end mac_arch;
