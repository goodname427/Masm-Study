DATAS SEGMENT
    ARR DB 35H,78H,25H,0A3H,8H,42H
    LEN EQU $-ARR
    ENDL DB 0AH,0DH,'$'
DATAS ENDS

STACKS SEGMENT
    
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    
    LEA BX,ARR
    MOV CX,LEN
    DEC CX
LOOP1:
    ;外层循环
    PUSH CX
    MOV SI, 0
LOOP2:
    ; 内层循环
    ;比较i和i+1位置元素的大小,如果i位置元素大则交换位置
    MOV AL, [BX + SI]
    CMP AL, [BX + SI + 1]
    JL LOOP2END
    XCHG AL, [BX + SI + 1]
    MOV [BX + SI], AL
LOOP2END:
    INC SI
    LOOP LOOP2

    POP CX
    LOOP LOOP1

    MOV DL, [BX + LEN - 1]
    CALL OUTP

    MOV AH,4CH
    INT 21H

OUTP PROC
    PUSH AX
    PUSH DX
    PUSH CX

    MOV CX,8
LOOP3:
    PUSH DX
    
    ; 计算最高位的ascii码值
    TEST DL,80H
    MOV DL,'0'
    JZ OUTINT
    INC DL
OUTINT:
    ; 输出部分
    MOV AH,02H
    INT 21H

    POP DX
    SHL DL,1
    LOOP LOOP3

    ;换行
    CALL LINE

    POP CX
    POP DX
    POP AX
    RET
OUTP ENDP

LINE PROC
    PUSH AX
    PUSH DX

    LEA DX,ENDL
    MOV AH,9
    INT 21H

    POP DX
    POP AX
    RET
LINE ENDP

CODES ENDS

END START