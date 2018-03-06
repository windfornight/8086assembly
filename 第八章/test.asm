assume cs:code

data segment

	db '1975', '1976', '1977', '1978', '1979', '1980', '1981', '1982', '1983'
	db '1984', '1985', '1986', '1987', '1988', '1989', '1990', '1991', '1992'
	db '1993', '1994', '1995'
		;21年的21个字符串
		;21*4
	
	dd 16, 22, 382, 1356, 2390, 8000, 16000, 24486, 50065, 97479, 140417, 197514
	dd 345980, 590827, 803530, 1183000, 1843000, 2759000, 3753000, 4649000, 5937000
		;21 *4 收入
		
	dw 3, 7, 9, 13, 28, 38, 130, 220, 476, 778, 1001, 1442, 2258, 2793, 4037, 5635, 8226
	dw 11542, 14430, 15257, 17800
		;21*2 人数
		
data ends

table segment
	db 21 dup('year summ ne ?? ')
table ends

code segment
	start:mov ax, data
	mov ds, ax
	
	mov ax, table
	mov ss, ax
	
	mov cx, 21
	mov bx, 0
	mov si, 0
	mov di, 0
	mov bp, 0



	;段前缀的用法
	s:mov dx, cx
	mov cx, 4
	
	;年份
	s0:mov al, [bx]
	mov ss:[bp], al
	inc bx	
	inc bp
	loop s0
	
	inc bp
	mov cx, dx
		
	;收入
	mov ax, [84+si]
	inc si
	inc si
	mov dx, [84+si]
	inc si
	inc si
	
	mov ss:[bp], ax
	inc bp
	inc bp
	mov ss:[bp], dx
	inc bp
	inc bp
	
	inc bp
	
	;平均
	div word ptr ds:[168+di]
	
	;人数
	mov dx, ds:[di+168]
	mov ss:[bp], dx
	inc bp
	inc bp
	
	inc bp
	
	;平均
	mov ss:[bp], ax
	inc bp 
	inc bp
	
	inc di
	inc di
	
	inc bp
	
	loop s
	
	mov ax, 4c00h
	int 21h
	
code ends

end start