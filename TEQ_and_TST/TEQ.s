/*****************************************/
/* Author	: Jeevanandham.P.S       */
/* Date		: 27jan2019              */
/* Filename	: teq.s                  */
/* Description	: explain TEQ instruction*/
/*****************************************/


		AREA TEST_EQUAL,CODE,READONLY
		ENTRY
			
		LDR R0,=ARR1	; load the arr1 address to the R0 register
		LDR R1,=ARR2	; load the arr2 address to the R1 register
		LDR R2,=ARR3	; load the arr3 address to the R2 register
		
		MOV R4,#5		; mov 5 to R4, because we have five values..
			
		;compare the values placed on arr1, arr2 one by one, if both are equal store the value to the arr3

COPY		
		LDR R3,[R0],#4	; load the R0 current value to the R3 register
		LDR R5,[R1],#4	; load the R1 currebt value to the R5 register
			
		TEQ R3,R5		; TEQ works like ex-or if both are equal it set Z=1, BNE go out..
		BNE FINAL		; when the values is different BNE call FINAL (it palced on final step of the process..)
		
		STR R3,[R2],#4	; If both values are same store the value to R3(out put is R3)
		;R4 subtraction for max 5 time cycle.., if values are changed means, this steps shoud be skip..
		SUBS R4,#1
		BNE COPY		; it call the COPY lable...
FINAL		

INF_LOOP	B INF_LOOP		; infinite loop..

ARR1		DCD 0X00000001,0X00000002,0X00000003,0X00000004,0X00000005	
ARR2		DCD 0X00000001,0X00000002,0X00000003,0X00000004,0X00000005

		AREA TEST, DATA ,READWRITE		; third arr is placed here, because that one need a write permission..
ARR3		DCD 0	; initially arr3 as 0
		END	; end...
