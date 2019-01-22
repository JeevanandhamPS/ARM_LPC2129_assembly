 			 ;;;    SCHOOL OF LINUX    ;;;
    
;Author => "Jeevanandham.P.S"
;Date   => 29dec2018



			AREA PIN_SEL,CODE,READONLY
			ENTRY
 
PINSEL0 	EQU 0xE002C000		; GPIO enable address
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

			LDR R0,=IO0DIR 		; load the address to R0
			LDR R1,[R0]         ; load the R0 values 
			MOV R3,#0XFFFFFFFF  ; all are 1 means output pins
			MOV R1,R3
			STR R1,[R0]
__main
			MOV R4,#0X00010000	; mov 0x00008000 to R4
			MOV R3,#0X00008000  ; Mov 0x00010000 to R3
			MOV R5,#0X00000010  ; we need 16cycles.. mov 15 to R3
			
			LDR R6,=0x000000FF
;we make 255 no operation cycle	
time_		
			NOP
			NOP
			SUBS R6,#0X1			
			BNE time_
			
			
shift
			LDR R0,=IO0SET 		; load the address to R0
			LDR R1,[R0]         ; load the R0 values to R1 
			ADDS R8,R4,R3       ; R8 = R4+R3
			MOV R1,R8           ; Move R8 to R1
			STR R1,[R0]			; store R1 values to R0
				
			LDR R6,=0X0000FFFF
;we make 65535 no operation cycle	
time		
			NOP
			NOP
			NOP
			NOP
			SUBS R6,#0X1			
			BNE time
	
			LDR R0,=IO0CLR		; load the address to R0
			LDR R1,[R0]         ; load the R0 values to R1
			ADDS R8,R4,R3       ; R8 = R4+R3
			MOV R1,R8           ; Move R8 to R1
			STR R1,[R0]         ; store R1 values to R0
			
			LSL R4,#1			; R4 = R4<<1
			ADDS R4,#0X00010000
			LSR R3,#1			; R3 = R3>>1
			ADDS R3,#0X00008000
			
			LDR R6,=0X0000FFFF
;we make 255 no operation cycle	
time1		
			NOP
			NOP
			SUBS R6,#0X1			
			BNE time1
					
			
			SUBS R5,#0X1		; R5 = R5 - 1
			
			BNE shift			; Branch Not equal,if 0 went out, otherwise call shift 
			B   __main
			END  
