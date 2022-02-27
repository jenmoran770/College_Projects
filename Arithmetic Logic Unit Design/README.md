# Arithmetic Logic Unit Design

## Summary
* ALU circuit designed in VHDL using Quartus II using a given set of operations the circuit must perform using a 3-bit input to choose an operation to perfrom on two 4-bit inputs
* The circuit structure was developed by deriving Boolean equations from the truth tables for each
operation, simplifying the structure and then implementing on an FPGA board with switches and
LEDS

## Code Segments

### Full Adder
```VHDL
library ieee;
use ieee.std_logic_1164.all;

entity FA is
 port(
 X, Y, Ci : in std_logic;
 sum, Cout : out std_logic);
end FA;

architecture behavior of FA is
begin

 sum <= ( X xor Y ) xor Ci;
 Cout <= ( X and ( Y or Ci ) ) or ( Ci and Y );

end behavior;
```

### Xor Gate for A and B Inputs
```VHDL
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
```

### Xor Gate for B inputs and Select 1 bit
```VHDL
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.STD_LOGIC_UNSIGNED.all;

entity xor_Bs is
port(
s1 : in std_logic;
B : in std_logic_vector(3 downto 0);
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
```

### Multiplexer for B inputs
```VHDL
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.STD_LOGIC_UNSIGNED.all;

entity mux1 is
port(
b : in std_logic_vector(3 downto 0);
t : in std_logic;
m1 : out std_logic_vector(3 downto 0)
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
```

### Multiplexer for output of Full Adder and the AB Xor Gate
```VHDL
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
```

### Controler for the Multiplexers
```VHDL
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
```

### D-Flip Flop Gate for Inputs
```VHDL
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
```

### D-Flip Flop Gate for Outputs
```VHDL
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
```

### Subtractor
```VHDL
library ieee;
use ieee.std_logic_1164.all;

entity addsub2 is
 port(
 cin : in std_logic;
 A, B : in std_logic_vector(3 downto 0);
 Sum1 : out std_logic_vector(4 downto 0) );
end addsub2;

architecture struct of addsub2 is
component FA is
 port(
 X, Y, Ci : in std_logic;
 sum, Cout : out std_logic );
end component;
signal C1 : std_logic_vector(4 downto 1);
begin

-- need ci to make B into 2's compliment, without it, it's 1's compliment which will be -1 of the answer
-- A B Cin Sum Cout

FA0 : FA port map( A(0), B(0), Cin, Sum1(0), C1(1) );
FA1 : FA port map( A(1), B(1), C1(1), Sum1(1), C1(2) );
FA2 : FA port map( A(2), B(2), C1(2), Sum1(2), C1(3) );
FA3 : FA port map( A(3), B(3), C1(3), Sum1(3), C1(4) );
Sum1(4) <= C1(4);

end struct;
```
