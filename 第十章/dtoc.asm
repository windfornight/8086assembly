assume cs:code

data segment
	db 10 dup (0)
data ends

code segment
start:
	mov ax, 12666
	mov bx, data
	mov ds, bx
	mov si, 0
	call dtoc
	
	mov dh, 8
	mov dl, 3
	mov cl, 2
	call show_str
	
	mov ax, 22666
	mov bx, data
	mov ds, bx
	mov si, 0
	call dtoc
	
	mov dh, 9
	mov dl, 3
	mov cl, 2
	call show_str
	
	
	
	mov ax, 4c00h
	int 21h
	
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
	
	
;��word������ת��Ϊ��ʾʮ���������ַ������ַ�����0����
;������ax = word������    ds:siָ���ַ������׵�ַ
dtoc:
	push si
	push bx
	push dx
	
	mov bx, 0
	
;��ջ��ת��Ϊ�ַ�����������
numSplit:
	inc bx
	mov dx, 0
	mov cx, 10
	call divdw
	add cx, 30h
	push cx
	mov cx, ax
	jcxz numToStr   ;Ϊʲô������1
	loop numSplit

;��ջ
numToStr:
	pop cx
	mov ds:[si], cl
	dec bx
	inc si
	mov cx, bx
	inc cx ;�ر�ע��+1�Ķ���
	loop numToStr
	
	;�ַ�����β
	mov byte ptr ds:[si], 0
	
	pop dx 
	pop bx
	pop si
		
	ret

code ends

end start 