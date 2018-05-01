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
	
	
;将word型数据转变为表示十进制数的字符串，字符串以0结束
;参数：ax = word型数据    ds:si指向字符串的首地址
dtoc:
	push si
	push bx
	push dx
	
	mov bx, 0
	
;入栈（转化为字符串的整数）
numSplit:
	inc bx
	mov dx, 0
	mov cx, 10
	call divdw
	add cx, 30h
	push cx
	mov cx, ax
	jcxz numToStr   ;为什么丢掉了1
	loop numSplit

;出栈
numToStr:
	pop cx
	mov ds:[si], cl
	dec bx
	inc si
	mov cx, bx
	inc cx ;特别注意+1的定义
	loop numToStr
	
	;字符串结尾
	mov byte ptr ds:[si], 0
	
	pop dx 
	pop bx
	pop si
		
	ret

code ends

end start 