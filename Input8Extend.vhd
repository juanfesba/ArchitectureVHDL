LIBRARY IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity Input8Extend is
port
(
	Input0: in std_logic;
	Input1: in std_logic;
	Input2: in std_logic;
	Input3: in std_logic;
	Input4: in std_logic;
	Input5: in std_logic;
	Input6: in std_logic;
	Input7: in std_logic;	
	S: out std_logic_vector(24 downto 0)
);
end entity;

architecture Input8Extend of Input8Extend is
begin
	S <= "00000000000000000"&Input7&Input6&Input5&Input4&Input3&Input2&Input1&Input0;
end architecture;