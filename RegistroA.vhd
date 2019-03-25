library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RegistroA is
port
(
	Clock: in std_logic;
	DataIN: in std_logic_vector(24 downto 0);
	DataOUT: out std_logic_vector(24 downto 0)
);
end entity;

architecture RegistroA of RegistroA is
	signal Data: std_logic_vector(24 downto 0);
begin
	process(Clock)
		begin
			if(falling_edge(Clock)) then
				Data <= DataIN;
			elsif(rising_edge(Clock)) then
				DataOUT <= Data;
			end if;
	end process;
end architecture;