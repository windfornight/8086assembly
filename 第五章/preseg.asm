assume cs:codesg

codesg segment
	
	mov ax, 2000H
	mov ds, ax
	mov bx, 0aH
	mov ax, 8989H
	mov [bx], ax
	mov ax, 3000H
	mov es, ax
	mov ax, 6767H
	add [bx], ax
	mov es:[0], ax
	mov ax, [bx]
	
	
	
	mov ax, 4c00H
	int 21H

codesg ends

end