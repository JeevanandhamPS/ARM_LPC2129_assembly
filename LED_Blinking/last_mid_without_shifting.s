			;;;	SCHOOL OF LINUX     ;;;

;Author => "Jeevanandham.P.S"
;Date	=> 29dec2018



			AREA PIN_SEL,CODE,READONLY
			ENTRY

PINSEL0 	EQU 0xE002C000		; GPIO enable addre
IO0DIR 		EQU 0xE0028008      ; I/O direction
IO0SET 		EQU 0xE0028004      ; pin set...
IO0CLR 		EQU 0xE002800C      ; clear the set... 
IO0PIN 		EQU 0xE0028000

;make the pins as General Purpose Input/Output

			LDR R0,=PINSEL0		; load the address to R0
			LDR R1,[R0]         ; load the R0 value to R1
			MOV R1,#0X00000000  ; mov all bits are zero to R1 (all pins are GPIO if zero means)
			STR R1,[R0]         ; store R1 values to R0
			
;Give the direction to the GPIO pins			
								
			LDR R0,=IO0DIR      ; load the address to R0
			LDR R1,[R0]         ; load the R0 values 
			MOV R2,#0XFFFFFFFF  ; all are 1 means output pins
			MOV R1,R2
			STR R1,[R0]         ; store the R1 values to R0
__main                         
			MOV R3,#0X0000000E  ; we need 15cycles.. mov 15 to R3
			MOV R4,#0X00010000	; Mov 0x00010000 to R4
			MOV R5,#0X00008000	; mov 0x00008000
			
			MOV R6,#0XE			; mov 15 to R6 
			MOV R7,#0X1			; mov 1 to R7
			ADDS R9,R4,R5		; Add R4 R5 store the addition value to R9
			
			LDR R12,=0x000000FF
;we make 255 no operation cycle	
time_		
			NOP
			NOP
			SUBS R12,#0X1			
			BNE time_
			
shift
			MOV R10,R6			; MOv the R6 value to R10

;we need last 16 bit as left to right...
sht
			ADDS R7,R7			; Add R7,R7 store to R7(to know the after the 00008000s 15th 14th...)
			SUBS R10,#1			; Sub R10 by one 
			BNE sht				; Branch Not equal,if 0 went out, otherwise call sht 
			
			ADDS R5,R7			; add R5,R7 to store the addtion value to R5
			
			LDR R0,=IO0SET 		; load the IO0SET address to R0
			LDR R1,[R0]         ; load the R0 values 
			MOV R1,R9           ; Move R9 value to R1
			STR R1,[R0]         ; store the R0 values to R1
			
			LDR R12,=0X0000FFFF
;we make 255 no operation cycle	
time		
			NOP
			NOP
			NOP
			NOP
			SUBS R12,#0X1			
			BNE time
	                            
			LDR R0,=IO0CLR      ; load the IO0CLR address to R0	
			LDR R1,[R0]         ; load the R0 values 
			MOV R1,R9           ; Move R9 value to R1
			STR R1,[R0]         ; store the R1 values to R0
			                    
			ADDS R4,R4          ; R4=R4+R4
			ADDS R4,#0X00010000 ; R4=R4+0x00010000
			ADDS R9,R4,R5       ; R9=R4+R5
	                            
			MOV R7,#0X1			;R7=0x1
			SUBS R6,#0X1		;R6=R6-1
			
			LDR R12,=0x000000FF
;we make 255 no operation cycle	
time1		
			NOP
			NOP
			SUBS R12,#0X1			
			BNE time1
		
			SUBS R3,#0X1		;R3=R3-1
			BNE shift			; Branch Not equal,if 0 went out, otherwise call sht 
			
			MOV R10,#2
			
loop		LDR R0,=IO0SET 		; load the IO0SET address to R0
			LDR R1,[R0]         ; load the R0 values 
			MOV R1,R9           ; Move R9 value to R1
			STR R1,[R0]         ; store the R0 values to R1
			
			LDR R12,=0X0000FFFF
;we make 65535 no operation cycle	
time2		
			NOP
			NOP
			NOP
			NOP
			SUBS R12,#0X1			
			BNE time2
	                            
			LDR R0,=IO0CLR      ; load the IO0CLR address to R0	
			LDR R1,[R0]         ; load the R0 values 
			MOV R1,R9           ; Move R9 value to R1
			STR R1,[R0]         ; store the R1 values to R0
			
			ADDS R9,#0x80000001
			
			SUBS R10,#1
			BNE loop
			                    
			B  __main
			END 
