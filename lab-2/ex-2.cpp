// ЗАДАНИЕ
// Выполните операции пересылки массива в массив с 
// использованием команд: LOOP, LEA


#include <stdio.h>
#include <conio.h>

char A[10]={2,1,2,3,4,5,6,7,8,9};
char B[10]={0,0,0,0,0,0,0,0,0,0};


int main (void)
{

     clrscr();

     int n = 10;
     int i = 0;
 
     printf ("\nA:");
     for (i=0;i<n; i++) {
          printf (" %d", A[i]);
     } 
     printf ("\nB:");
     for (i=0;i<n; i++) {
          printf (" %d", B[i]);
     }

     printf ("\nmove A=>B");

     asm {
          mov cx, n;
          lea si, A;
          lea di, B;
     }

     copy_loop :
     asm{
          mov al, [si];
          mov [di], al;
          inc si;
          inc di;
          loop copy_loop;
     }

     printf ("\nA:");
     for (i=0;i<n; i++) {
          printf (" %d", A[i]);
     } 
     printf ("\nB:");
     for (i=0;i<n; i++) {
          printf (" %d", B[i]);
     }


     getch();

     return 0;
};
////////////////////////////////////////////////////////////////////////////////////
//********************************************************
// 5 Программа поиска в видеопамяти символа
//  printf (" \n Поиск символа  ");
// 	asm
// 	asm
// e1:     asm {
// 	   mov ax, 0xb800
// 	   mov es, ax
// 	   mov
// 	   cmp es:[di],al
// 	   jnz e2 };
//        printf (" \n Нашли символ  ");
// e2:	asm   add di, 2
// 	asm loop e1
//        printf (" \n Не нашли символ  ");
//    getch();

  
// return (0);
//***************** Задания  ******************
//
// 1 Проиллюстрируйте программами указанные выше команды
// 2 Рассмотрите двоичный код этих команд
// 3 Заполните таблицу, используя TD. Должны присутствовать 
// все поля формата команды.
/*
	Мнемоника     Префикс  КОП  Постбайт    Смещение Непоср.операнд
  │    │             │      │      │адресации   │         │             │
  ├────┼─────────────┼──────┼──────┼────────────┼─────────┼─────────────┤
  │  1 │and ax,bx    │  -   │      │            │  -      │     -       │
  │  2 │rep and bx,ax│      │      │            │         │             │
  │  3 │add ax,16    │  -   │      │            │  -      │             │
     4  add al,[bx+si]
*/

// 4. Напишите программу со строковыми командами  при 10 передачах
// 5. Разработайте блок-схему и  напишите программу
// поиска символа в видеопамяти на первых 4-х видеостраницах
// 6. Ответьте на вопросы: Какая мнемоника двухоперандной команды 00FF.
//    Как выполняется команда LDS BX,PtriA

/*

		   _Структура процессора i8086

     Программисту на  уровне  команд доступны четырнадцать регист-
ров.  Их удобно разбить на четыре группы: 1)Регистры данных, 2)ад-
ресные,  3)сегментные 4)указатель команд и регистр флажков(призна-
ков).
1) Регистры данных (в некоторых книгах их называют регистрами общего
   назначения). Операнды в этих регистрах могут быть как слова так и 
   байты. Если операнд - байт, может быть указана любая половина 
   регистра. Есть ряд команд, в которых функции отдельных регистров 
   специализированы (см.табл.)
2) Указатели и индексные регистры (адресные регистры, используются для 
   хранения 16-разрядных адресов). Адресные регистры во многих командах 
   также специализированы (см.табл.)
3) Сегментные регистры (указывают начала четырех сегментов - участков 
   по 64 К байт в 1М ОЗУ: сегмент команд CS, сегмент стека SS  и два 
   сегмента данных - DS и ES extra)
4) Указатель команд и регистр флажков

     Специальные функции регистров 8086

AX  Аккумулятор		Умножение, деление и ввод-вывод слов
AL  Аккумулятор(мл)	Умножение, деление и ввод-вывод байтов
AH  Аккумулятор(ст)	Умножение и деление байтов
BX  База		Базовый регистр, преобразование (?)
CX  Счетчик		Операции с цепочками, циклы
CL  Счетчик (мл)	Динамические сдвиги и ротации
DX  Данные		Умножение и деление слов,
			косвенный ввод-вывод
SP  Указатель стека	Стековые операции
BP  Указатель базы	Базовый регистр
SI  Индекс источника	Операции с цепочками, индексный регистр
DI  Индекс получателя	Операции с цепочками,

      _Регистр флагов процессора

    15 14 13 12 11 10  9  8  7  6  5  4  3  2  1  0
   ├──┼──┼──┼──┼──┼──┼──┼──┼──┼──┼──┼──┼──┼──┼──┼──┤
                OF DF IF TF SF ZF    AF    PF    CF

     CF ( Carry Flag ) - флаг переноса;
     PF ( Parity Flag ) - флаг четности;
     AF ( Auxiliary Carry Flag ) - флаг вспомогательного переноса;
     ZF ( Zero Flag ) - флаг нуля;
     SF ( Sign Flag ) - флаг знака;
     TF ( Trap Flag ) - флаг ловушки;
     IF ( Interrupt-Enable Flag ) - флаг разрешения прерывания;
     DF ( Direction Flag ) - флаг направления;
     OF ( Overflow Flag ) - флаг переполнения.





                                - 5 -

      _Организация памяти

     Адресуемая память (адресное пространство) представляет  собой
область  из  1М байт(в реальном режиме работы для микропроцессоров
i80286 и старше).  Два смежных байта образуют слово. Адресом слова
считается  адрес  младшего байта.  МП 8086 считывает информацию из
ОЗУ 16 бит.словами,  начинающимися с четных адресов,  хотя команда
или слово данных могут быть расположены в ОЗУ в любом адресе.
     Физический адрес памяти имеет длину 20 бит,  однако все обра-
батываемые в регистрах МП величины имеют длину 16 бит.  Для форми-
рования физических адресов используется механизм сегментации памя-
ти.  Пространство  памяти  1  М доступно процессору через 4 "окна"
(сегмента) каждый размером 64 К байт. Начальный адрес каждого сег-
мента содержится в оюном из четырех сегментных регистров.  Команды
обращаются к байтам и словам в пределах сегментов, используя отно-
сительный (внутрисегментный) адрес.

      _Общий формат команды следующий:

[Префикс]  КОП  [постбайт адресации]  [смещение] [непоср.операнд]
Элементы в квадратных скобках могут отсутствовать.

     Назначение элементов команды:

 _Префикс .. Длина 1 байт.
  а)Префикс переназначения сегмента позволяет переназначить сегмент 
  ОЗУ, к которому происходит обращение.Если префикс переназначения 
  сегмента отсутствует, сегмент выбирается по умолчанию.
  б)Префикс повторения действия для строковых команд
 _КОП . - код операции. Длина 1 байт. 0-й бит КОП во многих (но не во всех)
  командах показывает, производится ли операция со словом ( =1) или с 
  байтом ( =0). 1-й бит КОП в двухадресных командах  указывает, какой 
  из операндов является приемником.
 _Постбайт адресации .. Длина 1 байт. Постбайт адресации показывает, где
  находятся операнды. Структура системы адресации МП 8086 в 
  двухоперандной команде несимметрична. Один из операндов (первый) может
  быть расположен в регистре (регистровая адресация) или в произвольной 
  ячейке ОЗУ (все способы адресации кроме непосредственной).
  Второй операнд может находиться в теле команды (непосредственная 
  адресация) или в регистре (регистровая адресация). Каждый из
  операндов может быть как источником так и приемником (за исключением 
  непосредственной адресации: непосредственный операнд может быть 
  только источником). Структура постбайта адресации следующая:

	7     6     5     4     3     2     1    0
     !    mod    !       reg       !       r/m      !
     !-----!-----!-----!-----!-----!-----!-----!----!

  Поля mod и r/m задают место расположения первого операнда (или 
  едиственного в одноадресной команде). Поле reg задает положение 
  второго операнда в двухадресных командах, или используется для 
  расширения КОП в одноадресных командах.
	Значения поля mod:
	11 - операнд в регистре
		(при остальных mod операнд в ОЗУ, а регистры, на 
		которые указывают поля mod и r/m, содержат компоненты 
		адреса операнда)
	10 - смещение два байта (без знака)

                                - 6 -

	01 - смещение один байт (со знаком)
	00 - смещение в команде отстутствует

  Значения поля reg а также поля r/m при mod=0 (т.е. при регистровой 
  адресации следующие:

    reg или r/m         Байт    Слово
	000		 AL	 AX
	001		 CL	 CX
	010		 DL	 DX
	011		 BL	 BX
	100		 AH	 SP
	101		 CH	 BP
	110		 DH	 SI
	111		 BH	 DI

  При адресации в память значения mod и r/m определяют способ 
  вычисления адреса следующим образом:

        r/m     mod=00          mod=01 или 10
	000	BX+SI		BX+SI+смещение
	001	BX+DI		BX+DI+смещение
	010	BP+SI		BP+DI+смещение
	011	BP+DI		BP+DI+смещение
	100	SI		SI+смещение
	101	DI		DI+смещение
	110	direct		BP+смещение
	111	BX		BX+смещение

Смещение. Длина 1 байт (при mod-01) или 2 байта(при mod=10).
Непосредственный операнд. Длина 1 или 2 байта
Таким образом, длина команды лежит в пределах от 1 до 7 байтов.

*/

