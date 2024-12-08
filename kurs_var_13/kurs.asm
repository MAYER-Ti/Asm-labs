.model	tiny
.stack	100h
.data
   input_msg db 13,10,'Введите фаимлию: ',13,10, '$'
   msg_nom db '???? ', 0           ; Именительный
   msg_gen db '??? ', 0            ; Родительный
   msg_dat db '???? ', 0           ; Дательный
   msg_acc db '???? ', 0           ; Винительный
   msg_inst db '? ', 0             ; Творительный
   msg_prep db '? ', 0             ; Предложный
   newline db 0Dh, 0Ah, '$'        ; Символы новой строки

   buffer db 50 dup(0)             ; Буфер для ввода фамилии
   output_buffer db 50 dup(0)         ; Буфер для вывода результата

.code
;.286

mPrintString macro string
   mov dx, offset string
   mov ah, 09h
   int 21h
endm

mInputString macro string
   lea dx, string
   mov ah, 0Ah
   int 21h
endm

start:
   mov ax, @data
   mov ds, ax
   xor ax, ax

   mPrintString input_msg
   ;mInputString buffer
   

   mov ax, 4c00h
   int 21h
end	start