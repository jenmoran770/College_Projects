Library ieee;
use ieee.std_logic_1164.all;

entity project2 is

port( w, clk, reset : in std_logic;
	z : out std_logic;
	Y3P, Y2P, Y1P, Y0P : buffer std_logic
	);
	
end project2;

architecture logicfunc of project2 is

signal y3, y2, y1, y0 : std_logic;
signal y3n, y2n, y1n, y0n : std_logic;

begin

y3 <= ( w and ( (not(y3p) and y2p) or (y2p and y1p and y0p) ) );
y2 <= ( y1p and (w xnor y0p) );
y1 <= y0p ;
y0 <= w ;

-- with don't cares
z <= ( (not(y2p) and y1p and y0p) or (y3p) );

-- assignment to nextstate/holding
y3n <= y3;
y2n <= y2;
y1n <= y1;
y0n <= y0;

-- send through the DFFs and assign nextstate to present state
process (clk, reset, y3n, y2n, y1n, y0n)
begin

if reset = '0' then
	Y3P <= '0';
	Y2P <= '0';
	Y1P <= '0';
	Y0P <= '0';
	
elsif (Clk'EVENT and clk = '1') then
	Y3P <= y3n;
	Y2P <= y2n;
	Y1P <= y1n;
	Y0P <= y0n;
	
end if;
end process;
end logicfunc;