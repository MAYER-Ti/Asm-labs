;%macro mPrintString 1
;    ; Вывод строки (длина вычисляется автоматически)
;    xor rdx, rdx        ; Обнуляем длину строки
;    mov rsi, %1         ; Адрес строки
;    xor rax, rax        ; Сбрасываем регистр
;%%calculate_length:
;    mov al, byte [rsi + rdx]
;    cmp al, 0           ; Ищем конец строки (нулевой байт)
;    je %%print_now
;    inc rdx             ; Увеличиваем длину
;    jmp %%calculate_length
;%%print_now:
;    mov rax, 1          ; syscall write
;    mov rdi, 1          ; stdout
;    syscall
;%endmacro

%macro mPrintString 2
    ; Вывод строки на экран с указанием длины
    ; %1 - адрес строки
    ; %2 - длина строки

    mov rax, 1            ; syscall номер 1 - write
    mov rdi, 1            ; file descriptor 1 (stdout)
    mov rsi, %1           ; Адрес строки
    mov rdx, %2           ; Длина строки
    syscall               ; вызываем системный вызов для вывода
%endmacro


%macro mInputString 2
    ; Чтение строки
    mov rax, 0          ; syscall read
    mov rdi, 0          ; stdin
    mov rsi, %1         ; адрес буфера
    mov rdx, %2         ; максимальная длина
    syscall
%endmacro

%macro mTrimString 1
    ; Удаление символа новой строки ('\n') из конца строки
    mov rsi, %1
    xor rax, rax
%%trim_loop:
    lodsb
    cmp al, 0xA         ; проверка на '\n'
    je %%trim_remove
    cmp al, 0
    je %%trim_end
    jmp %%trim_loop
%%trim_remove:
    dec rsi
    mov byte [rsi], 0
%%trim_end:
%endmacro
