DATA SEGMENT
X DB '*'
Y DB ?
Z DB ?
A DB 'please input a number: $'
DATA ENDS

CODE SEGMENT 
		ASSUME CS:CODE,DS:DATA
	START:MOV AX,DATA
          MOV DS,AX
		  LEA DX,A    
          MOV AH,09H
          INT 21H	    ;输出提示语句
		  MOV AH,01H    ;输入三角形大小
		  INT 21H
		  SUB AL,30H
		  MOV Z,AL
		  MOV CL,Z      ;三角形大小进入循环次数
		  MOV DL,0AH
          MOV AH,02H
	      INT 21H
		  MOV DL,0DH
		  MOV AH,02H
	      INT 21H 
		  MOV Y,01H
		  MOV DL,X
          MOV AH,02H
          INT 21H
		  MOV DL,0AH
          MOV AH,02H
	      INT 21H
		  MOV DL,0DH
		  MOV AH,02H
	      INT 21H 
          CMP Z,1H     ;判断是否大于1
		  JLE L	
		  CMP Z,10     ;判断是否大于10
		  JG L
          SUB CL,01H		  
    LOP:  PUSH CX      ;cx进栈,开始外循环
	      MOV CL,Y
		  MOV DL,X
          MOV AH,02H
          INT 21H
	LOP2: MOV DL,X	   ;内循环
          MOV AH,02H
          INT 21H
	L2:	  LOOP LOP2
		  MOV DL,0AH   ;输出换行
          MOV AH,02H
	      INT 21H
		  MOV DL,0DH
		  MOV AH,02H
	      INT 21H  
		  POP CX       ;cx出栈
		  INC Y
	L1:   LOOP LOP	  
	L:    MOV AH,4CH   ;结束
          INT 21H	
CODE ENDS
END START     		  