	AREA INS,CODE,READONLY
	ENTRY
	MOV R1,#0X00	;move zero to R1
	MOV R2,#0X00	;move zero to R2
LOOP
	SUBS R1,R2		; R1 = R1 - R2 zero bit as set on CPSR
	BEQ LOOP		; when the  zero bit is not set, that time it get fail and go to next step
LP	B LP			; Branch always
	END