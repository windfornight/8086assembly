assume cs:code

;复制"mov ax, 4c00h"之前的指令 到 0:200

code segment
	
	mov ax, code  ;开始的位置
	mov ds, ax
	mov ax, 0020H
	mov es, ax
	mov bx, 0
	mov cx, 18h

	s:mov al, [bx]
	mov es:[bx], al ;20:bx
	inc bx
	loop s

	mov ax, 4c00h
	int 21h

code ends

end