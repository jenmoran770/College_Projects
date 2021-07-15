LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.STD_LOGIC_UNSIGNED.all;

entity Project1 is 
	port(
		s : in std_logic_vector(1 DOWNTO 0);
		cin, clk : in std_logic;
		A : in std_logic_vector(3 DOWNTO 0);
		B : in std_logic_vector(3 DOWNTO 0);
		cout : out std_logic;
		C : out std_logic_vector(3 DOWNTO 0) );
		
end Project1;


Architecture logic of Project1 is 

	component FA
		port( 
			X, Y, Ci : in std_logic;
			sum, Cout : out std_logic );
			
	end component;
	
	
	component xor_AB
		port(
			a : in std_logic_vector(3 downto 0);
			b : in std_logic_vector(3 downto 0);
			xab : out std_logic_vector(4 downto 0)
			 );	
	end component;
	
	
	-- complement and control of B with s1
	component xor_Bs is
		port(
			s1 : in std_logic;
			B : in std_logic_vector(3 downto 0);
			Bt : out std_logic_vector(3 downto 0) );
	end component;
	
	
	-- controls B or zero vector
	component mux1
		port(
			b : in std_logic_vector(3 downto 0);
			t : in std_logic;
			m1 : out std_logic_vector(3 downto 0)
			 );
	end component; 
	
	
	-- controls Addsub sum or XOR output
	component mux2
		port(
			sum : in std_logic_vector(4 downto 0);
			xab : in std_logic_vector(4 downto 0);
			t : in std_logic;
			C : out std_logic_vector(4 downto 0) );
	end component;
	
	
	-- creates the controlers for mux1 and mux2
	component muxcontrol
		port(
			s1 : in std_logic;
			s0 : in std_logic;
			T3, T2 : out std_logic );
	end component;
	
	
	component DFF_in
		port(
			D : in std_logic;
			clk : in std_logic;
			Q : out std_logic );	
	end component;
	
	
	component DFF_out
		port(
			D : in std_logic;
			clk : in std_logic;
			Q : out std_logic );
	end component;
	
	
	component addsub2
		port(
			cin 	: in std_logic; 
			A, B 	: in std_logic_vector(3 downto 0);
			Sum1  : out std_logic_vector(4 downto 0) );
	end component;



signal m1 : std_logic_vector(3 downto 0); --mux1 output
-- 2to1 mux

signal A_d : std_logic_vector(3 downto 0);
signal B_d : std_logic_vector(3 downto 0);
signal s_d : std_logic_vector(1 downto 0);
signal carryin : std_logic;

-- holds B or B' aka B control
signal Bc : std_logic_vector(3 downto 0);

signal sum : std_logic_vector(4 downto 0);
signal Xor_out : std_logic_vector(4 downto 0);

signal C_d : std_logic_vector(4 downto 0);
signal cout_d : std_logic;

signal T3 : std_logic;
signal T2 : std_logic;


begin

-- send all the inputs through the DFF
inA3 : DFF_in port map( A(3), clk, A_d(3) );
inA2 : DFF_in port map( A(2), clk, A_d(2) );
inA1 : DFF_in port map( A(1), clk, A_d(1) );
inA0 : DFF_in port map( A(0), clk, A_d(0) );

inB3 : DFF_in port map( B(3), clk, B_d(3) );
inB2 : DFF_in port map( B(2), clk, B_d(2) );
inB1 : DFF_in port map( B(1), clk, B_d(1) );
inB0 : DFF_in port map( B(0), clk, B_d(0) );

inS1 : DFF_in port map( s(1), clk, s_d(1) );
inS0 : DFF_in port map( s(0), clk, s_d(0) );

inCin : DFF_in port map( (not(cin)), clk, carryin );



Mux2input : muxcontrol port map( s_d(1), s_d(0), T3, T2); -- gates that control all mux selections

-- s1 xor B will contorl whether it's B or B'
Bcontrol : xor_Bs port map( s_d(1), B_d(3 downto 0), Bc(3 downto 0) );

--first mux will control B input or 0 vector input
firstMux : mux1 port map( Bc(3 downto 0), T2, m1(3 downto 0) );

AddSub : addsub2 port map( carryin, A_d(3 downto 0), m1(3 downto 0), sum(4 downto 0) );

AxorB : xor_AB port map( A_d(3 downto 0), B_d(3 downto 0), Xor_out );

secondMux : mux2 port map( sum(4 downto 0), Xor_out, T3, C_d);

	cout_d <= C_d(4);


-- send all the outputs through second DFF
outCout : DFF_out port map( cout_d, clk, cout);
outC0 	: DFF_out port map( C_d(0), clk, C(0));
outC3 	: DFF_out port map( C_d(3), clk, C(3));
outC2 	: DFF_out port map( C_d(2), clk, C(2));
outC1 	: DFF_out port map( C_d(1), clk, C(1));

end logic;
