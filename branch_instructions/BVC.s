		AREA INS,CODE,READONLY
		ENTRY
		MOV R1,#0X7FFFFFFF	; move value to R1
		MOV R2,#0X01	; move value to R2
	
LOOP
		ADDS R1,R2		; R1 = R1 - R2
		BVC LOOP		; When the CPSR set the overflow bit, that it this contdition fail..
LP		B LP			; branch always
		END