DATAS SEGMENT
    ;此处输入数据段代码
	a DB 1
	b DW 2 
	a1 DD 3
	PI EQU 3.14159
	d EQU $-a
	num1 DB 3
	num2 DB 5
	num3 DB ?
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
    MOV AL, num1
    ADD AL, num2
    MOV num3, AL
    MOV a, d
    ;
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START


