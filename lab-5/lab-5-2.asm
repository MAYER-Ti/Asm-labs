.model small
.stack 100h

.data
    msg_equal db 'Numbers are equal', 0Dh, 0Ah, '$'
    msg_greater db 'First number is greater', 0Dh, 0Ah, '$'
    msg_less db 'Second number is greater', 0Dh, 0Ah, '$'
.code
; ”казать, что используем команды 286
.286
start:
    ; запись сегмента пам€ти
    mov ax, @data
    mov ds, ax

    ; запись двух чисел long long (по два слова)
    push word ptr 1234h ; старшее слово первого числа
    push word ptr 5676h ; младшее слово первого числа
    push word ptr 1234h ; старшее слово второго числа
    push word ptr 5677h ; младшее слово второго числа

    ; вызов подпрограммы сравнени€
    call CompareLongs
    
    ; проверка полученных флагов после сравнени€
    je NumbersEqual       ; равны
    jg FirstIsGreater     ; больше
    jl SecondIsGreater    ; меньше

NumbersEqual:
    lea dx, msg_equal
    jmp Display
FirstIsGreater:
    lea dx, msg_greater
    jmp Display
SecondIsGreater:
    lea dx, msg_less
Display:
    ; вывод сообщени€
    mov ah, 09h
    int 21h
    
    ; завершение программы
    mov ah, 4Ch
    int 21h

; ==== ѕодпрограмма сравнени€ двух чисел long long ====
; адреса операндов функции лежат в стеке
CompareLongs proc
    ; создание стекового кадра
    enter 0, 0
    ; стековый кадр хранит:
    ; параметры функций,
    ; адрес возврата, 
    ; базовый указатель bp (указывало на стековый кадр вызывающей функции)
    ; локальные переменные
    ; доп пространство дл€ временных данных
    
    ; сохранить значени€ регистров перед использованием
    push ax
    push dx
    push bx
    push cx

    ; извлечение чисел из стека
    mov ax, [bp+4]       ; младшее слово второго числа
    mov dx, [bp+6]       ; старшее слово второго числа
    mov bx, [bp+8]       ; младшее слово первого числа
    mov cx, [bp+10]      ; старшее слово первого числа

    ; сравнение старших слов
    cmp cx, dx           
    jne CompareEnd        ; если не равны

    ; сравнение младших слов
    cmp bx, ax
CompareEnd:
    
    ; вернуть занчени€ регистров после использовани€
    pop cx
    pop bx
    pop dx
    pop ax
    
    ; ¬осстановить значение sp = bp
    ; ¬осстановить предыдущее значение bp, записанное в стековом кадре
    leave ; ”далить текущий стековый кадр              
    ret 8               ; удал€ем параметры из стека (4 слова по 2 байта)
CompareLongs endp       ; адреса размером два байта (слово), параметры - адреса

end start
