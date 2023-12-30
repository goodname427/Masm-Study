DATAS SEGMENT
    ;此处输入数据段代码  
    ;定义缓冲区
    BUFFER DB 5 ;最大字符长度
    	   DB ? ;实际字符的长度
    	   DB 5 DUP(0) ;存访开始输入的字符串
   	TEMP1 DB ?; 存放第一个输入的数
    TEMP2 DB ?; 存放第二个输入的数
    STRING1 DB 'please input the first number(0~99):',0DH,0AH,'$'
    STRING2 DB 0DH,0AH,'input  an  invalid  number, input again!',0DH,0AH,'$'
    STRING3 DB 0DH,0AH,'please input the second number(0~99):',0DH,0AH,'$'
    STRING4 DB 0DH,0AH,'Hexadecimal is',0DH,0AH,'$'
    STRING5 DB 0DH,0AH,'Binary is',0DH,0AH,'$'
    STRING6 DB 0DH,0AH,'Decimal is',0DH,0AH,'$'
    ; 0DH回车 0AH 换行 '$'结尾字符
DATAS ENDS

STACKS SEGMENT
    ;此处输入堆栈段代码
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS;将dates数据段地址送往DS寄存器
    MOV DS,AX
    ;此处输入代码段代码
    
    MOV DX,OFFSET STRING1;输出string1字符串	
    ; DX为字符串的偏移地址
	JMP START1
START2:    
    MOV DX,OFFSET STRING2;输出sting2字符串
START1:
    MOV AH,09H
    INT 21H 
    
    MOV DX,OFFSET BUFFER; 输入第一个数
    MOV AH,0AH
    INT 21H
    
 	MOV AL,BUFFER[1] ; 长度大于2肯定不合理
   	CMP AL,02H
   	JA START2
   	
   	MOV AL,BUFFER[2]; 第一个字符必须为'0'~'9'
   	CMP AL,'0'
   	JB START2
   	CMP AL,'9'
   	JA START2

	MOV AL,BUFFER[1]; 长度为1则不要继续判断
	CMP AL,01H
	JE START3

   	MOV AL,BUFFER[3];第二个字符必须为'0'~'9'
   	CMP AL,'0'
   	JB START2
   	CMP AL,'9'
   	JA START2
   	JMP START4
START3:; 一位数
	SUB BUFFER[2],'0';减去'0'
	MOV AL,BUFFER[2]
	MOV TEMP1,AL
	JMP OP1
START4:; 二位数
	SUB BUFFER[2],'0'
	SUB BUFFER[3],'0'
	MOV AL,BUFFER[2]
	MOV BL,10D
	MUL BL
	ADD AL,BUFFER[3];(buffer[2]-'0')*10D+buffer[3]
   	MOV TEMP1,AL

OP1:   	
   	 
 	MOV DX,OFFSET STRING3
	JMP START5
START6:    
    MOV DX,OFFSET STRING2
START5:
    MOV AH,09H
    INT 21H
    
    MOV DX,OFFSET BUFFER
    MOV AH,0AH
    INT 21H
    
 	MOV AL,BUFFER[1] ; 长度大于2肯定不合理
   	CMP AL,02H
   	JA START6
   	
   	MOV AL,BUFFER[2]
   	CMP AL,'0'
   	JB START6
   	CMP AL,'9'
   	JA START6

	MOV AL,BUFFER[1]; 长度为1则不要继续判断
	CMP AL,01H
	JE START7

   	MOV AL,BUFFER[3]
   	CMP AL,'0'
   	JB START6
   	CMP AL,'9'
   	JA START6
   	JMP START8
   	
START7:; 一位数
	SUB BUFFER[2],'0'
	MOV AL,BUFFER[2]
	MOV TEMP2,AL
	JMP OP2
START8:;两位数
	SUB BUFFER[2],'0'
	SUB BUFFER[3],'0'
	MOV AL,BUFFER[2]
	MOV BL,10D
	MUL BL
	ADD AL,BUFFER[3]
   	MOV TEMP2,AL
OP2:   
   	; 相乘
   	MOV AL,TEMP1
   	MOV BL,TEMP2
   	MUL BL
   	MOV BX,AX; 最后结果存BX
   	
   	MOV DX,OFFSET STRING4; 十六进制调用函数
   	MOV AH,09H
   	INT 21H 
   	CALL PR1
   	
  	MOV DX,OFFSET STRING5; 二进制调用函数
   	MOV AH,09H
   	INT 21H 
   	CALL PR2
   	
   	MOV DX,OFFSET STRING6; 十进制调用函数
   	MOV AH,09H
   	INT 21H 
   	CALL PR3
   	
    MOV AH,4CH
    INT 21H
    

PR1 PROC 
	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
	
    MOV CX,04D;最多四位数
	MOV	AX,0F000H;与1111 0000 0000 0000 AND
AGAIN1:
   	MOV DX,BX
   	AND DX,AX
   	SHR AX,01D;每次AX右移4位
   	SHR AX,01D
   	SHR AX,01D
   	SHR AX,01D
   	JMP CHU1
CHU2:
	SHR DX,01D
	SHR DX,01D
	SHR DX,01D
	SHR DX,01D    
CHU1:
   	CMP DX,0FH;如果答案大于0FH，则右移4位，本质是把位数移到最后四位
    JA CHU2
    
    PUSH AX;保护AX值
    
    ADD DL,'0'
    CMP DL,'9'
    JA ASC
    
    JMP NUM
ASC	:;字母
    ADD DL,07H
NUM :; 数字
    MOV AH,02H
    INT 21H
    
	POP AX
	
    LOOP AGAIN1
    
    POP DX
	POP CX
	POP BX
	POP AX
    RET
PR1 ENDP
 
 
PR2 PROC; 二进制函数
	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
	
    MOV CX,16D;最多16位数
	MOV	AX,08000H;以0001 0000 0000 0000 为起点
AGAIN2:
   	MOV DX,BX
   	AND DX,AX
   	SHR AX,01D;每次右移一位
   	JMP CHU3
CHU4:
	SHR DX,01D  
CHU3:
   	CMP DX,01H;让答案移动最后一位
    JA CHU4
    
    PUSH AX;保留AX值
    
    ADD DL,'0'
    MOV AH,02H
    INT 21H
    
	POP AX;与pop对应
	
    LOOP AGAIN2
    
    POP DX
	POP CX
	POP BX
	POP AX
	RET
PR2 ENDP

PR3 PROC; 十进制函数
	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
	
	MOV AX,BX
	MOV BX,10D
	MOV DX,0D
	MOV CX,04H
	
; 把所有位数放入堆栈
AGAIN3 : ;最多四位数，所以循环四次
	DIV BX; 每次除10
	PUSH DX; 答案放入堆栈
	MOV DX,0 ;使得DX.AX中的DX清空
	LOOP AGAIN3
	
; 把所有位数压出堆栈输出
	MOV CX,04H
AGAIN4 : 	
  	POP DX
  	ADD DL,'0';加上'0'的ascii码
  	MOV AH,02H
  	INT 21H
  	lOOP AGAIN4
 
    POP DX
	POP CX
	POP BX
	POP AX
	RET
PR3 ENDP 

CODES ENDS
    END START 
