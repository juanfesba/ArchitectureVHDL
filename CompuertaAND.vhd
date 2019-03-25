LIBRARY IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity CompuertaAND is
port
(
	Input1: in std_logic;
	Input2: in std_logic;
	ANDOut: out std_logic
);
end entity; 

architecture CompuertaAND of CompuertaAND is
begin
	ANDOut <= Input1 AND Input2;
end architecture;