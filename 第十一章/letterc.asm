assume cs:code

data segment
	db "Beginner's All-purpose Symbolic Instruction Code.", 0
data ends

code segment
	start: 
		mov ax, data
		mov ds, ax
		mov si, 0
		call letterc
		
		mov ax, 4c00h
		int 21h
	
	;将以0结尾的字符串中的小写字母转变为大写字母
	;参数：ds:si指向字符串的首地址
	letterc:
		push cx 
		
		mov cx, 0
		
		getChar:
		mov cl, ds:[si]
		
		cmp cl, 'a'
		jb dealedChar
		cmp cl, 'z'
		ja dealedChar
		sub cl, 'a'
		add cl, 'A'
		mov ds:[si], cl
		
		dealedChar:
		jcxz charEnd
		mov cl, 2
		inc si 
		loop getChar
		
		charEnd:
		pop ax 
		ret
		

code ends

end start