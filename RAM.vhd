-- Quartus II VHDL Template
-- Single port RAM with single read/write address 
library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity RAM is

generic 
(
DATA_WIDTH : natural := 25;
ADDR_WIDTH : natural := 6
);

port 
(
clk : in std_logic;
--addr : in natural range 0 to 2**ADDR_WIDTH - 1;
addr : in std_logic_vector(24 downto 0);
data : in std_logic_vector((DATA_WIDTH-1) downto 0);
we : in std_logic;
q : out std_logic_vector((DATA_WIDTH -1) downto 0)
);

end entity;

architecture rtl of RAM is

-- Build a 2-D array type for the RAM
subtype word_t is std_logic_vector((DATA_WIDTH-1) downto 0);
type memory_t is array(2**ADDR_WIDTH-1 downto 0) of word_t;

-- Declare the RAM signal. 
signal ram : memory_t:= (

0  => "0000100000000100000000110", --input r2 control
1  => "1010100010000010000000100", --beq r2 r1 4
2  => "0000100000000100000000110", -- input r2 control
3  => "1011000000000010000000000", --j 1
4  => "0000100000000110000000101", -- input r3 legSize
5  => "1010100010000000000001000", --beq r2 r0 8
---3  => "0111011111111110001000000",
6  => "0000100000000100000000110", --input r2 control	
7  => "1011000000001010000000000", -- j 5
8  => "0000100000001000000000101", -- input r4 weight
9  => "1010100010000010000001100", -- beq r2 r1 12
--8  => "0111011111111110001000000",
--9  => "0111011000010001000000000",
10 => "0000100000000100000000110", -- input r2 control
11 => "1011000000010010000000000", -- j 9
12 => "0000100000001010000000010", -- input r5 PB0
13 => "0000100000000100000000110", -- input r2 control
14 => "1010100010000000000100010", -- beq r2 r0 34
15 => "0000100000001100000000111", -- input r6 RW
16 => "1010100110000010000010010", -- beq r6 r1 18
17 => "1011000000011010000000000", -- j 13
18 => "0000100000001110000000000", -- input r7 sensor0
19 => "0000100000010000000000011", -- input r8 PB1
20 => "0111001001001110100100000", -- add r9 r7 r9
21 => "0111001010010000101000000", -- add r10 r8 r10
22 => "0111001011000010101100000", -- add r11 r1 r11
23 => "0000100000000100000000110", -- input r2 control
24 => "1010100010000000000100010", -- beq r2 r0 34
25 => "0000100000001100000000111", -- input r6 RW
26 => "1010100110000000000011100", -- beq r6 r0 28
27 => "1011000000101110000000000", -- j 23
28 => "0000100000001110000000000", -- input r7 sensor0
29 => "0000100000010000000000011", -- input r8 PB1
30 => "0111001001001110100100000", -- add r9 r7 r9
31 => "0111001010010000101000000", -- add r10 r8 r10
32 => "0111001011000010101100000", -- add r11 r1 r11
33 => "1011000000011010000000000", -- j 13
34 => "0111000000010110110000000", -- add r0 r11 r12
35 => "0001001100011010000000000", -- output r12 r13
36 => "0000100000000100000000110", -- input r2 control
37 => "1010100010000000000100100", -- beq r2 r0 36
38 => "0111100000011100001011010", -- addi r0 r14 90
39 => "1001001110010110111000000", -- mul r14 r11 r14
40 => "1001001110000110111000000", -- mul r14 r3 r14
41 => "0111100000100000001100100", -- addi r0 r16 100
42 => "1000101110100000111000000", -- div r14 r16 r14
43 => "1000101110100000110100000", -- div r14 r16 r13
44 => "1110001110100000110000000", -- mod r14 r16 r12
45 => "0001001100011010000000000", -- output r12 r13
46 => "0000100000000100000000110", -- input r2 control
47 => "1010100010000010000101110", -- beq r2 r1 46
48 => "0111100000011110000001010", -- addi r0 r15 10
49 => "1000100100011110111000000", -- div r4 r15 r14
50 => "1001001110010110110000000", -- mul r14 r11 r12
51 => "0111000000000000110100000", -- add r0 r0 r13
52 => "0001001100011010000000000", -- output r12 r13
53 => "0000100000000100000000110", -- input r2 control
54 => "1010100010000000000110101", -- beq r2 r0 53 
55 => "0111000000000000110000000", -- add r0 r0 r12
56 => "1010101001010100000111010", -- beq r9 r10 58
57 => "0111001100000010110000000", -- add r12 r1 r12
58 => "0001001100011010000000000", -- output r12 r13
59 => "1011000001110110000000000", -- j 59
60 => "0000000000000000000000000",
61 => "0000000000000000000000000",
62 => "0000000000000000000000000",
63 => "0000000000000000000000000"
);

-- Register to hold the address 
signal addr_reg : natural range 0 to 2**ADDR_WIDTH-1;

begin

process(clk)
begin
	if(rising_edge(clk)) then
		if(we = '1') then
			ram(to_integer(unsigned(addr))) <= data;
		end if;

-- Register the address for reading
		addr_reg <= to_integer(unsigned(addr));
	end if;
end process;

q <= ram(addr_reg);

end rtl;