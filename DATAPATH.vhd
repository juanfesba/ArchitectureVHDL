-- A library clause declares a name as a library.  It 
-- does not create the library; it simply forward declares 
-- it. 
library IEEE;


-- Commonly imported packages:

	-- STD_LOGIC and STD_LOGIC_VECTOR types, and relevant functions
	use ieee.std_logic_1164.all;

	-- SIGNED and UNSIGNED types, and relevant functions
	use ieee.numeric_std.all;


	
entity DATAPATH is

	port
	(
		-- Input ports
		--dir	  : in  natural range 0 to 7;
		Clkfpga  : in  std_logic; --50mHz
		---MuxImmSignal : in std_logic_vector(1 downto 0);
		---MuxDstSignal : std_logic;
		---MuxMDROUTSignal : std_logic;
		---RFWriteEN : in std_logic;
		ResetClock: in std_logic; 
		Switch0 : in std_logic;
		Switch1 : in std_logic;
		Switch2 : in std_logic;
		Switch3 : in std_logic;
		Switch4 : in std_logic;
		Switch5 : in std_logic;
		Switch6 : in std_logic;
		Switch7 : in std_logic;
		IControl : in std_logic; --switch 8
		IRunOrWalk : in std_logic; --switch 9
		IPushB0 : in std_logic; --push button 0
		IPushB1 : in std_logic; -- push button 1
		IPushB2 : in std_logic; -- push button 2
		ISensor0 : in std_logic; --galga extensiometrica
		--ISensor1 : in std_logic;
		
		--Enable: in std_logic;
		--EnableInput: in std_logic;
		--
		--Enable  : in std_logic;
		-- Output ports
		--SALU  : out std_logic_vector(24 downto 0);
		SPCOUTT  : out std_logic_vector(24 downto 0);
		SIR  : out std_logic_vector(24 downto 0);
		RegistroAA : out std_logic_vector(24 downto 0);
		RegistroBB : out std_logic_vector(24 downto 0);
		--RAMOUT : out std_logic_vector(24 downto 0);
		--FlagPrueba: out std_logic;
		--SPCIN  : out std_logic_vector(24 downto 0);
		sieteS0  : out std_logic_vector(6 downto 0);
		sieteS1  : out std_logic_vector(6 downto 0);
		sieteS2  : out std_logic_vector(6 downto 0);
		sieteS3  : out std_logic_vector(6 downto 0);
		DIRMEMORIA,SalidaMUXMDR, R12P, R13P : out std_logic_vector(24 downto 0)

	);
	
end DATAPATH;

-- Library Clause(s) (optional)
-- Use Clause(s) (optional)

architecture structural of DATAPATH is
		--UNIDAD DE CONTROL
signal DataDst: std_logic_vector(3 downto 0);
signal PCWriteCon: std_logic;
signal PCSource: std_logic_vector(1 downto 0);
signal PCWrite: std_logic;
signal IorD: std_logic_vector(1 downto 0);
signal MemRead: std_logic;
signal MemWrite: std_logic;
signal IRWrite: std_logic;
signal RegDst: std_logic_vector(1 downto 0);
signal MemtoReg: std_logic_vector(1 downto 0);
signal RegWrite: std_logic;
signal AluSrcA: std_logic;
signal AluSrcB: std_logic_vector(1 downto 0);
signal AluOP: std_logic;
signal ResetPC: std_logic;
signal EnableIR: std_logic;
signal MDRWrite: std_logic;
signal RMP: std_logic;
signal EnableMDR: std_logic;
	-- Declarations (optional)
	signal instruccion,REGISTROM,REGISTROP : std_logic_vector(24 downto 0);
	signal ALUOut, ALUCon : std_logic_vector(24 downto 0);
	signal RS,RT : std_logic_vector(24 downto 0);
	signal RTMUX,IMMUX,RSMUX : std_logic_vector(24 downto 0);
	signal MUXRF : std_logic_vector(4 downto 0);
	signal RTRegister,RSRegister : std_logic_vector(24 downto 0);
	signal IROut,MDROut,MUXMDROUT : std_logic_vector(24 downto 0);
	signal PCOutValue: std_logic_vector(24 downto 0);
	signal PCNext: std_logic_vector(24 downto 0);
	signal SalidaOR, ANDOut : std_logic;
	signal FlagOut : std_logic;
	signal MUXPCOUT, JUMPX : std_logic_vector(24 downto 0);
	signal MuxSignal : std_logic_vector(1 downto 0);
	
	signal InputEntradas : std_logic_vector(24 downto 0);
	signal Sensor0ExtOut : std_logic_vector(24 downto 0);
	signal Sensor1ExtOut : std_logic_vector(24 downto 0);
	signal Push0ExtOut : std_logic_vector(24 downto 0);
	signal Push1ExtOut : std_logic_vector(24 downto 0);
	signal Push2ExtOut : std_logic_vector(24 downto 0);
	signal WeightExtOut : std_logic_vector(24 downto 0);
	signal ControlExtOut : std_logic_vector(24 downto 0);
	signal RunWalkExtOut : std_logic_vector(24 downto 0);
	signal InputMuxOut : std_logic_vector(24 downto 0);
	signal Clk :   std_logic;

	
--- flag de Jump
  signal Zero : std_logic;
begin

	DivisorF : work.DivisorFrecuencia
	port map
	(
		Clock => Clkfpga,
		Reset => '0',
		ClockOUT => Clk
	);

	Memoria : work.RAM
	port map
	(
		clk => clk,
		addr => MUXPCOUT,
		data => RS,
		we => MemWrite,
		q => instruccion
	);
	
	UnidadControl: entity work.UnidadDeControl
	port map
	(
		Clock => Clk,
		Enable => '1',
		EnableInput => '1',
		Opcode => Instruccion(24 downto 20),
		--DataDst => DataDst,
		PCWriteCon => PCWriteCon,
		PCSource => PCSource,
		PCWrite => PCWrite,
		IorD => IorD,
		MemRead => MemRead,
		MemWrite => MemWrite,
		IRWrite => IRWrite,
		RegDst => RegDst,
		MemtoReg => MemtoReg,
		RegWrite => RegWrite,
		AluSrcA => AluSrcA,
		AluSrcB => AluSrcB,
		AluOP => AluOP,
		ResetPC => ResetPC,
		EnableIR => EnableIR,
		MDRWrite => MDRWrite,
		EnableMDR => EnableMDR,
		RMP => RMP
	);
	
	InstruccionRegister : work.IR
	port map
	(
		Clock => clk,
		IRWrite => IRWrite,
		EnableIR => EnableIR,
		InsIn => instruccion,
		InsOut => IROut
	);
	
	MDR : work.MDR
	port map
	(
		Clock => clk,
		MDRWrite => MDRWrite,
		EnableMDR => EnableMDR,
		DataIN => instruccion,
		DataOUT => MDROut
	);
	
	RF : work.RegisterFile
	port map
	(
		clock => clk,
		rs => IROut(19 downto 15),
		rt => IROut(14 downto 10),
		rd => MUXRF,
		DataIn => MUXMDROUT,
		WriteEn => RegWrite,
		DataOut1 => RS,
		DataOut2 => RT
	);
	
	ALU : work.ALU
	port map
	(
		OP => IROut(24 downto 20),
		A => RSMUX,
		B => RTMUX,
		ALUOP => AluOP,
		Resultado => ALUCon,
		Flag => FlagOut
	);
	
	IMMEXTND : work.ImmExtend
	port map
	(
		Imm => IROut(9 downto 0),
		S => IMMUX
	);
	
	MUXIMMDT : work.bit2MUX4
	port map
	(
		MuxSignal => AluSrcB,
		Input1 => RTRegister,
		Input2 => "0000000000000000000000001",
		Input3 => IMMUX,
		Input4 => "0000000000000000000000000",
		OutMux => RTMUX
	);
	
	MUXRDRF : work.bit5MUX4
	port map
	(
		MuxSignal => RegDst,
		Input1 => IROut(14 downto 10),
		Input2 => IROut(9 downto 5),
		Input3 => IROut(19 downto 15),
		Input4 => "00000",
		OutMux => MUXRF
	);
	
	MUXMDROUTE : work.bit2MUX4
	port map
	(
		MuxSignal => MemToReg,
		Input1 => MDROut,
		Input2 => AluOut,
		Input3 => InputMuxOut,
		Input4 => "0000000000000000000000000",
		OutMux => MUXMDROUT
	);
	
	RegisterA : work.RegistroA
	port map
	(
		Clock => clk,
		DataIN => RS,
		DataOUT => RSRegister
	);
	
	RegisterB : work.RegistroA
	port map
	(
		Clock => clk,
		DataIN => RT,
		DataOUT => RTRegister
	);
	
	ALUoutR : work.RegistroA
	port map
	(
		Clock => clk,
		DataIN => ALUCon,
		DataOUT => ALUOut
	);

	ORCompuerta: entity work.ORGate
	port map
	(
		IN1 => ANDOut,
		IN2 => PCWrite,
		OutOR => SalidaOR
	);
	CompuertaAND: entity work.CompuertaAND
	port map
	(
		Input1 => FlagOut,
		Input2 => PCWriteCon,
		ANDOut => ANDOut
	);
	MUXJump: entity work.bit2MUX4
	port map
	(
		MuxSignal => PCSource,
		Input1 => JUMPX, -- JumpOUT
		Input2 => AluCon,
		Input3 => PCNext, -- ConstanteOut
		Input4 => IMMUX,
		OutMux => PCNext
	);

	MUXPC : entity work.bit2MUX4
	port map(
		MuxSignal => IorD,
		Input1 => PCOutValue,
		Input2 => RT,
		Input3 => PCNext,
		Input4 => "0000000000000000000011001",
		OutMux => MUXPCOUT
	);
		MUXA : entity work.MUX2
	port map(
		MuxSignal => AluSrcA,
		Entrada1 => PCOutValue,
		Entrada2 => RSRegister,
		S => RSMUX
	);
	
	PC: entity work.PC(PC)
	port map
	(
		Clock => clk,
		ResetPC => ResetPC,
		SignalPC => SalidaOR,
		PCin => PCNext,
		PCout => PCOutValue
	);
	
	JUMPEXT : work.ImmExtend
	port map
	(
		Imm => IROut(19 downto 10),
		S => JUMPX
	);

	MUXENTRADAS : work.MUXENTRADAS
	port map
	(	
	MuxSignal => IROut(3 downto 0),
	Sensor0 => Sensor0ExtOut,
	Sensor1 => Sensor1ExtOut,
	PushButton0 => Push0ExtOut,
	PushButton1 => Push1ExtOut,
	PushButton2 => Push2ExtOut,
	Weight => WeightExtOut,
	Control => ControlExtOut,
	RunWalk => RunWalkExtOut,
	S => InputMuxOut
	);

	SENSOR0 : work.SensorExtend
	port map
	(
		Sensor => ISensor0,
		S => Sensor0ExtOut
	);	
	
	SENSOR1 : work.SensorExtend
	port map
	(
		Sensor => IPushB1,
		S => Push1ExtOut --cambiar
	);	

	PUSHB0 : work.SensorExtend
	port map
	(
		Sensor => IPushB0,
		S => Push0ExtOut
	);	

	--PUSHB1 : work.SensorExtend
	--port map
	--(
		--Sensor => IPushB1,
		--S => Push1ExtOut
	--);	

	PUSHB2 : work.SensorExtend
	port map
	(
		Sensor => IPushB2,
		S => Push2ExtOut
	);	

	RUNORWALK : work.SensorExtend
	port map
	(
		Sensor => IRunOrWalk,
		S => RunWalkExtOut
	);	

	CONTROL : work.SensorExtend
	port map
	(
		Sensor => IControl,
		S => ControlExtOut
	);
	
	WEIGHT : work.Input8Extend
	port map
	(
		Input0 => Switch0,
		Input1 => Switch1,
		Input2 => Switch2,
		Input3 => Switch3,
		Input4 => Switch4,
		Input5 => Switch5,
		Input6 => Switch6,
		Input7 => Switch7,
		S => WeightExtOut
	);
	
	REGISTROMM : work.MDR
	port map
	(
		Clock => clk,
		MDRWrite => RMP,
		EnableMDR => '1',
		DataIN => RS,
		DataOUT => REGISTROM
	);
	
	REGISTROPP : work.MDR
	port map
	(
		Clock => clk,
		MDRWrite => RMP,
		EnableMDR => '1',
		DataIN => RT,
		DataOUT => REGISTROP
	);
	
	BCD : work.BCD
	port map(
		DataDer => REGISTROM(6 downto 0),
		DataIzq => REGISTROP(6 downto 0),
		SalidaData1 => SieteS0,
		SalidaData2 => SieteS1,
		SalidaData3 => SieteS2,
		SalidaData4 => SieteS3
	);

	
	--SALU <= ALUCon;
	SPCOUTT <= PCOutValue;
	--SPCIN <= PCNext;
	SIR <= IROut;
	RegistroAA <= RS;
	RegistroBB <= RT;
	R12P <= REGISTROM;
	R13P <= REGISTROP;
	--RAMOUT <= instruccion;
	--FlagPrueba <= FlagOut;
	DIRMEMORIA <= MUXPCOUT;
	SalidaMUXMDR <= MUXMDROUT;
	


end structural;