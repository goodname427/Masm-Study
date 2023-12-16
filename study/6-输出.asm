OUTP PROC
    PUSH AX
    PUSH DX
    PUSH CX

LOOP3:
    PUSH DX
    
    ; 计算最低位的ascii码值
    AND DX,01H
    ADD DX,'0'
    
    ; 输出部分
    MOV AH,02H
    INT 21H

    POP DX
    SHR DX,1
    MOV CX,DX
    INC CX
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