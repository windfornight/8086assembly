assume cs:code

;向内存0：200-0：23f一次传入数据0-63（3fH）
code segment

	mov ax, 20H
	mov ds, ax
	mov bx, 0H
	mov cx, 40H
	s:	mov [bx], bl
		inc bx
	loop s
	
	mov ax, 4c00H
	int 21H

code ends

end