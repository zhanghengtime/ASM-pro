DATA SEGMENT
	COL DW 158
	ROW DW 98
	LENGTH DW 2
	COLOR DB 1
	X DB ��
DATA ENDS

STACK1 SEGMENT STACK
	DW 20 DUP(0)
STACK1 ENDS

CODE SEGMENT
	ASSUME CS:CODE,DS:DATA,SS:STACK1
START:MOV AX,DATA
	  MOV DS,AX
	  MOV AH,0   ;������ʾ��ʽ
	  MOV AL,0DH
	  INT 10H
	  MOV X,01H
	  MOV Y,01H
	  MOV CX,158
LOP:  PUSH CX
      MOV DX,ROW  ;���������
	  MOV CX,COL
	  INC X
	  dec cx
	  inc length
	  CALL PROC_X
	  dec length
	  MOV DX,ROW  ;���ұ�����
	  MOV CX,COL
	  ADD CX,LENGTH
	  CALL PROC_Y
	  MOV DX,ROW  ;���������
	  MOV CX,COL
	  ADD DX,LENGTH
	  CALL PROC_X
	  MOV DX,ROW  ;���������
	  MOV CX,COL
	  CALL PROC_Y 
	  INC LENGTH
	  CMP X,98
	  JG L11
	  INC LENGTH
	 
L11:  DEC ROW
      DEC COL
	  POP CX
	  MOV BX,0FFFFH  
NEXT: DEC BX
      JNE NEXT
	  MOV AH,0   ;������ʾ��ʽ
	  MOV AL,0DH
	  INT 10H
	  LOOP LOP
	  MOV CX,158
LOP3: PUSH CX
      INC Y
      MOV DX,ROW  ;���������
	  MOV CX,COL
	  dec cx
	  inc length
	  CALL PROC_X
	  dec length
	  MOV DX,ROW  ;���ұ�����
	  MOV CX,COL
	  ADD CX,LENGTH
	  CALL PROC_Y
	  MOV DX,ROW  ;���������
	  MOV CX,COL
	  ADD DX,LENGTH
	  CALL PROC_X
	  MOV DX,ROW  ;���������
	  MOV CX,COL
	  CALL PROC_Y 
	  dec LENGTH
	  CMP Y,98
	  JG L12
	  inc COL
L12:  dec LENGTH
	  inc ROW
	  POP CX
	  MOV BX,0FFFFH  
NEXT1:DEC BX
      JNE NEXT1	
      cmp cx,01h
	  jle l3	  
      MOV AH,0   ;������ʾ��ʽ
	  MOV AL,0DH
	  INT 10H
l3:   LOOP LOP3
	  MOV AH,1   ;����
	  INT 21H
	  MOV AH,0
	  MOV AL,3
	  INT 21H
	  MOV AH,4CH  ;����
	  INT 21H
PROC_X PROC    ;�������ӳ���
	MOV BP,LENGTH   ;�߳�
LOP1:MOV BH,0       ;��ҳ��
	 INC CX         ;�޸��к� 
	 MOV AL,COLOR   ;ȡ����ֵ
	 MOV AH,0CH     ;д����
	 INT 10H
	 DEC BP
	 JNE LOP1
	 RET
PROC_X ENDP
PROC_Y PROC         ;�������ӳ���
		MOV BP,LENGTH
LOP2:MOV BH,0
	 INC DX         ;�޸��к�
	 MOV AL,COLOR
	 MOV AH,0CH
	 INT 10H
	 DEC BP
	 JNE LOP2
	 RET
PROC_Y ENDP
	  
CODE ENDS
	END START
      