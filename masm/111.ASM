DATA SEGMENT
	COL DW 158
	ROW DW 98
	LENGTH DW 2
	COLOR DB 1
DATA ENDS

STACK1 SEGMENT STACK
	DW 20 DUP(0)
STACK1 ENDS

CODE SEGMENT
	ASSUME CS:CODE,DS:DATA,SS:STACK1
START:MOV AX,DATA
	  MOV DS,AX
	  MOV AH,0   ;设置显示方式
	  MOV AL,0DH
	  INT 10H
	  MOV X,01H
	  MOV Y,01H
	  MOV CX,158
LOP:  PUSH CX
      MOV DX,ROW  ;画上面横线
	  MOV CX,COL
	  INC X
	  dec cx
	  inc length
	  CALL PROC_X
	  dec length
	  MOV DX,ROW  ;画右边竖线
	  MOV CX,COL
	  ADD CX,LENGTH
	  CALL PROC_Y
	  MOV DX,ROW  ;画下面横线
	  MOV CX,COL
	  ADD DX,LENGTH
	  CALL PROC_X
	  MOV DX,ROW  ;画左边竖线
	  MOV CX,COL
	  CALL PROC_Y 
	  INC LENGTH
	  DEC ROW
      DEC COL
	  INC LENGTH
	  POP CX
	  MOV BX,0FFFFH  
NEXT: DEC BX
      JNE NEXT
	  MOV AH,0   ;设置显示方式
	  MOV AL,0DH
	  INT 10H
	  LOOP LOP
	  MOV CX,158
LOP3: PUSH CX
      INC Y
      MOV DX,ROW  ;画上面横线
	  MOV CX,COL
	  dec cx
	  inc length
	  CALL PROC_X
	  dec length
	  MOV DX,ROW  ;画右边竖线
	  MOV CX,COL
	  ADD CX,LENGTH
	  CALL PROC_Y
	  MOV DX,ROW  ;画下面横线
	  MOV CX,COL
	  ADD DX,LENGTH
	  CALL PROC_X
	  MOV DX,ROW  ;画左边竖线
	  MOV CX,COL
	  CALL PROC_Y 
	  dec LENGTH
	  dec LENGTH
	  inc COL
	  inc ROW
	  POP CX
	  MOV BX,0FFFFH  
NEXT1:DEC BX
      JNE NEXT1	
      cmp cx,01h
	  jle l3	  
      MOV AH,0   ;设置显示方式
	  MOV AL,0DH
	  INT 10H
l3:   LOOP LOP3
	  MOV AH,1   ;输入
	  INT 21H
	  MOV AH,0
	  MOV AL,3
	  INT 21H
	  MOV AH,4CH  ;结束
	  INT 21H
PROC_X PROC    ;画横线子程序
	MOV BP,LENGTH   ;线长
LOP1:MOV BH,0       ;置页号
	 INC CX         ;修改列号 
	 MOV AL,COLOR   ;取像素值
	 MOV AH,0CH     ;写像素
	 INT 10H
	 DEC BP
	 JNE LOP1
	 RET
PROC_X ENDP
PROC_Y PROC         ;画竖线子程序
		MOV BP,LENGTH
LOP2:MOV BH,0
	 INC DX         ;修改列号
	 MOV AL,COLOR
	 MOV AH,0CH
	 INT 10H
	 DEC BP
	 JNE LOP2
	 RET
PROC_Y ENDP
	  
CODE ENDS
	END START
      