	AREA INS,CODE,READONLY
	ENTRY
	MOV R1,#0X02	; move two to R1
	MOV R2,#0X01	; move one to R2
LOOP
	ADDS R1,R2		; R1 = R1 + R2
	BAL LOOP		; Branch always call the label 
	END