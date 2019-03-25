library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity IR is
port
(
	Clock: in std_logic;
	IRWrite: in std_logic;
	EnableIR: in std_logic;
	InsIN: in std_logic_vector(24 downto 0);
	InsOUT: out std_logic_vector(24 downto 0)
);
end entity;

architecture IR of IR is
	signal Instruction: std_logic_vector(24 downto 0);
begin
	process(Clock, IRWrite, EnableIR)
		begin
			if(falling_edge(Clock) and IRWrite = '1') then
				Instruction <= InsIN;
			elsif(rising_edge(Clock) and EnableIR = '1') then
				InsOUT <= Instruction;
			end if;
	end process;
end architecture;