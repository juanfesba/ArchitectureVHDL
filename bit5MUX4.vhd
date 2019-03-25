LIBRARY IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity bit5MUX4 is
port
(
	MuxSignal: in std_logic_vector(1 downto 0);
	Input1: in std_logic_vector(4 downto 0);
	Input2: in std_logic_vector(4 downto 0);
	Input3: in std_logic_vector(4 downto 0);
	Input4: in std_logic_vector(4 downto 0);
	OutMux: out std_logic_vector(4 downto 0)
);
end entity;

architecture bit5MUX4 of bit5MUX4 is

begin
	with MuxSignal select
		OutMux <= Input1 when "00",
				    Input2 when "01",
					 Input3 when "10",
					 Input4 when "11",
		"00000" when others;
end architecture;