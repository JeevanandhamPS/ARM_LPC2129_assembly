 			 ;;;    SCHOOL OF LINUX    ;;;
    
;Author => "Jeevanandham.P.S"
;Date   => 29dec2018




			AREA PIN_SEL,CODE,READONLY
			ENTRY
 
PINSEL0 	EQU 0xE002C000		; GPIO enable addresss
IO0DIR 		EQU 0xE0028008      ; I/O direction
IO0SET 		EQU 0xE0028004      ; pin set...
IO0CLR 		EQU 0xE002800C      ; clear the set... 
IO0PIN 		EQU 0xE0028000
		
;make the pins as General Purpose Input/Output
		
		LDR R0,=PINSEL0			; load the address to R0
		LDR R1,[R0]             ; load the R0 value to R1
		MOV R1,#0X00000000      ; mov all bits are zero to R1 (all pins are GPIO if zero means)
		STR R1,[R0]             ; store R1 values to R0
		
;Give the direction to the GPIO pins
	
		LDR R0,=IO0DIR 			; load the address to R0
		LDR R1,[R0]             ; load the R0 values 
		MOV R3,#0XFFFFFFFF      ; all are 1 means output pins
		MOV R1,R3
		STR R1,[R0]             ; store the R1 values to R0
		
;We need to make Right to left

__main
		MOV R4,#0X00000001		; mov 1 to R4
		MOV R5,#0X00000020		; we need 32 cycles R5 = 32
		
		LDR R6,=0x000000FF
;we make 255 no operation cycle			
time_		
		NOP
		NOP
		SUBS R6,#0X1			
		BNE time_
			
shift
		LDR R0,=IO0SET 			; mov the IO set address to R0
		LDR R1,[R0]				; load the R0 values to R1
		MOV R1,R4				; mov R4 value to R1
		STR R1,[R0]				; Store the R1 values to the R0
		
		LDR R6,=0X0000FFFF
;we make 65535 no operation cycle	
time		
		NOP
		NOP
		NOP
		NOP
		SUBS R6,#0X1			
		BNE time
		
	
		LDR R0,=IO0CLR			; mov the IO clear address to R0
		LDR R1,[R0]             ; load the R0 values to R1
		MOV R1,R4               ; mov R4 value to R1
		STR R1,[R0]             ; Store the R1 values to the R0
	
		LDR R6,=0x000000FF
;we make 255 no operation cycle	
time1		
		NOP
		NOP
		SUBS R6,#0X1			
		BNE time1
			
	
		LSL R4,#0X1				; R4 = R4<<1
		SUBS R5,#0X1			; R5 = R5>>1
		
		BNE shift				; Branch Not equal,if 0 went out, otherwise call shift 
		B   __main
		END 
