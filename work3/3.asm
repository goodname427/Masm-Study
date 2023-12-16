DATAS SEGMENT
     ascii db 30h,31h,32h,33h,34h,35h,36h,37h,38h,39h,41h,42h,43h,44h,45h,46h,47h,48h,49h,50h,51h,52h,53h,54h,55h,56h
       hex db 5dh
DATAS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS
START:
    MOV AX,DATAS
    MOV DS,AX
    mov bx,offset ascii
    mov al,hex
    and al,0fh
    xlat
    mov dl,al
    mov ah,02h
    int 21h
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START
