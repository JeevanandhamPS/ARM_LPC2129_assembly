		    AREA SAMPLE,CODE,READONLY
            ENTRY
		    MOV R10,#0X00000005
		    LDR R11,=ARM_STATE
		    LDR R0,=ARM_ST
LOOP		LDRH R2,[R11],#4
	    	STRH R2,[R0],#4
		    SUBS R10,#0X00000001
			BNE LOOP
A1          B   A1
ARM_STATE   DCD 0X0F0F0F0F,0X00001111,0X11110000,0X10101010,0X11112222
		    AREA SAMPLE,DATA,READWRITE
ARM_ST      DCD 0	
		    END
		