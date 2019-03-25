LIBRARY IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity MUX2 is
port
(
	MuxSignal: in std_logic;
	Entrada1: in std_logic_vector(24 downto 0);
	Entrada2: in std_logic_vector(24 downto 0);
	S: out std_logic_vector(24 downto 0)
);
end entity;

architecture MUX2 of MUX2 is
--variable In1 : natural range 0 to 24;
--variable In2 : natural range 0 to 24;
begin
	--In1 <= to_integer(unsigned(Entrada1));
	--In2 <= to_integer(unsigned(Entrada2));
	with MuxSignal select
		S <= Entrada1 when '0',
		Entrada2 when others;
end architecture;