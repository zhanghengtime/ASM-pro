DATA SEGMENT
	STR1 DB '0123456789ABCDEFGH'
	STR2 DB '0123456789ABCDEFGH'
	COUNT EQU $-STR2
	TIP1 DB 'equal$'
	TIP2 DB 'inequal$'
	FLAG DB ?
DATA ENDS

CODE SEGMENT 
	ASSUME CS:CODE,DS:DATA,ES:DATA
START:	MOV AX,DATA
		MOV DS,AX
		MOV ES,AX
		LEA SI,STR1  ;取源串首地址
		LEA DI,STR2  ;取目的串首地址
		MOV CX,COUNT ;确定循环次数
		MOV AL,0
		CLD  ;DF置0
		REPZ CMPSB  ;重复比较
		JZ EXIT
		MOV AL,09H
EXIT:   MOV FLAG,AL
		CMP FLAG,0
		JZ L1
		LEA DX,TIP2 ;输出提示
		MOV AH,09H
		INT 21H
		JMP L2
L1:     LEA DX,TIP1 ;输出提示
        MOV AH,09H
		INT 21H
L2:		MOV AH,4CH
		INT 21H
CODE ENDS
	END START
		