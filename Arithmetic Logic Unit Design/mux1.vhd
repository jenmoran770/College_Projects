LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.STD_LOGIC_UNSIGNED.all;

entity mux1 is 
	port(
		b 	: in std_logic_vector(3 downto 0);
		t 	: in std_logic;
		m1 	: out std_logic_vector(3 downto 0)
		 );
		
end mux1;

architecture behavior of mux1 is 

	-- create a zero vector to use in place of B input
	signal z : std_logic_vector(3 downto 0);
	
begin

	z(3) <= '0';
	z(2) <= '0';
	z(1) <= '0';
	z(0) <= '0';
	
	with t select
		m1 <= z when '0',
			  b when others;

end behavior;
