%macro DECLINE_PREPOSITIONAL 2
    mov rsi, %1          ; Адрес исходной строки
    mov rdi, %2          ; Адрес буфера результата
    call copy_string      ; Копируем строку

    sub rdi, 1           ; Указатель на последний символ
    cmp byte [rdi], 'й'
    je %%replace_y_with_e
    cmp byte [rdi], 'е'
    je %%replace_y_with_e
    cmp byte [rdi - 1], 'о'
    je %%append_e
    cmp byte [rdi - 1], 'е'
    je %%append_e
    cmp byte [rdi - 1], 'и'
    je %%append_e
    jmp %%done

%%replace_y_with_e:
    mov word [rdi - 1], 'е'
    jmp %%done

%%append_e:
    inc rdi
    mov byte [rdi], 'е'
    mov byte [rdi + 1], 0
%%done:
%endmacro

