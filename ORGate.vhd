LIBRARY IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity ORGate is
port
(
	IN1: in std_logic;
	IN2: in std_logic;
	OutOR: out std_logic
);
end entity; 

architecture ORGate of ORGate is
begin
	OutOR <= IN1 OR IN2;
end architecture;