LIBRARY IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ALUFunction is
port
(
	AluOP: in std_logic_vector(2 downto 0);
	Funct: in std_logic_vector(5 downto 0);
	OUTAluFunction: out std_logic_vector(3 downto 0)
);
end entity;

architecture ALUFunction of ALUFunction is
begin
	process(AluOP, Funct)
		begin
			if(AluOP = "000") then
				if(Funct = "01110") then
					OUTAluFunction <= "0000"; --SUMA
				elsif(Funct = "10000") then
					OUTAluFunction <= "0001"; --RESTA
				elsif(Funct = "10001") then
					OUTAluFunction <= "0010"; --DIVISION
				elsif(Funct = "10010") then
					OUTAluFunction <= "0011"; --MULTIPLICACION
				elsif(Funct = "10011") then
					OUTAluFunction <= "1000"; --AND
				elsif(Funct = "10100") then
					OUTAluFunction <= "1001"; --OR
				end if;
			elsif(AluOP = "001") then
				OUTAluFunction <= "0000";
			elsif(AluOP = "010") then
				OUTAluFunction <= "0100"; --IGUAL
			elsif(AluOP = "011") then
				OUTAluFunction <= "0101"; --DIFERENTE
			elsif(AluOP = "100") then
				OUTAluFunction <= "0110"; --MENOR QUE
			elsif(AluOP = "101") then
				OUTAluFunction <= "0111"; --MAYOR QUE
			end if;
	end process;
end architecture;