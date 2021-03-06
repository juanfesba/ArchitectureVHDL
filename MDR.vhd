library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MDR is
port
(
	Clock: in std_logic;
	MDRWrite: in std_logic;
	EnableMDR: in std_logic;
	DataIN: in std_logic_vector(24 downto 0);
	DataOUT: out std_logic_vector(24 downto 0)
);
end entity;

architecture MDR of MDR is
	signal Data: std_logic_vector(24 downto 0);
begin
	process(Clock, MDRWrite, EnableMDR)
		begin
			if(falling_edge(Clock) and MDRWrite = '1') then
				Data <= DataIN;
			elsif(rising_edge(Clock) and EnableMDR = '1') then
				DataOUT <= Data;
			end if;
	end process;
end architecture;