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
		  MOV C,2AH     ;乘号
		  MOV D,3DH     ;等号
		  MOV X,01H     ;x初值为1
		  MOV Y,01H     ;y初值为1
		  MOV X1,02H    
	      MOV CX,08H    ;外循环次数
		  MOV DL,01H     
          MOV AL,X      ;输出1*1=1
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
          ADD DL,30H
		  MOV AH,02H
          INT 21H	  
		  INC Y
		  MOV DL,0AH
          MOV AH,02H
	      INT 21H
		  MOV DL,0DH
		  MOV AH,02H
	      INT 21H  		  
	LOP:  PUSH CX      ;cx进栈
	      MOV DH,01H   ;外循环8次
	      MOV AL,X
          MOV BL,Y
          MUL BL
          MOV Z,AL
          MOV DL,X
		  ADD DL,30H
          MOV AH,02H
          INT 21H      ;输出乘数
		  MOV DL,C
          MOV AH,02H
          INT 21H      ;输出*号
          MOV DL,Y
		  ADD DL,30H
          MOV AH,02H
          INT 21H      ;输出乘数 
          MOV DL,D
          MOV AH,02H
          INT 21H       ;输出等号
          MOV DL,Z
          CMP DL,9H
		  JLE L6
		  XOR AX,AX
		  MOV AL,DL
		  MOV BH,0AH
		  DIV BH         ;10进制输出
		  MOV DL,AL
		  MOV BL,AH
		  MOV AH,02H
		  ADD DL,30H
		  INT 21H
    L5:   CMP DH,05H
          JG LOP	    ;内循环，横着输出
		  MOV DL,BL
		  ADD DL,30H
		  MOV AH,02H
		  INT 21H
		  JMP L8
    L6:   ADD DL,30H
		  MOV AH,02H
          INT 21H
	L8:	  MOV CL,Y
          SUB CL,01H	  
	LOP2: MOV DL,20H
          MOV AH,02H
          INT 21H
	      MOV AL,X1
          MOV BL,Y
          MUL BL
          MOV Z,AL
          MOV DL,X1
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
	L4:   CMP DH,05H
          JG L5	
          MOV DL,D
          MOV AH,02H
          INT 21H
		  MOV DL,Z
          CMP DL,9H
		  JLE L9
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
		  JMP L10
    L9:   ADD DL,30H
		  MOV AH,02H
          INT 21H
		  MOV DL,20H
		  MOV AH,02H
		  INT 21H
	L10:  INC X1 		 ;第一位乘数+1
    L1:   LOOP LOP2
	      MOV X1,02H 
	      POP CX         ;cx出栈
		  MOV DL,0AH
          MOV AH,02H
	      INT 21H
		  MOV DL,0DH
		  MOV AH,02H
	      INT 21H  
		  INC Y           ;第二位乘数+1
	L2:   MOV DH,08H
	      LOOP L4
    L:    MOV AH,4CH     ;结束
          INT 21H	
CODE ENDS
END START		  

