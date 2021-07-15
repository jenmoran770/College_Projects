LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.STD_LOGIC_UNSIGNED.all;


entity DFF_out is
	port(
		D : in std_logic;
		clk : in std_logic;
		Q : out std_logic );
		
end DFF_out;

architecture behavior of DFF_out is
begin

	process(clk)
	begin
		if clk'EVENT and clk = '1' then
			Q <= D;
		end if;
	end process;

end behavior;