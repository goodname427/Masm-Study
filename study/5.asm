DATAS SEGMENT
    MAXLEN DB 100
    LEN DB ?
    STRING DB 100 DUP(?)
    ENDL DB 0AH,0DH,'$'
DATAS ENDS

STACKS SEGMENT
    
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    
    ; 输入
    MOV DX,OFFSET MAXLEN
    MOV AH,10
    INT 21H

    ; 大小写转换
    MOV BX,OFFSET STRING
    MOV CH,0
    MOV CL,LEN
LOOP_MAIN:
    MOV AX,20H
    TEST AX,[BX]
    JNZ LOOP_COTINUE
    XOR AX,[BX]
    MOV [BX],AX
LOOP_COTINUE:
    INC BX
    LOOP LOOP_MAIN
    
    ;补上结尾标志
    MOV [BX],'$'
    
    ;输出
    MOV DX,OFFSET ENDL
    MOV AH,9
    INT 21H

    MOV DX,OFFSET STRING
    MOV AH,9
    INT 21H

    MOV AH,4CH
    INT 21H
CODES ENDS

END START