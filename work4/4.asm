DATAS SEGMENT
    ;�˴��������ݶδ���  
	prompt db "input number (1-3):",0dh,0ah,'$'
	chapter1 db 'chapter1:introduction',0dh,0ah,'$'
	chapter2 db 'chapter2:designing method',0dh,0ah,'$'
	chapter3 db 'chapter3:experiment',0dh,0ah,'$'
	endl db 0dh,0ah,'$'
	table db 3 dup(?)
DATAS ENDS

STACKS SEGMENT
    ;�˴������ջ�δ���
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    ;�˴��������δ���
	;���ʼ��
	LEA BX,table
	MOV [BX],OFFSET chapter1
	INC BX
	MOV [BX],OFFSET chapter2
	INC BX
	MOV [BX],OFFSET chapter3
	
	;��ʾ
INPUT_PROMPT:
    MOV AH,09H
    LEA DX,prompt
    INT 21H
    
    ;����
    MOV AH,01H
    INT 21H
    
    SUB AL,'0'
    ;�߽��ж�
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
