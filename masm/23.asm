DATA SEGMENT
    NUM1 DB 20H DUP(?)
	NUM11 DB 'please input the first number: $'
	NUM1L DB 0   ;��1�ĳ���
	OUTPUT DB 'the output is: $' 
	CHOICE DB 'please input your choice: $'
DATA ENDS

STACK1 SEGMENT PARA STACK
	DW 20H DUP(0)
STACK1 ENDS

CODE SEGMENT 
	ASSUME CS:CODE,DS:DATA,SS:STACK1
START:  MOV AX,DATA
		MOV DS,AX
		MOV DX,OFFSET NUM11 ;�����һ����ʾ
		MOV AH,09H
		INT 21H
	    MOV SI,OFFSET NUM1
		CALL PROC_INPUT1    ;�����һ����
     	DEC SI
		MOV DL,0DH      ;����
		MOV AH,02H
		INT 21H
		MOV DL,0AH
		MOV AH,02H
		INT 21H
		MOV DX,OFFSET CHOICE  ;�����2����ʾ
		MOV AH,09H
		INT 21H
		MOV AH,01H    ;����ѡ��
		INT 21H
		CMP AL,2BH
		JLE LADD
		CMP AL,2DH
		JGE LSUB
		JMP NEXT
LADD:	MOV DL,0DH       ;ִ�мӷ�����
		MOV AH,02H
		INT 21H
		MOV DL,0AH        ;����
		MOV AH,02H
		INT 21H
		MOV DL,0DH
		MOV AH,02H
		INT 21H
		MOV DL,0AH
		MOV AH,02H
		INT 21H
		MOV DX,OFFSET output  ;������ĸ���ʾ
		MOV AH,09H
		INT 21H
        CALL PROC_PRITEADD   ;����ӷ��Ľ��
		JMP NEXT
LSUB:	MOV DL,0DH       ;ִ�м�������
		MOV AH,02H
		INT 21H
		MOV DL,0AH       ;����
		MOV AH,02H
		INT 21H
		MOV DL,0DH
		MOV AH,02H
		INT 21H
		MOV DL,0AH
		MOV AH,02H
		INT 21H
		MOV DX,OFFSET output  ;������ĸ���ʾ
		MOV AH,09H
		INT 21H 
        CALL PROC_PRITESUB  ;��������Ľ��
NEXT:   MOV AH,4CH
		INT 21H	
PROC_INPUT1 PROC    ;�����һ�����ӳ���
	MOV CX,1
INPUT1: MOV CL,4
        MOV AH,01H
		INT 21H
		CMP AL,39H   ;���벻��0-9֮���˳�
		JG RE1
		CMP AL,30H
		JL RE1
		SUB AL,30H
		SHL AL,CL
		XOR BL,BL
		MOV BL,AL
		MOV AH,01H
		INT 21H
		SUB AL,30H
		ADD BL,AL
		MOV [SI],BL
	    INC SI
		INC NUM1L    ;���ȼ�һ
		LOOP INPUT1
RE1:	RET
PROC_INPUT1 ENDP

PROC_PRITEADD PROC     ;�ӷ��ӳ���
       	MOV AH,NUM1L
		MOV AL,NUM2L
		CMP AH,AL    ;�Ƚ��������ĳ���
		JAE CHA      ;��num1����
		XCHG SI,DI   ;�����׵�ַ
		XCHG AH,AL   ;��������
CHA:    SUB AH,AL
        MOV BL,AH
		MOV CL,AL    ;��ͬ����������cl
		CLC          ;cf��־λ��0  
LOP1:   MOV AL,[DI]  ;ѭ��lop1Ϊͬ���Ȳ������ 
		ADC [SI],AL
		DEC SI
		DEC DI
		LOOP LOP1
		MOV CL,BL    ;��������֮����cl
		JCXZ LLL     ;������������ͬ������ 
LOP2:   ADC BYTE PTR [SI],0  ;ѭ��lop2����ʣ����ֽ�
		DEC SI
		LOOP LOP2
LLL:    MOV CL,NUM1L	
LOP3:   PUSH CX
        INC SI
        MOV BL,[SI]
		MOV DL,[SI]
		MOV CL,4
		SHR DL,CL
		CMP DL,09H   ;��16�������
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
        RET	
PROC_PRITEADD ENDP	

PROC_PRITESUB PROC    ;�����ӳ���
       	MOV AH,NUM1L
		MOV AL,NUM2L
		CMP AH,AL    ;�Ƚ��������ĳ���
		JAE CHA2      ;��num1����
		XCHG SI,DI   ;�����׵�ַ
		XCHG AH,AL   ;��������
CHA2:   SUB AH,AL
        MOV BL,AH
		MOV CL,AL    ;��ͬ����������cl
		CLC          ;cf��־λ��0  
LOP12:  MOV AL,[DI]  ;ѭ��lop1Ϊͬ���Ȳ������ 
		SBB [SI],AL
		DEC SI
		DEC DI
		LOOP LOP12
		MOV CL,BL    ;��������֮����cl
		JCXZ LLL2     ;������������ͬ������ 
LOP22:  SBB BYTE PTR [SI],0  ;ѭ��lop2����ʣ����ֽ�
		DEC SI
		LOOP LOP22
LLL2:   MOV CL,NUM1L	
LOP32:  PUSH CX
        INC SI
        MOV BL,[SI]
		MOV DL,[SI]
		MOV CL,4
		SHR DL,CL
		CMP DL,09H     ;��16�������
		JG LA2
		ADD DL,30H
		MOV AH,02H
		INT 21H
		JMP LB2
LA2:	ADD DL,37H
        MOV AH,02H
		INT 21H
LB2:	MOV DL,BL
		AND DL,0FH
		CMP DL,09H
		JG LAA2
		ADD DL,30H
		MOV AH,02H
		INT 21H
		JMP LBB2
LAA2:	ADD DL,37H
        MOV AH,02H
		INT 21
LBB2:	POP CX
	    LOOP LOP32
        RET	
PROC_PRITESUB ENDP	

CODE ENDS
		END START