DOSSEG
.model	small
.stack	100h

; === Вывод строки ===
mWrite macro message
   mov ah, 09h
   lea dx, message
   int 21h
endm

; === Вывод строки с переводом каретки ===
mWriteln macro message
   mov ah, 09h
   lea dx, message
   int 21h
   lea dx, newline
   int 21h 
endm

mInput macro buf
   lea dx, buf
   mov ah, 0Ah
   int 21h 
endm

; === Завершение работы программы ===
EndProgram macro
   mov ax,4c00h
   int 21h
endm

.data
   ; Глобальные сообщения
    msg_enter db 'Введите фамилию:', 13, 10, '$'
    msg_nom db 'Есть ', 13, 10, '$'           ; Именительный падеж
    msg_gen db 'Нет ', 13, 10, '$'            ; Родительный падеж
    msg_dat db 'Дать ', 13, 10, '$'           ; Дательный падеж
    msg_acc db 'Вижу ', 13, 10, '$'           ; Винительный падеж
    msg_inst db 'С ', 13, 10, '$'            ; Творительный падеж
    msg_prep db 'О ', 13, 10, '$'             ; Предложный падеж
    newline db 0Dh, 0Ah, '$'

    ; Буфферы для работы
    buffer db 30 dup(0)             ; Буффер для ввода фамилии
    output_buffer db 50 dup(0)      ; Буффер для вывода результа
.code

start:
   mov ax,@data
   mov ds,ax
   xor ax,ax

   mWriteln msg_enter
   mInput buffer
EndProgram
end	start