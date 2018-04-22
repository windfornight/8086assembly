assume cs:codesg

data segment
	db 'Welcome to masm!', 0
data ends

codesg segment
start:
	mov dh, 8
	mov dl, 3
	mov cl, 2
	mov ax, data
	mov ds, ax
	mov si, 0
	call show_str
	
	mov ax, 4c00h
	int 21h
	
;dh 行号， dl列号
;cl  颜色   BL(闪烁)  RGB(背景)  I(高亮)  RGB（前景）	
;ds:si指向字符串首地址
show_str:
	push cx
	push bx
	push es
	push ax
	push dx

	;列号
	mov ax, 2
	mul dl
	mov bx, ax
	
	;行号，结果dx为0
	mov ax, 160
	mul dh
	
	;第一个字符的地址
	add bx, ax
	
	;显存段地址
	mov ax, 0b800h
	mov es, ax
	
	;颜色部分保存
	mov al, cl	
strLoop:
	mov ch, 0
	mov cl, ds:[si] 
	
jcxz strEnd
	mov ch, al	
	mov es:[bx], cx	
	inc si	
	add bx, 2
loop strLoop
		
strEnd:
	pop dx 
	pop ax
	pop es
	pop bx
	pop cx
	ret
	
codesg ends

end start