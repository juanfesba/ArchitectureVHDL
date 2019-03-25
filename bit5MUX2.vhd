LIBRARY IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity bit5MUX2 is
port
(
	MuxSignal: in std_logic;
	Entrada1: in std_logic_vector(4 downto 0);
	Entrada2: in std_logic_vector(4 downto 0);
	S: out std_logic_vector(4 downto 0)
);
end entity;

architecture bit5MUX2 of bit5MUX2 is
begin
	with MuxSignal select
		S <= Entrada1 when '0',
		Entrada2 when others;
end architecture;