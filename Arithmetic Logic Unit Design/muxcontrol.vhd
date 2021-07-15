LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.STD_LOGIC_UNSIGNED.all;


entity muxcontrol is
	port(
		s1 : in std_logic;
		s0 : in std_logic;
		T3, T2 : out std_logic );
		
end muxcontrol;

architecture behavior of muxcontrol is
begin
	
	T3 <= s1 nand s0;
	T2 <= s1 or s0;

end behavior;