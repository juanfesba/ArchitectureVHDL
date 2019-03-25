LIBRARY IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ALU is
port
(
	OP: in std_logic_vector(4 downto 0);
	A: in std_logic_vector(24 downto 0);
	B: in std_logic_vector(24 downto 0);
	ALUOP : in std_logic;
	
	Resultado: out std_logic_vector(24 downto 0);
	Flag: out std_logic
);
end entity;

architecture ALU of ALU is
begin
	process(OP, A, B,ALUOP)
		variable Temp1: std_logic_vector(24 downto 0);
		begin
			if(OP = "01110" or OP="01111" or OP="00000" or ALUOP= '0') then
         Resultado <= std_logic_vector(signed(A)+signed(B)); --ADD ADDi
			Flag <= '0';
      elsif(OP = "10000" and ALUOP = '1') then
			Resultado <= std_logic_vector(unsigned(A)-unsigned(B)); --SUB
			Flag <= '0';
		elsif(OP="11000" or OP="11001") then -- STL STLi
			if(A < B) then
				Flag<='1';
			else
				Flag <= '0';
			end if;
		elsif(OP = "10011") then -- AND
         Resultado <= A AND B;
      elsif(OP = "10100") then -- OR
         Resultado <= A OR B;
			Flag <= '0';
      elsif(OP = "10101" AND ALUOP='1') then -- BEQ
         if(std_logic_vector(unsigned(A)) = std_logic_vector(unsigned(B))) then
				Flag <= '1';
			else
				Flag <= '0';
         end if;
		elsif(OP = "10010") then --MULT
			Resultado <= std_logic_vector(signed(A)*signed(B))(24 downto 0);
			Flag <= '0';
		elsif(OP = "10001") then --DIV
			Resultado <= std_logic_vector(signed(A)/signed(B))(24 downto 0);
			Flag <= '0';
		elsif(OP = "11100") then --MOD
			Resultado <= std_logic_vector(signed(A) mod signed(B))(24 downto 0);
			Flag <= '0';
		else
			Resultado <= "0000000000000000000000000";
			Flag <= '0';

      end if;
	end process;
end architecture;
