%macro DECLINE_GENITIVE 2



    mCopyString %1, %2
;
;    mPrintString %2 


    mStringLength %2 ; посчитать кол-во байт в строке до \0 записать в rax
    sub rax, 2 ; встать на последюю букву
  ;  count_letters %2
;   rax - кол-во букв
    
    mov rsi, %2
    ;add rax, '30h'
    ; Последняя буква
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  push word [rsi + rax]
    ; Предпоследняя буква
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; push word [rsi + rax - 2]
;    add rsi, rax
   ; mov rsi, rsp
  ;  add rsi, rax
  ;  sub rsi, 2
;
;    mov rax, 1 
;    mov rdi, 1 
;    mov rdx, 4
;    syscall 
;;    

;     
;    ; Применяем правила для UTF-8
;    sub rdi, 2           ; Указатель на последний символ (слово UTF-8)
;    ; Проверяем последний символ на 'й' (UTF-8: D0 B9)
    mov ax, word [rsi + rax]
    cmp ax, 0xB9D0       ; Проверка на 'й'
    je %%replace_y_with_ya
;

    ; Проверяем последний символ на 'е' (UTF-8: D0 B5)
    cmp ax, 0xB5D0       ; Проверка на 'е'
    je %%replace_y_with_ya
;
;    ; Проверяем предпоследний символ для добавления 'а'
;    sub rdi, 2           ; Переходим к предпоследнему символу
    mPrintChar char 
    mov ax, word [rsi + rax - 2]
    mPrintChar char 
    cmp ax, 0xBED0       ; 'о' (UTF-8: D0 BE)
    je %%append_a
    cmp ax, 0xB5D0       ; 'е' (UTF-8: D0 B5)
    je %%append_a
    cmp ax, 0xB8D0       ; 'и' (UTF-8: D0 B8)
    je %%append_a
    jmp %%done
;
%%replace_y_with_ya:
    ; Меняем последний символ на 'я' (UTF-8: D1 8F)
    mov word [rsi + rax], word 0x8FD1
    jmp %%done
;
;%%buffer_overflow_error:
;    mCopyString err_msg, %2
;    ret
;
;
%%append_a:
    mPrintChar char
    ; Добавляем 'а' (UTF-8: D0 B0)
    mov word [rsi + rax + 2], 0xB0D0    ; Первый байт UTF-8 для 'а'
    mov word [rsi + rax + 4], 0      ; Завершающий нуль
%%done: 
%endmacro

