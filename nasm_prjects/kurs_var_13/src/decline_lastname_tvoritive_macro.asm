%macro DECLINE_INSTRUMENTAL 2
    mov rsi, %1          ; Адрес исходной строки
    mov rdi, %2          ; Адрес буфера результата
    call copy_string      ; Копируем строку

    sub rdi, 1           ; Указатель на последний символ
    cmp byte [rdi], 'й'
    je %%replace_y_with_em
    cmp byte [rdi], 'е'
    je %%replace_y_with_em
    cmp byte [rdi - 1], 'о'
    je %%append_om
    cmp byte [rdi - 1], 'е'
    je %%append_om
    cmp byte [rdi - 1], 'и'
    je %%append_om
    jmp %%done

%%replace_y_with_em:
    mov word [rdi - 1], 'ем'
    jmp %%done

%%append_om:
    inc rdi
    mov word [rdi], 'ом'
    mov byte [rdi + 2], 0
%%done:
%endmacro

