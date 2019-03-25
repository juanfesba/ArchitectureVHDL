LIBRARY IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity ImmExtend is
port
(
	Imm: in std_logic_vector(9 downto 0);
	S: out std_logic_vector(24 downto 0)
);
end entity;

architecture ImmExtend of ImmExtend is
begin
	S <= "000000000000000"&Imm;
end architecture;