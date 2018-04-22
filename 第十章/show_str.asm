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
	
;dh �кţ� dl�к�
;cl  ��ɫ   BL(��˸)  RGB(����)  I(����)  RGB��ǰ����	
;ds:siָ���ַ����׵�ַ
show_str:
	push cx
	push bx
	push es
	push ax
	push dx

	;�к�
	mov ax, 2
	mul dl
	mov bx, ax
	
	;�кţ����dxΪ0
	mov ax, 160
	mul dh
	
	;��һ���ַ��ĵ�ַ
	add bx, ax
	
	;�Դ�ε�ַ
	mov ax, 0b800h
	mov es, ax
	
	;��ɫ���ֱ���
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