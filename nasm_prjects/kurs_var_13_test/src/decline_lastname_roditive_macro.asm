%macro DECLINE_GENITIVE 2
    mov rsi, %1          ; Адрес исходной строки
    mov rdi, %2          ; Адрес результата
    call copy_string     ; Копируем строку
    
    ; Применяем правила для UTF-8
    sub rdi, 2           ; Указатель на последний символ (слово UTF-8)

    ; Проверяем последний символ на 'й' (UTF-8: D0 B9)
    mov ax, word [rdi]
    cmp ax, 0xB9D0       ; Проверка на 'й'
    je %%replace_y_with_ya

    ; Проверяем последний символ на 'е' (UTF-8: D0 B5)
    cmp ax, 0xB5D0       ; Проверка на 'е'
    je %%replace_y_with_ya

    ; Проверяем предпоследний символ для добавления 'а'
    sub rdi, 2           ; Переходим к предпоследнему символу
    mov ax, word [rdi]
    cmp ax, 0xBED0       ; 'о' (UTF-8: D0 BE)
    je %%append_a
    cmp ax, 0xB5D0       ; 'е' (UTF-8: D0 B5)
    je %%append_a
    cmp ax, 0xB8D0       ; 'и' (UTF-8: D0 B8)
    je %%append_a
    jmp %%done

%%replace_y_with_ya:
    ; Меняем последний символ на 'я' (UTF-8: D1 8F)
    mov word [rdi], 0x8FD1
    jmp %%done

%%append_a:
    ; Добавляем 'а' (UTF-8: D0 B0)
    add rdi, 2
    mov word [rdi], 0xB0D0    ; Первый байт UTF-8 для 'а'
    mov byte [rdi + 2], 0      ; Завершающий нуль
%%done: 
%endmacro

