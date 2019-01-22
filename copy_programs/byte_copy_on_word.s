 			AREA ARRAY,CODE,READONLY
			ENTRY
			MOV R5,#5
			MOV R6,#1
			LDR R1,=ARM_STATE
			LDR R0,=ARM_ST
LOOP		LDRB R2,[R1],#4
			STRB R2,[R0],#4
			SUBS R5,R6
			BNE LOOP
LOOP1		B 	LOOP1
ARM_STATE	DCD 0X00000011,0X00000022,0X00000033,0x00000044,0x00000055
			AREA SAMP,DATA,READWRITE
ARM_ST		DCD 0
			END