LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.STD_LOGIC_UNSIGNED.all;


entity DFF_in is
	port(
		D : in std_logic;
		clk : in std_logic;
		Q : out std_logic );
		
end DFF_in;

architecture behavior of DFF_in is
begin

	process(clk)
	begin
		if clk'EVENT and clk = '1' then
			Q <= D;
		end if;
	end process;

end behavior;