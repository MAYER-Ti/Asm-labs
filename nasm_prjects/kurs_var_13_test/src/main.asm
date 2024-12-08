%include "src/io_macro.asm"
%include "src/decline_lastname_macro.asm"

section .data
    ; Глобальные сообщения
    input_msg db "Введите фамилию: ", 0
    nominative_msg db "Именительный: ", 0
    roditive_msg db "Родительный: ", 0
    dative_msg db "Дательный: ", 0
    vinitive_msg db "Винительный: ", 0
    tvoritive_msg db "Творительный: ", 0
    predlositive_msg db "Предложный: ", 0
    newline db 0xA, 0
    err_msg db "Неверный падеж", 0


    ; Буферы для работы
    buffer times 100 dw 0; Буфер для ввода фамилии
    output_buffer times 100 dw 0   ; Буфер для вывода результата
    char db 'A'

section .text
    global _start

%macro mZeroArray 2
    mov rdi, %1         ; Адрес массива
    mov rcx, %2         ; Длина массива
    xor rax, rax        ; Устанавливаем значение для записи (0)
%%zero_loop:
    mov byte [rdi], al  ; Зануляем текущий байт
    inc rdi             ; Переходим к следующему элементу
    loop %%zero_loop     ; Уменьшаем rcx и повторяем, если не 0
%endmacro


%macro EndProgram 0
    mov rax, 60        ; Системный вызов: exit
    xor rdi, rdi       ; Код возврата 0
    syscall            ; Вызов ядра
%endmacro

_start:


;    ; ввод фамилии
;    mPrintString input_msg
;    mInputString buffer, 100
;    mTrimString buffer
;    mPrintString buffer
;    mPrintString newline
;    
;
;     
;    ; Вывод в иминительном падеже 
;    mPrintString nominative_msg
;    mDeclineLastname buffer, output_buffer, 1
;    mPrintString output_buffer
;    mPrintString newline
;    mZeroArray output_buffer, 100
;   
;    ; Вывод в родительном падеже 
;    mPrintString roditive_msg
;    mDeclineLastname buffer, output_buffer, 2
;    mPrintString output_buffer
;    mPrintString newline

;    ; Вывод в дательном падеже 
;    mPrintString dative_msg
;    mDeclineLastname buffer, output_buffer, 3
;    mPrintString output_buffer
;    mPrintString newline
;
;    ; Вывод в винительном падеже 
;    mPrintString vinitive_msg
;    mDeclineLastname buffer, output_buffer, 4
;    mPrintString output_buffer
;    mPrintString newline
;
;    ; Вывод в творительном падеже 
;    mPrintString tvoritive_msg
;    mDeclineLastname buffer, output_buffer, 5
;    mPrintString output_buffer
;    mPrintString newline
;
;    ; Вывод в предложном падеже 
;    mPrintString predlositive_msg
;    mDeclineLastname buffer, output_buffer, 6
;    mPrintString output_buffer
;    mPrintString newline
;
    ; Завершение программы
    EndProgram
