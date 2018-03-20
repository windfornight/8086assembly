assume cs:codesg, ds:datasg

datasg segment 
	db 'welcome to masm!'
	db 10b, 100100b, 1110001b
datasg ends

;bL rgb i rgb
;0000 0010b 绿色
;0010 0100b 绿底红色
;0111 0001b 白底蓝色
;b8000 - bffff 32kb  8页 每页80*25, 4kb空间

codesg segment
	start: mov ax, datasg
	mov ds, ax
	mov cx, 3
	mov bp, 0
	mov ax, 0b800h
	mov es, ax
	mov bx, 64
	
	s:
	mov dx, cx 
	mov si, 0
	mov di, 0
	mov cx, 16 
	mov ah, ds:[16+bp]
		s1:
		mov al, ds:[si]
		mov es:[bx+di], ax
		inc si
		add di, 2
		loop s1 
	mov cx, dx	
	add bx, 160
	inc bp
	
	loop s

	mov ax, 4c00h
	int 21h
codesg ends

end start