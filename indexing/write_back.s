;		///SCHOOL OF LINUX///		

;author => "Jeevanandham.P.S"		




	AREA AD,CODE,READONLY
	ENTRY
	MOV R5,#4
	MOV R6,#1
	LDR R2,=ARM
	LDR R1,=AM
	LDR R0,=A
	LDR R3,[R2]
	LDR R4,[R1]
	ADDS R3,R4
	STR R3,[R0]
LP	LDR R3,[R2,#4]!
	LDR R4,[R1,#4]!
	ADDS R3,R4
	STR R3,[R0,#4]!
	SUBS R5,R6
	BNE LP
LOOP	B LOOP
ARM	DCD 0X00000001,0X00000001,0X00000001,0X00000001,0X00000001
AM	DCD 0X00000001,0X00000001,0X00000001,0X00000001,0X00000001		
	AREA AP,DATA,READWRITE
A	DCD 0
	END
