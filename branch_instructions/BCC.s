		AREA INS,CODE,READONLY
		ENTRY
		MOV R1,#0X00	; move value to R1
		MOV R2,#0X01	; move value to R2
	
LOOP
		SUBS R1,R2		; R1 = R1 - R2
		BCC LOOP		; When the CPSR set the carry bit, that it this contdition fail..
LP		B LP			; branch always
		END