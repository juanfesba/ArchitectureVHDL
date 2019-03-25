library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RegisterFile is
port
(
	Clock: in std_logic;
	rs: in std_logic_vector(4 downto 0);
	rt: in std_logic_vector(4 downto 0);
	rd: in std_logic_vector(4 downto 0);
	DataIn: in std_logic_vector(24 downto 0);
	WriteEn: in std_logic;
	DataOut1: out std_logic_vector(24 downto 0);
	DataOut2: out std_logic_vector(24 downto 0);
	DataOut3 : out std_logic_vector(24 downto 0);
	DataOut4: out std_logic_vector(24 downto 0)
);
end entity;

architecture RegisterFile of  RegisterFile is



type REG_FILE is array (0 to 31) of std_logic_vector(24 downto 0);

signal Reg : REG_FILE :=
(
0 => "0000000000000000000000000",
1 => "0000000000000000000000001",
others => "0000000000000000000000000"
);
begin
	DataOut1 <= Reg(to_integer(unsigned(rs)));
	DataOut2 <= Reg(to_integer(unsigned(rt)));
	
process(Clock, WriteEn)
begin
	if falling_edge(Clock) then
		if WriteEn = '1' then
			Reg(to_integer(unsigned(rd))) <= DataIn;
		end if;
	end if;
end process;
end architecture;