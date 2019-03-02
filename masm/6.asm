DATA SEGMENT
    A DB 'please input a number $'
	B DB 'output the outcome $'
	C DB 'please input your choice $'
	X DB ?
	Y DB ?
DATA ENDS

CODE SEGMENT 
	ASSUME CS:CODE,DS:DATA
START:MOV AX,DATA
      MOV DS,AX
	  LEA DX,A
      MOV AH,09H
      INT 21H	
      MOV AH,1
      INT 21H
	  CMP AL,39H
	  JG L1
	  AND AL,0FH
	  MOV X,AL
	  JMP L2
L1:   AND AL,0FH
      ADD AL,9H
      MOV X,AL	
L2:   MOV DL,0AH
	  MOV AH,2
	  INT 21H
	  LEA DX,A
      MOV AH,09H
      INT 21H	
	  MOV AH,1
	  INT 21H
	  CMP AL,39H
	  JG L3
	  AND AL,0FH
	  MOV Y,AL
	  JMP L4
L3:   AND AL,0FH
      ADD AL,9H
      MOV Y,AL	
L4:   MOV DL,0AH
	  MOV AH,2
	  INT 21H
	  LEA DX,C
      MOV AH,09H
      INT 21H
	  MOV AH,1      
	  INT 21H
	  CMP AL,41H
      JLE L5 
      CMP AL,42H
      JLE L11 
      CMP AL,43H
      JLE L13 
      CMP AL,44H
      JLE L14
L5:   MOV DL,0AH ;x+y
	  MOV AH,2
	  INT 21H
	  LEA DX,B
      MOV AH,09H
      INT 21H
      MOV BH,X
	  MOV BL,Y
	  ADD BH,BL 
	  JMP L10
L11:  MOV DL,0AH ;x-y
	  MOV AH,2
	  INT 21H
	  LEA DX,B
      MOV AH,09H
      INT 21H
	  MOV BH,X
	  MOV BL,Y
	  CMP BH,BL
      JL L12
	  SUB BH,BL
	  JMP L10
L12:  SUB BL,BH 
      MOV BH,BL
	  JMP L10
L13:  MOV DL,0AH ;x*y
	  MOV AH,2
	  INT 21H
	  LEA DX,B
      MOV AH,09H
      INT 21H
      MOV BH,X
	  MOV BL,Y
	  MOV AL,BH
	  MUL BL
	  MOV BH,AL;
	  JMP L10
L14:  MOV DL,0AH ;x/y
	  MOV AH,2
	  INT 21H
	  LEA DX,B
      MOV AH,09H
      INT 21H
      MOV BH,X
	  MOV BL,Y
	  XOR AX,AX
	  MOV AL,BH
	  DIV BL
	  MOV BH,AL
      JMP L10	  
L10:  MOV CL,4H ;输出
      MOV CH,BH
	  SAR BH,CL
	  AND BH,0FH
      CMP BH,9H
	  JG L6
	  ADD BH,30H
	  MOV DL,BH
	  MOV AH,2
	  INT 21H
	  JMP L7
L6:   ADD BH,37H
      MOV DL,BH
	  MOV AH,2
	  INT 21H
L7:   MOV BH,CH
      AND BH,0FH
      CMP BH,9H
	  JG L8
	  ADD BH,30H
	  MOV DL,BH
	  MOV AH,2
	  INT 21H
	  JMP L9
L8:   ADD BH,37H
      MOV DL,BH
	  MOV AH,2
	  INT 21H
L9:   MOV AH,4CH
      INT 21H	  
CODE ENDS
END START 
        
      
      
	 