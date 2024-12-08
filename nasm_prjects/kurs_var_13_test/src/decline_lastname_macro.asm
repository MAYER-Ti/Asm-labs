copy_string:
    cld                  ; Устанавливаем направление копирования вперед
.copy_loop:
    lodsb                ; Загружаем байт из исходного адреса RSI
    stosb                ; Сохраняем байт в адрес RDI
    test al, al          ; Проверяем, не нулевой ли это байт
    jnz .copy_loop       ; Если не 0, продолжаем копирование
    ret                  ; Возврат из подпрограммы

%include "src/decline_lastname_nominative_macro.asm"
%include "src/decline_lastname_roditive_macro.asm"
%include "src/decline_lastname_dative_macro.asm"
%include "src/decline_lastname_vinitive_macro.asm"
%include "src/decline_lastname_tvoritive_macro.asm"
%include "src/decline_lastname_predlositive_macro.asm"




%macro mDeclineLastname 3
    ; Параметры:
    ; %1 - исходная фамилия
    ; %2 - буфер для результата
    ; %3 - номер падежа

    mov rax , %3
    cmp rax, 1            ; Именительный падеж
    je %%nominative
    cmp rax, 2            ; Родительный падеж
    je %%genitive
    cmp rax, 3            ; Дательный падеж
    je %%dative
    cmp rax, 4            ; Винительный падеж
    je %%nominative
    cmp rax, 5            ; Творительный падеж
    je %%instrumental
    cmp rax, 6            ; Предложный падеж
    je %%prepositional
    jmp %%error          ; Ошибка, неправильный падеж

%%nominative:
    ; Копируем фамилию без изменений
    mov rsi, %1
    mov rdi, %2
    call copy_string
    jmp %%done

%%genitive:
    DECLINE_GENITIVE %1, %2
    jmp %%done
 
%%dative:
    DECLINE_DATIVE %1, %2
    jmp %%done
 
%%instrumental:
    ; Аналогичный макрос для творительного падежа
    ; DECLINE_INSTRUMENTAL %1, %2
    jmp %%done
 
%%prepositional:
    ; Аналогичный макрос для предложного падежа
    ; DECLINE_PREPOSITIONAL %1, %2
    jmp %%done
  
%%error:
    ; Обработка ошибки
    mov rsi, err_msg
    mov rdi, %2
    call copy_string
  
%%done:
%endmacro

