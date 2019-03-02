DATA SEGMENT
	TIP1 DB 'please input a number: $'
	TIP2 DB 'please input p: $'
	ARRAY DB 5 DUP(0)
	C1 DB 0
	NUM DW 0
	RES DB 16 DUP(0)
	C2 DB 0
DATA ENDS

CODE SEGMENT
	ASSUME DS:DATA,CS:CODE
START:	MOV AX,DATA
		MOV DS,AX
		LEA DX,TIP1  
        MOV AH,09H
        INT 21H	   
		MOV SI,0
		
L1: 	MOV AH,1
     	INT 21H
		CMP AL,39h
		Jg L2
		cmp al,30h
		jl l2
		MOV ARRAY[SI],AL
		MOV CX,2
		INC SI
		LOOP L1
		
L2:     MOV AX,0
		MOV SI,0
		MOV CH,0
		MOV CL,4
		
L3:		SUB ARRAY[SI],30H
	MUL DI
	ADD AL,ARRAY[SI]
	ADD AH,0
	INC SI
	LOOP L3
	MOV NUM,AX
	MOV DL,0AH        
	MOV AH,2
	INT 21H
	MOV DL,0DH
	MOV AH,2
	INT 21H
	LEA DX,TIP2
	MOV AH,9
	INT 21H
	MOV AH,1
	INT 21H
	CMP AL,39H
	JBE L4
	SUB AL,07H
        ;MOV BL,ARRAY[SI]
		;SUB BL,30H
		;MOV DI,10
		;MUL DI
		;ADD AL,BL
		;ADC AH,0
		;INC SI
		;LOOP L3
		
	    MOV NUM,AX
		MOV AH,02H
		MOV DL,0DH
		INT 21H
		MOV DL,0AH
		INT 21H
		LEA DX,TIP2
		MOV AH,9
		INT 21H
		MOV AH,1
		INT 21H
		CMP AL,09H
		JLE L4
		SUB AL,7
		
L4:     SUB AL,30H
		MOV BL,AL
		MOV BH,0
		MOV SI,0
		MOV AX,NUM

	;MOV DX,0
		;DIV Bx
		;push ax
	;	;MOV RES[SI],DL
		;mov ah,02h
		;add dl,30h
		;int 21h
		;INC SI
		;pop ax
	;	mov dl,al
		;and dl,0fh
		;mov cl,4
		;;shr dl,cl
		;add dl,30h
		;;mov ah,02h
		;int 21h
L5:MOV DX,0
	DIV BX
	MOV RES[SI],DL
	;INC C2
	INC SI
	CMP AX,0
	JNE L5
	DEC SI
	MOV CX,7
L6: MOV DL,RES[SI]
	CMP DL,9
	JBE L7
	ADD DL,7
L7:
	ADD DL,30H
	MOV AH,2
	INT 21H
	DEC SI
	LOOP L6
	MOV AH,4CH
	INT 21H
	;	loop l5
		;CMP AL,0
		;mov cx,1
		;Jz l7
		;MOV CX,7
		
;L7:    ; DEC SI
		;MOV DL,RES[SI]
	    ;CMP DL,9
		;JLE L6
		;ADD DL,7
		
;L6:     ;ADD DL,30H
		;MOV AH,02H
		;INT 21H
		;;LOOP L7
		;MOV AH,4CH
		;INT 21H
CODE ENDS
END START
		