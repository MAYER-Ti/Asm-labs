section .data
    ; Глобальные сообщения
    msg_enter db 'Введите фамилию:', 10, 0
    msg_nom db 'Есть', 10, 0
    msg_gen db 'Нет', 10, 0
    msg_dat db 'Дать', 10, 0
    msg_acc db 'Вижу', 10, 0
    msg_inst db 'С', 10, 0
    msg_prep db 'О', 10, 0
    newline db 10, 0

    ; Буферы для работы
    buffer times 30 db 0          ; Буфер для ввода фамилии
    output_buffer times 50 db 0   ; Буфер для вывода результата

section .text
    global _start

; Макросы для упрощения операций
%macro mWrite 1
    lea rdi, [%1]      ; Адрес строки
    call mstrlen       ; Вызов функции для вычисления длины строки
    mov rdx, rax       ; Длина строки в rdx
    mov rax, 1         ; Системный вызов: write
    mov rdi, 1         ; Файл дескриптор (stdout)
    lea rsi, [%1]      ; Адрес строки
    syscall            ; Вызов ядра
%endmacro

%macro mInput 1
    mov rax, 0         ; Системный вызов: read
    mov rdi, 0         ; Файл дескриптор (stdin)
    lea rsi, [%1]      ; Адрес буфера
    mov rdx, 30        ; Максимальная длина ввода
    syscall            ; Вызов ядра
%endmacro

%macro EndProgram 0
    mov rax, 60        ; Системный вызов: exit
    xor rdi, rdi       ; Код возврата 0
    syscall            ; Вызов ядра
%endmacro

; Функция для подсчёта длины строки
mstrlen:
    mov rsi, rdi        ; Адрес строки в RSI
    xor rcx, rcx        ; Счётчик длины
.next_char:
    cmp byte [rsi+rcx], 0 ; Конец строки?
    je .done
    inc rcx
    jmp .next_char
.done:
    mov rax, rcx        ; Возвращаем длину строки
    ret

_start:
    ; Вывод сообщения и ввод данных
    mWrite msg_enter
    mInput buffer

    ; Завершение программы
    EndProgram

