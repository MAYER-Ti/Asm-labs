%macro mPrintString 1
    ; Вывод строки (длина вычисляется автоматически)
    xor rdx, rdx        ; Обнуляем длину строки
    mov rsi, %1         ; Адрес строки
    xor rax, rax        ; Сбрасываем регистр
%%calculate_length:
    mov al, byte [rsi + rdx]
    cmp al, 0           ; Ищем конец строки (нулевой байт)
    je %%print_now
    inc rdx             ; Увеличиваем длину
    jmp %%calculate_length
%%print_now:
    mov rax, 1          ; syscall write
    mov rdi, 1          ; stdout
    syscall
%endmacro

%macro mPrintChar 1 
    push rsi
    push rax
    push rdi
    push rdx
    ; Вывод символа 
    mov rsi, %1
    mov rax, 1
    mov rdi, 1
    mov rdx, 1 
    syscall

    pop rdx
    pop rdi 
    pop rax 
    pop rsi
%endmacro

%macro mStringLength 1
    push cx
    mov rsi, %1         ; Адрес строки
    xor rcx, rcx        ; Обнуляем счетчик длины
%%count_loop:
    lodsb               ; Загружаем текущий байт из строки
    test al, al         ; Проверяем, не конец строки ли это
    jz %%done            ; Если нашли конец строки, завершаем
    inc rcx             ; Увеличиваем счетчик
    jmp %%count_loop     ; Продолжаем цикл
%%done:
    mov rax, rcx 
    pop cx
%endmacro

%macro count_letters 1
    ; %1 - адрес строки
    mov rsi, %1              ; Указатель на начало строки
    xor rax, rax             ; Счётчик букв = 0
%%count_loop:
    cmp word [rsi], 0        ; Проверяем конец строки
    je %%done

    ; Проверяем символ: кириллица (А-Я, а-я, включая ё/Ё)
    movzx rdx, word [rsi]    ; Загружаем текущий символ
    cmp rdx, 0x0410          ; Если меньше 'А'
    jb %%not_letter           ; Пропустить
    cmp rdx, 0x044F          ; Если больше 'я'
    jbe %%is_letter           ; Это кириллическая буква
    cmp rdx, 0x0401          ; Проверяем 'Ё'
    je %%is_letter            ; Это буква
    cmp rdx, 0x0451          ; Проверяем 'ё'
    je %%is_letter            ; Это буква

%%not_letter:
    ; Проверяем символ: латиница (A-Z, a-z)
    cmp rdx, 0x0041          ; Если меньше 'A'
    jb %%next                 ; Пропустить
    cmp rdx, 0x005A          ; Если больше 'Z'
    jbe %%is_letter           ; Это латинская буква

    cmp rdx, 0x0061          ; Если меньше 'a'
    jb %%next                 ; Пропустить
    cmp rdx, 0x007A          ; Если больше 'z'
    ja %%next                 ; Пропустить

%%is_letter:
    inc rax                  ; Это буква, увеличиваем счётчик

%%next:
    add rsi, 2               ; Переходим к следующему символу (2 байта)
    jmp %%count_loop

%%done:
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
