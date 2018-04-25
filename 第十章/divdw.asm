assume cs:code


code segment

	start:
	mov ax, 4240h
	mov dx, 000fh
	mov cx, 0ah
	call divdw
	
	mov ax, 4c00h
	int 21h
	
	;被除数dword， 除数word
	;ax低16位， dx高16位， cx除数
	;返回:dx = 结果高16位， ax = 结果低16位， cx余数
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