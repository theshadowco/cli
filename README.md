# cli

[![Stars](https://img.shields.io/github/stars/khorevaa/cli.svg?label=Github%20%E2%98%85&a)](https://github.com/khorevaa/cli/stargazers)
[![Release](https://img.shields.io/github/tag/khorevaa/cli.svg?label=Last%20release&a)](https://github.com/khorevaa/cli/releases)
[![Открытый чат проекта https://gitter.im//oscript-cli/Lobby](https://badges.gitter.im/khorevaa/cli.png)](https://gitter.im/oscript-cli/Lobby?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

[![Build Status](https://travis-ci.org/khorevaa/cli.svg?branch=master)](https://travis-ci.org/khorevaa/cli)
[![Coverage Status](https://coveralls.io/repos/github/khorevaa/cli/badge.svg?branch=master)](https://coveralls.io/github/khorevaa/cli?branch=master)


Данная библиотека для языка OScript, позволяет создавать консольные приложения с разбором и проверкой аргументов.

[Документация и описание публичного API](docs/readme.md)
## Быстрый старт

### Пример простого приложения

```bsl
#Использовать cli

Перем Лог;

///////////////////////////////////////////////////////////////////////////////

Процедура ВыполнитьПриложение()

    Приложение = Новый КонсольноеПриложение(ПараметрыПриложения.ИмяПриложения(), "Помощник генерации приложения на основании шаблона cli");
    Приложение.Версия("v version", ПараметрыПриложения.Версия());

    Приложение.УстановитьОсновноеДействие(ЭтотОбъект)
    Приложение.Запустить(АргументыКоманднойСтроки);

КонецПроцедуры // ВыполнениеКоманды()

Процедура ВыполнитьКоманду(Знач Команда) Экспорт

    Сообщить("Полезная работа");

КонецПроцедуры

///////////////////////////////////////////////////////


Попытка

    ВыполнитьПриложение();

Исключение

    Сообщить(ОписаниеОшибки());

КонецПопытки;
```

### Пример приложения с несколькими командами:

```bsl
#Использовать cli

///////////////////////////////////////////////////////////////////////////////

Процедура ВыполнитьПриложение()

    Приложение = Новый КонсольноеПриложение("cli", "Помощник генерации приложения на основании шаблона cli");
    Приложение.Версия("v version","1.0.0");

    Приложение.ДобавитьКоманду("i init", "Инициализация структуры нового приложения", Новый КомандаInit);
    Приложение.ДобавитьКоманду("g generate", "Генерация элементов структуры приложения", Новый КомандаGenerate);

    Приложение.Запустить(АргументыКоманднойСтроки);

КонецПроцедуры // ВыполнениеКоманды()

///////////////////////////////////////////////////////

Попытка

    ВыполнитьПриложение();

Исключение

    Сообщить(ОписаниеОшибки());

КонецПопытки;
```

## Мотивация

Для PR в cmdline слишком большие изменения в API, т.е. обеспечить совместимость очень трудоемко.
Сравнительная таблица возможностей:

|                                                                                   | cli | cmdline |
|-----------------------------------------------------------------------------------|------|---------|
| Встроенная команда help                                                           | ✓    | ✓       |
| Автоматическая генерация справки по приложению и командам                         | ✓    | ✓       |
| Встроенная команда version                                                        | ✓    | ✓       |
| Команды                                                                           | ✓    | ✓       |
| Подкоманды                                                                        | ✓    |         |
| Совмещение булевых (флаговых) опций  `-xyz`                                       | ✓    |         |
| Совмещение опции и значения  `-fValue`                                            | ✓    |         |
| Взаимоисключающие опции: `--start ❘ --stop`                                       | ✓    |         |
| Необязательные опции : `[-a -b]` or `[-a [-b]]`                                   | ✓    |         |
| Проверка аргументов : `FILE PATH`                                                 | ✓    |         |
| Необязательные аргументы : `SRC [DST]`                                            | ✓    |         |
| Повторение аргументов : `SRC... DST`                                              | ✓    |         |
| Зависимость опций и аргументов друг от друга : `SRC [-f DST]`                     | ✓    |         |
| Формирование своей строки выполнения: `[-d ❘ --rm] FILE [КОМАНДА [АРГУМЕНТЫ...]]` | ✓    |         |

## Установка

Для установки необходимо: 
* Скачать файл cli.ospx из раздела [releases](https://github.com/khorevaa/cli/releases)
* Воспользоваться командой:

```
$ opm install -f <ПутьКФайлу>
```

## Базовые принципы

При создании приложения необходимо указать имя приложения и описание:

```bsl
Приложение = Новый КонсольноеПриложение("cli", "Помощник генерации приложения на основании шаблона cli");
```

Для установки основной функции выполнения приложения необходимо создать класс, или сам модуль должен реализовать экспортную процедуру:
```bsl
Процедура ВыполнитьКоманду(Знач Команда) Экспорт
КонецПроцедуры
```
Передать данный класс через процедуру:
```bsl
Приложение.УстановитьОсновноеДействие(ЭтотОбъект)
```


Для добавления отображения версии через опции: ```-v, --version``` надо добавить строчку:

```bsl
Приложение.Версия("v version", "1.2.3");
```

Для запуска приложения необходимо добавить строчку:

```bsl
Приложение.Запустить(АргументыКоманднойСтроки);
```

## Параметры команд/приложения

Все параметры разделяются на два типа:
* Опция 
* Аргумент

## Опция

Опция может быть следующих простых типов:
* Булево
* Строка
* Число
* Дата

Также опция может принимать массивы данных типов, например:

* МассивЧисел
* МассивСтрок
* МассивДат
* Перечисление

Для простых типов поддерживается определение типа по значение по умолчанию. Пример,

```bsl
Отладка = Команда.Опция("f force", ,"Описание опция")
    .ТБулево() // тип опции Булево
    ;
// Можно заменить на вызов

Отладка = Команда.Опция("f force", Ложь ,"Описание опция");

```

Пример `булево` опции:

```bsl
Отладка = Команда.Опция("v debug", ложь ,"Описание опции")
    .Флаговый() // тип опции булево
    .ВОкружении("ИМЯ_ПЕРЕМЕННОЙ")
    .ПоУмолчанию(Ложь)
    .СкрытьВСправке(); // Любой тип

```
`ВОкружении` Возможна передача нескольких переменных окружения разделенных через **пробел**

Пример `перечисления` опции:

```bsl
ЦветКонсоли = Команда.Опция("c color", "green" ,"Описание опции")
    .ТПеречисление() // тип опции перечисление
    .Перечисление("green", Новый ЗеленыйЦвет(), "Консоль будет зеленого цвета")
    .Перечисление("red", Цвета.Красный, "Консоль будет красного цвета")
    .Перечисление("Случайный", СлучайныйЦвет(), "Консоль будет случайного цвета")
    ;
```

Перечисление ограничивает пользователя в выборе значения опции, при этом разработчик для каждой опции может задавать свой тип значения

Подробное описание возможностей параметров команд и приложения [](./docs/ПараметрКоманды.md)

## Пример синтаксиса опций

### Для типа булево:

* `-f` : одно тире для коротких имен
* `-f=false` : одно тире для коротких имен и значение булево (true/false)
* `--force` : двойное тире для длинных имен
* `-it` : группировка булевых опций, будет эквивалентно: -i -t

### Для типа строка, число, дата, длительность:


* `-e=value` : одно тире для коротких имен, через **равно** значение опции
* `-e value` : одно тире для коротких имен, через **пробел** значение опции
* `-Ivalue` : одно тире для коротких имен, и сразу значение опции
* `--extra=value` : двойное тире для длинных имен, через **равно** значение опции
* `--extra value` : двойное тире для длинных имен, через **пробел** значение опции

### Для массивов опций (МассивСтрок, МассивЧисел, МассивДат):
повторение опции создаст массив данных указанного типа опций:

* `-e PATH:/bin -e PATH:/usr/bin` : Массив, содержащий `["/bin", "/usr/bin"]`
* `-ePATH:/bin -ePATH:/usr/bin` : Массив, содержащий `["/bin", "/usr/bin"]`
* `-e=PATH:/bin -e=PATH:/usr/bin` : Массив, содержащий `["/bin", "/usr/bin"]`
* `--env PATH:/bin --env PATH:/usr/bin` : Массив, содержащий `["/bin", "/usr/bin"]`
* `--env=PATH:/bin --env=PATH:/usr/bin` : Массив, содержащий `["/bin", "/usr/bin"]`

## Аргументы

Аргументы могут быть следующих простых типов:
* Булево
* Строка
* Число
* Дата

Для простых типов поддерживается определение типа по значение по умолчанию. Пример,

```bsl
Отладка = Команда.Аргумент("PATH", "" ,"Описание аргумента")
    .ТСтрока() // тип опции Строка
    ;
// Можно заменить на вызов

Отладка = Команда.Аргумент("PATH", "" ,"Описание аргумента");

```

Также аргументы могут принимать массивы данных типов, например:

* МассивЧисел
* МассивСтрок
* МассивДат
* Перечисление (см. пример опций)

Пример `Строки` аргумента:

```bsl
Отладка = Команда.Аргумент("PATH", "" ,"Описание аргумента")
    .ТСтрока() // тип опции Строка
    .ВОкружении("ИМЯ_ПЕРЕМЕННОЙ")
    .ПоУмолчанию(Ложь)
    .СкрытьВСправке(); // Любой тип
```

`ВОкружении` Возможна передача нескольких переменных окружения разделенных через **пробел**

Подробное описание возможностей параметров команд и приложения [](./docs/ПараметрКоманды.md)

## Операторы

Оператор `--` устанавливает метку завершению любых опций.
Все, что следует за данным оператором, будет считаться аргументом, даже если начинается с **тире**


Для примера, если команда "ХочуФайл" принимает в качестве аргумента имя файла, но начинающегося с `-`, тогда строка запуска данной программы будет выглядеть так:

```bsl
ИмяФайла = Команда.Аргумент("FILE", "", "имя файла для создания")
```

Допустим, нужное нам имя файла равно `-f`, тогда если выполнить нашу команду:

```
ХочуФайл -f
```

то будет выдана ошибка, т.к. `-f` распознано как опция, а не аргумент.
Для того, чтобы решить данную проблему, необходимо объявить окончание опций через оператор `--`

```
ХочуФайл -- -f
```

Тогда определение аргументов будет работать корректно.

## Команды и подкоманды

cli поддерживает создание команд и подкоманд.
Неограниченное количество вложенных подкоманд.
А также установки синонимов для команд и подкоманд.

```bsl
Приложение = Новый КонсольноеПриложение("testapp", "Выполняет полезную работу");
КомандаAve = Приложение.ДобавитьПодкоманду("a ave", "Команда ave", КлассРеализацииПодкоманды);
```

* Первый аргумент, наименование команды, которое необходимо будет вводить для запуска
* Второй аргумент, описание команды, которое будет выводиться в справке
* Третий аргумент, КлассРеализацииКоманды

cli поддерживает указание псевдонимов команд. Для примера:

```bsl
КомандаAve = Приложение.ДобавитьПодкоманду("start run r", "Команда start", КлассРеализацииПодкоманды);
```

Псевдонимы для команды будут `start`, `run`, и`r` - можно использовать любой из них.

cli поддерживает автоматическую инициализацию параметров команд.
Переданный класс должен реализовывать процедуру:

```bsl
Процедура ОписаниеКоманды(Команда) Экспорт
    Путь = Команда.Аргумент("PATH", "" ,"Описание аргумента")
        .ТСтрока() / тип опции Строка
        .ВОкружении("ИМЯ_ПЕРЕМЕННОЙ")
        .ПоУмолчанию(Ложь)
        .СкрытьВСправке(); // Любой тип

    Отладка = Команда.Опция("o opt", Ложь ,"Описание опции")
        .ТСтрока() / тип опции Строка
        .ВОкружении("ИМЯ_ПЕРЕМЕННОЙ")
        .ПоУмолчанию(Ложь)
        .СкрытьВСправке(); // Любой тип
КонецПроцедуры
```

## Строка использования приложения (спек)

Синтаксис спек базируется на POSIX.

### Опции

Для определения опций можно использовать длинные и короткие имена опций:
```bsl
Команда.Спек = "-f";
```
И/или:
```bsl
Команда.Спек = "--force";
```
Пример добавления аргументов в команду:

```bsl
Команд.Опция("f force", ...);
```

### Аргументы

Правила наименования аргументов, имя должно содержать только символы в верхнем регистре:

Пример, использования аргументов в определении строки использования приложения
```bsl
Команда.Спек="SRC DST"
```

Пример добавления аргументов в команду:

```go
Команда.Аргумент("SRC", ...);
Команда.Аргумент("DST", ...);
```

### Сортировка строки использования

cli позволяет произвольно настраивать порядок использования опций и аргументов:

```bsl
Команда.Спек = "-f -g NAME -h PATH";
```

## Необязательность

Для того, чтобы сделать аргументы или опции необязательными, их необходимо заключить в `[...]`:
```bsl
Команда.Спек = "[-x]";
```

### Выбор между

Для отражения выбора между несколькими опциями или аргументами используется символ `|`:

```bsl
Команда.Спек = "--server | --agent";
Команда.Спек = "-H | -L | -P";
Команда.Спек = "-f | PATH";
```

### Повторитель

Для повторения аргументов или опций необходимо использовать оператор `...`:

```bsl
Команда.Спек = "PATH...";
Команда.Спек = "-f...";
```

### Логические группы

Возможна логическая группировка опций и аргументов. Данную группировку стоит использовать и комбинировать с такими символами как `|` и `...`:

```bsl
Команда.Спек = "(-e КОМАНДА)... | (-x|-y)";
```
Приведенный пример настраивает строку использования следующим образом:
* Повторение опции -e  и команды
* Или
* Выбор между -x  и -y

### Группировка опций

Все короткие опции (типа булево) можно группировать в любом порядке вместе:
```bsl
Команда.Спек = "-abcd";
```
### Все опции

Для определение любой опции приложения:

```bsl
Команда.Спек = "[OPTIONS]";
```
Для примера, для команды с опциями a, b, c и d, указание `[OPTIONS]` или `[ОПЦИИ]` будет аналогично указанию:

```bsl
Команда.Спек = "[-a | -b | -c | -d]...";
```

### Аннотация к опциям в строке использования

Можно задавать в строке использования `=<очень хороший текст>` аннотации после указания опции в длинной или короткой форме, для того чтобы определить дополнительное описание или значение по умолчанию.

Для примера:

```bsl
Команда.Спек = "[ -a=<абсолютный путь к файлу> | --timeout=<в секундах> ] ARG";
```
Данные аннотации игнорируются парсером, и не влияют на работу приложения

### Операторы

Оператор `--` устанавливает метку завершению любых опций.
Все что следует за данным оператором считается аргументами.

Более, сложный пример:

```bsl
Приложение.Спек = "work -lp [-- CMD [ARG...]]";
```

## Грамматика строки использования

Используется упрощенная (EBNF grammar) грамматика при создании строки использования:

Описание символа         | Символ и использование       | Проверка
-------------------------|------------------------------|----------------------
Короткая опция           | '-'                          | [A-Za-z]
Длинная опция            | '--'                         | [A-Za-z][A-Za-z0-9]*
Соединенные опции        | '-'                          | [A-Za-z]+
Все опции                | '[OPTIONS]' или `[ОПЦИИ]`                  |
Логическая группа        | '(' любые другие символы ')' |
Необязательная           | '[' любые другие символы ']' |
Повтор аргумента         | '...'                        |
Конец повтора аргументов | '--'                         |

Можно комбинировать в указанные символы как хочется, для того чтобы добиться любых необходимых проверок опций и аргументов.


## Строка использования по умолчанию

По умолчанию, если не установлена разработчиком иная, cli автоматически создает для приложения и каждой команды строки использования, используя следующую логику:

* Начало с пустой строки
* Если определена хоть одна опция, добавляется `[OPTIONS]` или `[ОПЦИИ]` к текущей строке использования
* Для каждого добавленного аргумента, добавляет его представление согласно очереди, объявления аргументов.

Для примера, при добавлении в команду следующих опций и аргументов:

```bsl

ИнициализацияГит = Команда.Опция("g git-init", Ложь, "инициализировать создание git репозитория").Флаговый();
ИнтерактивныйРежим = Команда.Опция("interactive", Ложь, "интерактивный режим ввода информации о приложении").Флаговый();
ИспользоватьПодкоманды = Команда.Опция("s support-subcommads", Ложь, "шаблон с поддержкой подкоманд").Флаговый();
ФайлКонфига = Команда.Опция("c config-file", "", "файл настроек генерации приложения");

НаименованиеПриложения = Команда.Аргумент("NAME", "", "наименование приложения");
ПутьКПапкеГенерации = Команда.Аргумент("PATH", "", "Путь к папке для генерации нового приложения");

```

Будет автоматически создана следующая строка использования данной команды:

```bsl
[OPTIONS] NAME PATH
```

## Доработка

Доработка проводится по git-flow. Жду ваших PR.

## Лицензия

Смотри файл `LICENSE`.
