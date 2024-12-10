.model  small
.stack  100h

.data
   open_err_msg db 'Error opening file!$'
   read_err_msg db 'Error reading file!$'
   newline db 0Dh, 0Ah, '$'
   input_msg DB "Print order rows: ",'$'
   fileName db 'input.txt', '$'           ; ??? ????? (ASCIIZ)
   fileHandle dw ?                     ; ?????????? ?????
   char       db '&'
   onEndFile db 0
   bufferChar db 0              ; ????? ??? ???????
   bufferRows dw 100 dup(?)
   countRows dw 0
   tempAddr dw 0
   ;;bytesRead dw 0                      ; ?????????? ??????????? ????

.code

include macro.inc



start:

   mov ax, @data
   mov ds, ax
   mov es, ax


   mReadFile fileName, fileHandle, bufferRows, countRows
   
   mPrintSpFile bufferRows, countRows
 ;  mPrintChar [si+1]
 ;  mPrintChar [si+2]
 ;  mPrintChar [si+3]
 ;  mPrintChar [si+4]
 ;  mPrintChar [si+5]
 ;  mPrintString input_msg
 ;  mPrintString newline




  mEndFile
end start