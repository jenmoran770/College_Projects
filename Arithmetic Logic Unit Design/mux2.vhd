LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.STD_LOGIC_UNSIGNED.all;

entity mux2 is
	port(
		sum : in std_logic_vector(4 downto 0);
		xab : in std_logic_vector(4 downto 0);
		t : in std_logic;
		C : out std_logic_vector(4 downto 0) );
end mux2;

architecture behavior of mux2 is
begin
	with t select
		c <= xab when '0',
			 sum when others;
end behavior;
