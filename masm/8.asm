CODE SEGMENT 
	ASSUME CS:CODE
START:MOV AH,00H
	  MOV AL,03H
	  INT 10H 
CODE ENDS
	END START
      
CODE ENDS
	END START