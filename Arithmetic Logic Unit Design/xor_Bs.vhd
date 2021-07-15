LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.STD_LOGIC_UNSIGNED.all;

entity xor_Bs is
	port(
		s1 : in std_logic;
		B  : in std_logic_vector(3 downto 0);
		Bt : out std_logic_vector(3 downto 0) );
		
end xor_Bs;

architecture logic of xor_bs is
begin

-- Compliments B when s1 is '1'
	Bt(0) <= s1 xor B(0);
	Bt(1) <= s1 xor B(1);
	Bt(2) <= s1 xor B(2);
	Bt(3) <= s1 xor B(3);
	
end logic;
		