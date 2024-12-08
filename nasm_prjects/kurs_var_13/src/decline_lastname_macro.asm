%macro mCopyString 2
    mov rsi, %1         ; Адрес исходной строки (откуда)
    mov rdi, %2         ; Адрес целевой строки (куда)
%%copy_loop:
    lodsb               ; Загружаем байт из исходной строки
    stosb               ; Сохраняем байт в целевую строку
    test al, al         ; Проверяем, не нулевой ли байт (конец строки)
    jnz %%copy_loop      ; Если не конец строки, продолжаем копирование
    mov byte [rdi], 0
%endmacro

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

    mov al , %3
    cmp al, 1            ; Именительный падеж
    je %%nominative
    cmp al, 2            ; Родительный падеж
    je %%genitive
    cmp al, 3            ; Дательный падеж
    je %%dative
    cmp al, 4            ; Винительный падеж
    je %%nominative
    cmp al, 5            ; Творительный падеж
    je %%instrumental
    cmp al, 6            ; Предложный падеж
    je %%prepositional
    jmp %%error          ; Ошибка, неправильный падеж

%%nominative:
    ; Копируем фамилию без изменений
    DECLINE_NOMINATIVE %1, %2
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
    mCopyString err_msg, %2 
  
%%done:
%endmacro

