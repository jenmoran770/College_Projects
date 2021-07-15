LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.STD_LOGIC_UNSIGNED.all;

entity xor_AB is
	port(
		a : in std_logic_vector(3 downto 0);
		b : in std_logic_vector(3 downto 0);
		xab : out std_logic_vector(4 downto 0)
		 );
		
end xor_AB;

architecture logic of xor_AB is

signal co : std_logic;

begin

	xab(0) <= ( a(0) xor b(0) );
	xab(1) <= ( a(1) xor b(1) );
	xab(2) <= ( a(2) xor b(2) );
	xab(3) <= ( a(3) xor b(3) );
	xab(4) <= '0';
	
	
end logic;
		