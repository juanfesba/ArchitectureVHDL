LIBRARY IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity PC is
port
(
	Clock: in std_logic;
	ResetPC: in std_logic;
	SignalPC: in std_logic;
	PCin: in std_logic_vector(24 downto 0);
	PCout: out std_logic_vector(24 downto 0)
);
end entity;

architecture PC of PC is
	signal PCsig: std_logic_vector(24 downto 0);
begin
	process(Clock, ResetPC, SignalPC) begin
		if (ResetPC = '0') then
			if(rising_edge(Clock)) then
				PCout <= PCsig;
			elsif (falling_edge(Clock) and SignalPC = '1') then
				PCsig <= PCin;
			end if;
		else
			PCOut <= "0000000000000000000000000";
		end if;
	end process;
	
end architecture;
