data segment
		le1 db ?
		le2 db 2
data ends
code segment
	assume ds:data,cs:code
start:	mov ax,data
	
		mov ds,ax

		mov ah,0
		mov al,12H
		int 10H
		
		mov cx,100
lop1:	mov le1,cl
		mov cl,le2
		
		mov bh,0
		mov dx,10
		mov al,1
		mov ah,0cH
		int 10H
		inc cl
		mov le2,cl
		mov cl,le1
		loop lop1
		 MOV AH,0
	
	 INT 21H
		mov ah,4CH
		int 21H
code ends
	end start