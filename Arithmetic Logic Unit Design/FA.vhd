library ieee;
use ieee.std_logic_1164.all;

entity FA is
   port( 
         X, Y, Ci : in std_logic;
         sum, Cout : out std_logic);
end FA;
 
architecture behavior of FA is
begin

   sum 	<= ( X xor Y ) xor Ci;
   Cout <= ( X and ( Y or Ci ) ) or ( Ci and Y );
   
end behavior;
