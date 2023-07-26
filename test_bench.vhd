library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use std.textio.all;
use work.Gates.all;

entity test_bench is
end entity;

architecture tb of test_bench is
  component mac_ckt is
     port (A, B: in std_logic_vector(7 downto 0);
           ac : in std_logic_vector(15 downto 0);
           res: out std_logic_vector(15 downto 0);
           cout:out std_logic);
end component ;

signal tb_a, tb_b : std_logic_vector(7 downto 0);
signal tb_x : std_logic_vector(15 downto 0);
signal tb_cout : std_logic;
signal tb_s : std_logic_vector(15 downto 0);
begin
f1 : mac_ckt port map(tb_b,tb_a,tb_x,tb_s, tb_cout);
process
file text_file : text open read_mode is
"C:\Users\chand\OneDrive\Desktop\quart\mac_vlsi\test_data.txt" ;
variable text_line : line;
variable x, y : std_logic_vector(7 downto 0);
variable k,z : std_logic_vector(15 downto 0);
variable b : std_logic;
variable ok : boolean;
begin
while not endfile(text_file) loop
readline(text_file, text_line);
if text_line.all'length = 0 or text_line.all(1) = '#' then
next;
end if;
read(text_line, x, ok);
tb_a <= x;
read(text_line, y, ok);
tb_b <= y;
read(text_line, k, ok);
tb_x <= k;
read(text_line, z, ok);
read(text_line, b, ok);
wait for 2000ns;
assert(tb_s = z) report "Mismatch" severity failure;
assert(tb_cout = b) report "Mismatch" severity failure;
end loop;
report "Success" severity note;
wait;
end process;
end architecture;