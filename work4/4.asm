DATAS SEGMENT
    ;此处输入数据段代码  
	prompt db "input number (1-3):",0dh,0ah,'$'
	chapter1 db 'chapter1:introduction',0dh,0ah,'$'
	chapter2 db 'chapter2:designing method',0dh,0ah,'$'
	chapter3 db 'chapter3:experiment',0dh,0ah,'$'
	endl db 0dh,0ah,'$'
	table db 3 dup(?)
DATAS ENDS

STACKS SEGMENT
    ;此处输入堆栈段代码
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    ;此处输入代码段代码
	;表初始化
	LEA BX,table
	MOV [BX],OFFSET chapter1
	INC BX
	MOV [BX],OFFSET chapter2
	INC BX
	MOV [BX],OFFSET chapter3
	
	;提示
INPUT_PROMPT:
    MOV AH,09H
    LEA DX,prompt
    INT 21H
    
    ;输入
    MOV AH,01H
    INT 21H
    
    SUB AL,'0'
    ;边界判断
    CMP AL,1
    JL INPUT_PROMPT
    CMP AL,3
    JG INPUT_PROMPT
    
    MOV AH,0
    MOV SI, AX
    LEA BX, table
    MOV DX,[BX+SI]
    
    MOV AH,09H
    INT 21H
    
EXIT:
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START
