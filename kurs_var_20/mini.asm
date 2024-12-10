.model  small
.stack  100h

.data
   newline db 0Dh, 0Ah, '$'
   input_msg db "Print order rows: ", 0Dh, 0Ah,'$'
   error_msg db "Invalid input! example: 13245", 0Dh, 0Ah,'$' 
   rows  db "1) sample row1 to example text", 0Dh, 0Ah, '$'
         db "2) row2 example text          ", 0Dh, 0Ah, '$'
         db "3) text for example row3      ", 0Dh, 0Ah, '$'
         db "4) example text for row4      ", 0Dh, 0Ah, '$'
         db "5) last row5 for example text ", 0Dh, 0Ah, '$'

   row_len equ 33
   buffer db "00000", '$'
.code

include macro.inc



start:

   mov ax, @data
   mov ds, ax
   mov es, ax
   
startProgram:
   
;   mov cx, 5
;   mov al, 1
;loopPrintRows:
   
;   mov bl, row_len
;   mul bl
   
   ;mov bl, al
;   mov bx, ax
  
;   mPrintString rows[bx]

;   add al, 1
;   loop loopPrintRows
   
   mPrintString rows[0]
   mPrintString rows[33]
   mPrintString rows[66]
   mPrintString rows[99]
   mPrintString rows[132]
   
  ; mPrintString row2
  ; mPrintString row3
  ; mPrintString row4
  ; mPrintString row5
  ; mPrintString newline
   
   mPrintString input_msg
   mInputString buffer
   mPrintString newline

   mov al, buffer[1]
   xor ah, ah
   mov cx, ax
   lea si, buffer
   
loopBuf:
   mov al, [si+2]
   cmp al, '0'
   jl error
   cmp al, '5'
   jg error
   
   mPrintChar al
  
;   mov al, buffer[1]
;   xor ah, ah
;   mov cx, ax
;   lea si, buffer
   
;loopBufPrint:
;   mov al, [si+2]


   sub al, 30h
   sub al, 1
   mov bl, row_len
;   mul bl
   
;   lea bx, rows
;   mov di, ax
  
;   mov dx, [bx+di]
;   mov ah, 09h
;   xor al, al
;   int 21h
    
   
;   add si, 1
;   loop loopBuf
   
   ;jmp correctInput
   jmp startProgram
   
error:
   mPrintString error_msg
   jmp startProgram
   



;   loop loopBufPrint   

  
   
endProgram:
  mEndFile
end start