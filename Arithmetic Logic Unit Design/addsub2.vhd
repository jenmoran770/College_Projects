library ieee;
use ieee.std_logic_1164.all;

entity addsub2 is
   port( 
          cin 	: in std_logic;
          A, B 	: in std_logic_vector(3 downto 0);
          Sum1  : out std_logic_vector(4 downto 0) );
end addsub2;


architecture struct of addsub2 is

component FA is
  port( 
        X, Y, Ci : in std_logic;
        sum, Cout : out std_logic );
end component;

signal C1 	: std_logic_vector(4 downto 1);

begin

-- need ci to make B into 2's compliment, without it, it's 1's compliment which will be -1 of the answer

				-- A	 B	   Cin    Sum      Cout
FA0 : FA port map( A(0), B(0), Cin,   Sum1(0), C1(1) ); 
FA1 : FA port map( A(1), B(1), C1(1), Sum1(1), C1(2) );
FA2 : FA port map( A(2), B(2), C1(2), Sum1(2), C1(3) );
FA3 : FA port map( A(3), B(3), C1(3), Sum1(3), C1(4) );


Sum1(4) <= C1(4);

end struct;
