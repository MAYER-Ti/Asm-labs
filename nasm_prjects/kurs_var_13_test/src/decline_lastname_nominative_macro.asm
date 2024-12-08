%macro DECLINE_NOMINATIVE 2
    mov rsi, %1          ; Адрес исходной строки
    mov rdi, %2          ; Адрес буфера результата
    call copy_string      ; Копируем строку без изменений
%endmacro

