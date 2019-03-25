LIBRARY IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity MUXENTRADAS is
port
(
	MuxSignal: in std_logic_vector(3 downto 0);
	Sensor0: in std_logic_vector(24 downto 0);
	Sensor1: in std_logic_vector(24 downto 0);
	PushButton0: in std_logic_vector(24 downto 0);
	PushButton1: in std_logic_vector(24 downto 0);
	PushButton2: in std_logic_vector(24 downto 0);
	Weight: in std_logic_vector(24 downto 0);
	Control: in std_logic_vector(24 downto 0);
	RunWalk: in std_logic_vector(24 downto 0);
	S: out std_logic_vector(24 downto 0)
);
end entity;

architecture MUXENTRADAS of MUXENTRADAS is
begin
	with MuxSignal select
		S <= Sensor0 when "0000",
				Sensor1 when "0001",
				PushButton0 when "0010",
			   PushButton1 when "0011",
				PushButton2 when "0100",
				Weight when "0101",
				Control when "0110",
				RunWalk when "0111",
		"0000000000000000000000000" when others;
end architecture;