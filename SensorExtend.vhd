LIBRARY IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity SensorExtend is
port
(
	Sensor: in std_logic;
	S: out std_logic_vector(24 downto 0)
);
end entity;

architecture SensorExtend of SensorExtend is
begin
	S <= "000000000000000000000000"&Sensor;
end architecture;