DATA SEGMENT
	X DB ?
DATA ENDS

CODE SEGMENT 
	ASSUME CS:CODE,DS:DATA
START:MOV AX,DATA
	  MOV DS,AX
	  MOV AH,1  ;输入一位数
      INT 21H
	  CMP AL,36H  ;判断是否在3-6之间
	  JG L0
	  cmp AL,33H
	  JL L0
	  AND AL,0FH
	  MOV X,AL   
	  CMP X,3
	  JLE L1
	  CMP X,4
	  JLE L2
	  CMP X,5
	  JLE L3
	  CMP X,6
	  JLE L4
	  JMP L9
L0:   MOV AH,4CH 
      INT 21H		  
L1:   MOV DL,0AH ;输入3 执行3*3+3
	  MOV AH,2
	  INT 21H
      MOV BL,X  
	  MOV AL,X
	  MUL BL
	  MOV AL,AX
	  ADD AL,BL
	  MOV BH,AL
	  JMP L
L2:   MOV DL,0AH ;输入4 执行4*4-2*4
	  MOV AH,2
	  INT 21H
      MOV BL,X 
	  MOV AL,X
	  MUL BL
	  MOV AL,AX
	  MOV CL,1
	  SAL BL,CL
	  SUB AL,BL
	  MOV BH,AX
	  JMP L
L3:   MOV DL,0AH ;输入5 执行5*5
	  MOV AH,2
	  INT 21H
      MOV BL,X ;5
	  MOV AL,X
	  MUL BL
	  MOV BH,AX
	  JMP L
L4:   MOV DL,0AH ;输入6 执行6*6/2
	  MOV AH,2
	  INT 21H
      MOV BL,X 
	  MOV AL,X
	  MUL BL
	  MOV BL,2
	  DIV BL
	  MOV BH,AL
      JMP L	  
L:    MOV CL,4H ;以16进制输出
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
	  