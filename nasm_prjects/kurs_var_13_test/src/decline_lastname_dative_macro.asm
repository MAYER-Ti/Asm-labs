%macro DECLINE_DATIVE 2
    mov rsi, %1          ; Адрес исходной строки
    mov rdi, %2          ; Адрес буфера результата
    call copy_string      ; Копируем строку

    sub rdi, 1           ; Указатель на последний символ
    cmp word [rdi], 'й'
    je %%replace_y_with_yu
    cmp word [rdi], 'е'
    je %%replace_y_with_yu
    cmp word [rdi - 1], 'о'
    je %%append_u
    cmp word [rdi - 1], 'е'
    je %%append_u
    cmp word [rdi - 1], 'и'
    je %%append_u
    jmp %%done

%%replace_y_with_yu:
    mov word [rdi - 1], 'ю'
    jmp %%done

%%append_u:
    inc rdi
    mov word [rdi], 'у'
    mov word [rdi + 1], 0
%%done:
%endmacro

