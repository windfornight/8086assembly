assume cs:code


code segment

	start:
	mov ax, 4240h
	mov dx, 000fh
	mov cx, 0ah
	call divdw
	
	mov ax, 4c00h
	int 21h
	
	;������dword�� ����word
	;ax��16λ�� dx��16λ�� cx����
	;����:dx = �����16λ�� ax = �����16λ�� cx����
	divdw:
	push bx

	mov bx, ax
	mov ax, dx
	mov dx, 0
	div cx
	push ax 
	mov ax, bx
	div cx
	mov cx, dx 
	pop dx
	
	pop bx
	ret
	
code ends


end start