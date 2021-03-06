DATA SEGMENT
	NUM1 DB 22H,33H,77H,63H,88H,99H
	NUM1L DB 6    ;加数1的长度
	NUM2 DB 22H,22H,72H,22H
	NUM2L DB 4    ;加数2的长度
DATA ENDS

STACK1 SEGMENT PARA STACK
	DW 20H DUP(0)
STACK1 ENDS

CODE SEGMENT 
	ASSUME CS:CODE,DS:DATA,SS:STACK1
START:  MOV AX,DATA
		MOV DS,AX
		MOV CH,0
		MOV SI,OFFSET NUM1
		MOV DI,OFFSET NUM2
		MOV AH,NUM1L
		MOV AL,NUM2L
		CMP AH,AL    ;比较两个数的长度
		JAE CHA      ;数num1长否
		XCHG SI,DI   ;交换首地址
		XCHG AH,AL   ;交换长度
CHA:    SUB AH,AL
        MOV BL,AH
		MOV CL,AL    ;相同长度数存在cl
		CLC          ;cf标志位送0  
LOP1:   MOV AL,[DI]  ;循环lop1为同长度部分相加 
		ADC [SI],AL
		INC SI
		INC DI
		LOOP LOP1
		MOV CL,BL    ;两数长度之差送cl
		JCXZ NEXT    ;若两数长度相同，结束 
LOP2:   ADC BYTE PTR [SI],0  ;循环lop2处理剩余的字节
		INC SI
		LOOP LOP2
		MOV CL,NUM1L
LOP3:   PUSH CX
        DEC SI
        MOV BL,[SI]
		MOV DL,[SI]
		MOV CL,4
		SHR DL,CL
		CMP DL,09H
		JG LA
		ADD DL,30H
		MOV AH,02H
		INT 21H
		JMP LB
LA:		ADD DL,37H
        MOV AH,02H
		INT 21H
LB:		MOV DL,BL
		AND DL,0FH
		CMP DL,09H
		JG LAA
		ADD DL,30H
		MOV AH,02H
		INT 21H
		JMP LBB
LAA:	ADD DL,37H
        MOV AH,02H
		INT 21
LBB:	POP CX
	    LOOP LOP3
NEXT:   MOV AH,4CH
		INT 21H
CODE ENDS
		END START