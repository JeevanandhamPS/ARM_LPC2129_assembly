	AREA INS,CODE,READONLY
	ENTRY
	MOV R1,#0X02	; move two to R1
	MOV R2,#0X01	; move one to R2
LOOP
	SUBS R1,R2		; R1 = R1 - R2
	BPL LOOP		; When the CPSR not set the carry bit, that time this contdition fail..
LP	B LP			; branch always
	END