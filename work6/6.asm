DATA SEGMENT
BUF DB 01H,25H,38H,62H,8DH,9AH,0BAH,0CEH
N DW $-BUF
X DW 0
DATA ENDS
CODE SEGMENT
   ASSUME CS:CODE,DS:DATA
START: MOV AX,DATA
       MOV DS,AX
       MOV CX,N
BE:    MOV N,CX
       MOV BX,X
 
       MOV DL,BUF[BX]
       INC BX
       MOV X,BX
       CALL DELY
       MOV CX,N
       CMP CX,1
       JE FINISH
       MOV DL,','
       MOV AH,2
       INT 21H
       LOOP BE
FINISH:MOV AX,4C00H
       INT 21H
 
DELY   PROC NEAR
       MOV BL,DL
       MOV CL,4
       SHR DL,CL
       OR DL,30H
       CMP DL,39H
       JBE AD1
       ADD DL,7
AD1:   MOV AH,2
       INT 21H
       MOV DL,BL
       AND DL,0FH
       OR DL,30H
       CMP DL,39H
       JBE AD2
       ADD DL,7
AD2:   MOV AH,2
       INT 21H
       MOV DL,'H'
       MOV AH,2
       INT 21H
       RET
DELY ENDP
CODE ENDS
     END START
