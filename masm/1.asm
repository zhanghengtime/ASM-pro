DATA SEGMENT
X DB ?
Y DB ?
Z DB ?
D DB ?
C DB ?
X1 DB ?
DATA ENDS

CODE SEGMENT
		ASSUME CS:CODE,DS:DATA
	START:MOV AX,DATA
	      MOV DS,AX
		  MOV C,2AH
		  MOV D,3DH
		  MOV X,06H
		  MOV Y,06H
		  MOV X1,02H
	      MOV CX,08H 
          MOV AL,X
          MOV BL,Y
          MUL BL
          MOV Z,AL
          MOV DL,X
		  ADD DL,30H
          MOV AH,02H
          INT 21H
		  MOV DL,C
          MOV AH,02H
          INT 21H
          MOV DL,Y
		  ADD DL,30H
          MOV AH,02H
          INT 21H
          MOV DL,D
          MOV AH,02H
          INT 21H
          MOV DL,Z
		  CMP DL,9H
		  JLE L6
		  XOR AX,AX
		  MOV AL,DL
		  MOV BH,0AH
		  DIV BH
		  MOV DL,AL
		  MOV BL,AH
		  MOV AH,02H
		  ADD DL,30H
		  INT 21H
		  MOV DL,BL
		  ADD DL,30H
		  MOV AH,02H
		  INT 21H
		  JMP L8
    L6:   ADD DL,30H
		  MOV AH,02H
          INT 21H
	L8:	  INC Y
		  MOV DL,0AH
          MOV AH,02H
	      INT 21H
		  MOV DL,0DH
		  MOV AH,02H
	      INT 21H  
    L:    MOV AH,4CH
          INT 21H	  
CODE ENDS
END START		  
		  