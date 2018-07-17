#Использовать "./internal/lexer"
#Использовать "./internal/parser"
#Использовать "./internal/types"
#Использовать "./internal/tools"
#Использовать "./internal/path"
#Использовать delegate
#Использовать logos
#Использовать reflector
#Использовать fluent

// Пользовательская строка использования текущей команды
Перем Спек Экспорт; // Строка
// (ЗАГОТОВКА) Содержит дополнительно подробное описания для справки по команде
Перем ПодробноеОписание Экспорт; // Строка

// Содержит экземпляр класс КонсольноеПриложения, для возможности получения экспортных свойств приложения
Перем Приложение Экспорт; // Класс КонсольноеПриложения
// Содержит входящий массив родителей текущей команды
// Устанавливается при выполнении команд родителей
Перем КомандыРодители Экспорт; // Массив классов КомандаПриложения

Перем Имя; // Строка
Перем Синонимы; // массив строк
Перем Описание; // Строка
Перем ВложенныеКоманды;  // Массив классов КомандаПриложения
Перем Опции; // Соответствие
Перем Аргументы; // Соответствие

Перем ОпцииИндекс; // Соответствие
Перем АргументыИндекс; // Соответствие

Перем КлассРеализации; // Объект

Перем НачальноеСостояние; // Класс Совпадение
Перем РасширенныйРефлектор; // Класс Рефлектор

Перем ИндексДействийКоманды; // Соответствие;

Перем Лог;

// Функция добавляет вложенную команду в текущую и возвращает экземпляр данной команды
//
// Параметры:
//   ИмяПодкоманды - строка - в строке допустимо задавать синоним через пробел, например "exec e"
//   ОписаниеПодкоманды - строка - описание команды для справки
//   КлассРеализацииПодкоманды - объект - класс, объект реализующий функции выполнения команды.
//                                     Так же используется, для автоматической настройки опций и параметров команды
//
// Возвращаемое значение:
//   Команда - объект -  класс КомандаПриложения
Функция ДобавитьПодкоманду(ИмяПодкоманды, ОписаниеПодкоманды, КлассРеализацииПодкоманды) Экспорт

	Подкоманда = Новый КомандаПриложения(ИмяПодкоманды, ОписаниеПодкоманды, КлассРеализацииПодкоманды, Приложение);

	ВложенныеКоманды.Добавить(Подкоманда);

	Возврат Подкоманда;

КонецФункции

// Функция добавляет вложенную команду в текущую и возвращает экземпляр данной команды
// Симноним метода <ДобавитьПодкоманду>
//
// Параметры:
//   ИмяПодкоманды - строка - в строке допустимо задавать синоним через пробел, например "exec e"
//   ОписаниеПодкоманды - строка - описание команды для справки
//   КлассРеализацииПодкоманды - объект - класс, объект реализующий функции выполнения команды.
//                                     Так же используется, для автоматической настройки опций и параметров команды
//
// Возвращаемое значение:
//   Команда - объект -  класс КомандаПриложения
Функция ДобавитьКоманду(ИмяПодкоманды, ОписаниеПодкоманды, КлассРеализацииПодкоманды) Экспорт

	Возврат ДобавитьПодкоманду(ИмяПодкоманды, ОписаниеПодкоманды, КлассРеализацииПодкоманды);

КонецФункции

// Функция массив вложенных команд, текущей команды
//
// Возвращаемое значение:
//  ВложенныеКоманды - массив - элементы класс КомандаПриложения
Функция ПолучитьПодкоманды() Экспорт

	Возврат ВложенныеКоманды;

КонецФункции

// Функция возвращает текущее имя команды
//
// Возвращаемое значение:
//   Имя - строка - имя текущей команды
Функция ПолучитьИмяКоманды() Экспорт
	Возврат Имя;
КонецФункции

// Функция массив синонимов команды
//
// Возвращаемое значение:
//  Синонимы - массив - элементы строка
Функция ПолучитьСинонимы() Экспорт
	Возврат Синонимы;
КонецФункции

// Функция возвращает описание команды
//
// Возвращаемое значение:
//  Описание - строка - описание текущей команды
Функция ПолучитьОписание() Экспорт
	Возврат Описание;
КонецФункции

// Функция возвращает значение опции по переданному имени/синониму опции
//
// Параметры:
//   ИмяОпции - строка - имя или синоним опции
//
// Возвращаемое значение:
//   Значение - Произвольный - полученное значение в результате чтения строки использования или переменных окружения
Функция ЗначениеОпции(Знач ИмяОпции) Экспорт

	ОпцияИндекса = ОпцияИзИндекса(ИмяОпции);
	
	Если ОпцияИндекса = Неопределено Тогда
		
		ЗначениеОпцииРодителя = ЗначениеОпцииКомандыРодителя(ИмяОпции);

		Если Не ЗначениеОпцииРодителя = Неопределено Тогда
			Возврат ЗначениеОпцииРодителя;
		КонецЕсли;

	КонецЕсли;
	
	Если ОпцияИндекса = Неопределено Тогда
	
		ВызватьИсключение СтрШаблон("Ошибка получение значения опции <%1>. 
		|Опция не найдена в индексе опций команды", ИмяОпции);

	КонецЕсли;

	Возврат ОпцияИндекса.Значение;

КонецФункции

// Функция возвращает значение аргумента по переданному имени аргумента
//
// Параметры:
//   ИмяАргумента - строка - имя аргумента
//
// Возвращаемое значение:
//   Значение - Произвольный - полученное значение в результате чтения строки использования или переменных окружения
Функция ЗначениеАргумента(Знач ИмяАргумента) Экспорт

	АргументИндекса = АргументИзИндекса(ИмяАргумента);

	Если АргументИндекса = Неопределено Тогда
		ЗначениеАргументаРодителя = ЗначениеАргументаКомандыРодителя(ИмяАргумента);

		Если Не ЗначениеАргументаРодителя = Неопределено Тогда
			Возврат ЗначениеАргументаРодителя;
		КонецЕсли;

	КонецЕсли;

	Если АргументИндекса = Неопределено Тогда
		ВызватьИсключение СтрШаблон("Ошибка получение значения аргумента <%1>.
		|Аргумент не найден в индексе аргументов команды", ИмяАргумента);
	КонецЕсли;

	Возврат АргументИндекса.Значение;

КонецФункции

// Функция возвращает значение опции команды родителя по переданному имени/синониму опции 
// Возвращает первое из совпадений или неопределенно в случае отсутствия опции
//
// Параметры:
//   ИмяОпции - строка - имя или синоним опции
//
// Возвращаемое значение:
//   Значение - Произвольный, Неопределенно - полученное значение в результате чтения строки использования или переменных окружения
//									или неопределенно в случае отсутствия в индексе указанной опции
Функция ЗначениеОпцииКомандыРодителя(Знач ИмяОпции) Экспорт

	Лог.Отладка("Ищю опцию <%1> для родителей", ИмяОпции);
		
	Для каждого РодительКоманды Из КомандыРодители Цикл
	
		Лог.Отладка(" --> Проверяю родителя <%1>", РодительКоманды.ПолучитьИмяКоманды());
	
		ОпцияРодителя = РодительКоманды.ОпцияИзИндекса(ИмяОпции);
		
		Если НЕ ОпцияРодителя = Неопределено Тогда
			Возврат ОпцияРодителя.Значение;
		КонецЕсли;

		ОпцияВышестоящегоРодителя = РодительКоманды.ЗначениеОпцииКомандыРодителя(ИмяОпции);

		Если НЕ ОпцияВышестоящегоРодителя = Неопределено Тогда
			Возврат ОпцияВышестоящегоРодителя.Значение;
		КонецЕсли;

	КонецЦикла;

	Возврат Неопределено;

КонецФункции

// Функция возвращает значение аргумента команды родителя по переданному имени аргумента
// Возвращает первое из совпадений или неопределенно в случае отсутствия аргумента
//
// Параметры:
//   ИмяАргумента - строка - имя аргумента
//
// Возвращаемое значение:
//   Значение - Произвольный, Неопределенно - полученное значение в результате чтения строки использования или переменных окружения
//									или неопределенно в случае отсутствия в индексе указанного аргумента
Функция ЗначениеАргументаКомандыРодителя(Знач ИмяАргумента) Экспорт

	Лог.Отладка("Ищю аргумент <%1> для родителей", ИмяАргумента);

	Для каждого РодительКоманды Из КомандыРодители Цикл

		Лог.Отладка(" --> Проверяю родителя <%1>", РодительКоманды.ПолучитьИмяКоманды());

		АргументРодителя = РодительКоманды.АргументИзИндекса(ИмяАргумента);

		Если НЕ АргументРодителя = Неопределено Тогда
			Возврат АргументРодителя.Значение;
		КонецЕсли;

		АргументВышестоящегоРодителя = РодительКоманды.ЗначениеАргументаКомандыРодителя(ИмяАргумента);

		Если НЕ АргументВышестоящегоРодителя = Неопределено Тогда
			Возврат АргументВышестоящегоРодителя.Значение;
		КонецЕсли;

	КонецЦикла;

	Возврат Неопределено;

КонецФункции

// Функция возвращает все параметры команды, для доступа к ним по синонимам
//
// Возвращаемое значение:
//   Параметры - Соответствие - содержит Соответствие
//      * Ключ - строка - имя или синоним опции/аргумента команды
//      * Значение - Произвольный -  полученное значение в результате чтения строки использования или переменных окружения
Функция ПараметрыКоманды() Экспорт

	ПКоманды = Новый Соответствие;

	Для каждого КлючЗначение Из ОпцииИндекс Цикл
		ПКоманды.Вставить(КлючЗначение.Ключ, КлючЗначение.Значение.Значение);
	КонецЦикла;

	Для каждого КлючЗначение Из АргументыИндекс Цикл
		ПКоманды.Вставить(КлючЗначение.Ключ, КлючЗначение.Значение.Значение);
	КонецЦикла;

	Возврат ПКоманды;

КонецФункции

// Процедура выводит справку по команде в консоль
Процедура ВывестиСправку() Экспорт

	СправкаВыведена = ВыполнитьДействиеКоманды("ВывестиСправку");

	Если СправкаВыведена Тогда
		Возврат;
	КонецЕсли;

	Представление = ?(КомандыРодители.Количество() > 0, "Команда", "Приложение");

	Сообщить(СтрШаблон("%1: %2
	| %3", Представление, СтрСоединить(Синонимы, ", "), ?(ПустаяСтрока(ПодробноеОписание), Описание, ПодробноеОписание)));
	Сообщить("");

	ПолныйПуть = Новый Массив;

	Для каждого Родитель Из КомандыРодители Цикл
		ПолныйПуть.Добавить(Родитель.ПолучитьИмяКоманды());
	КонецЦикла;
	ПолныйПуть.Добавить(СокрЛП(Имя));

	ПутьИспользования = СтрСоединить(ПолныйПуть, " ");
	СуффиксВложенныхКоманды = "";
	Если ВложенныеКоманды.Количество() > 0  Тогда

		СуффиксВложенныхКоманды = "КОМАНДА [аргументы...]";

	КонецЕсли;

	ШаблонСтрокиИспользования = "Строка запуска: %1 %2 %3";
	Сообщить(СтрШаблон(ШаблонСтрокиИспользования,
						ПутьИспользования,
						СокрЛП(Спек),
						СуффиксВложенныхКоманды));

	Сообщить("");

	ШаблонЗаголовкаНаименования = "%1:" + Символы.Таб;

	Если Аргументы.Количество() > 0 Тогда

		Сообщить(СтрШаблон(ШаблонЗаголовкаНаименования, "Аргументы"));

		ТаблицаАругментов = ТаблицаАргументовДляСправки();

		ВывестиТаблицуСправки(ТаблицаАругментов);

	КонецЕсли;

	Если Опции.Количество() > 0 Тогда

		Сообщить(СтрШаблон(ШаблонЗаголовкаНаименования, "Опции"));
		ТаблицаОпций = ТаблицаОпцийДляСправки();
		ВывестиТаблицуСправки(ТаблицаОпций);

	КонецЕсли;

	Если ВложенныеКоманды.Количество() > 0 Тогда

		Сообщить(СтрШаблон(ШаблонЗаголовкаНаименования, "Доступные команды"));

		МаксимальнаяДлинаКоманд = 0;

		Для каждого ВложеннаяКоманда Из ВложенныеКоманды Цикл
			НоваяДлина = СтрДлина(СтрСоединить(ВложеннаяКоманда.ПолучитьСинонимы(), ", "));
			МаксимальнаяДлинаКоманд = ?(НоваяДлина > МаксимальнаяДлинаКоманд, НоваяДлина, МаксимальнаяДлинаКоманд);
		КонецЦикла;

		ШаблонВложеннойКоманды = "  %1" + Символы.Таб + "%2";

		Для каждого ВложеннаяКоманда Из ВложенныеКоманды Цикл

			ПредставлениеВлКоманды = СтрСоединить(ВложеннаяКоманда.ПолучитьСинонимы(), ", ");
			ТекущаяДлина = СтрДлина(ПредставлениеВлКоманды);
			
			НаименованиеДляСправки = ДополнитьСтрокуПробелами(ПредставлениеВлКоманды, МаксимальнаяДлинаКоманд - ТекущаяДлина);
			ОписаниеДляСправки = ВложеннаяКоманда.ПолучитьОписание();
			Сообщить(СтрШаблон(ШаблонВложеннойКоманды, НаименованиеДляСправки, ОписаниеДляСправки));

		КонецЦикла;

		Сообщить("");

		Сообщить(СтрШаблон("Для вывода справки по доступным командам наберите: %1 КОМАНДА %2", ПутьИспользования, "--help"));

	КонецЕсли;

КонецПроцедуры

// Основная процедура запуска команды приложения
//
// Параметры:
//   АргументыCLI - Массив - Элементы <Строка>
//
Процедура Запуск(Знач АргументыCLI) Экспорт

	Если НужноВывестиСправку(АргументыCLI) Тогда
		ВывестиСправку();
		Возврат;
	КонецЕсли;

	ОчиститьАргументы(АргументыCLI);

	ПоследнийИндекс = ПолучитьОпцииИАргументы(АргументыCLI);

	Лог.Отладка("Количество входящих аргументов команды: %1", АргументыCLI.Количество());
	Лог.Отладка("Последний индекс аргументов команды: %1", ПоследнийИндекс);

	КонечныйИндексКоманды = ПоследнийИндекс;

	МассивАргументовКПарсингу = Новый Массив;

	Для ИИ = 0 По КонечныйИндексКоманды Цикл
		МассивАргументовКПарсингу.Добавить(АргументыCLI[ИИ]);
	КонецЦикла;

	Лог.Отладка("Читаю аргументы строки");
	ОшибкаЧтения = Не НачальноеСостояние.Прочитать(МассивАргументовКПарсингу);

	Если ОшибкаЧтения Тогда
		Лог.КритичнаяОшибка("Ошибка чтения параметров команды");
		ВывестиСправку();
		Возврат;
	КонецЕсли;

	ВыполнитьДействиеКоманды("ПередВыполнениемКоманды");

	Если КонечныйИндексКоманды = АргументыCLI.ВГраница() Тогда

		Лог.Отладка("Выполняю полезную работу %1", Имя);
		ВыполнитьДействиеКоманды("ВыполнитьКоманду");

		Возврат;
	КонецЕсли;

	ПервыйАргумент = АргументыCLI[КонечныйИндексКоманды + 1];

	Для каждого ВложеннаяКоманда Из ВложенныеКоманды Цикл

		Если ВложеннаяКоманда.ЭтоСинонимКоманды(ПервыйАргумент) Тогда

			АргументыПодкоманды = Новый Массив;
			СмещениеНачальногоИндекса = 2;

			НачальныйИндекс = КонечныйИндексКоманды + СмещениеНачальногоИндекса;

			Если НачальныйИндекс <= АргументыCLI.ВГраница() Тогда

				Для ИИ = НачальныйИндекс По АргументыCLI.ВГраница() Цикл
					АргументыПодкоманды.Добавить(АргументыCLI[ИИ]);
				КонецЦикла;

			КонецЕсли;

			ВложеннаяКоманда.НачалоЗапуска();
			ВложеннаяКоманда.Запуск(АргументыПодкоманды);

			ВыполнитьДействиеКоманды("ПослеВыполненияКоманды");

			Возврат;

		КонецЕсли;

	КонецЦикла;

	ВыполнитьДействиеКоманды("ПослеВыполненияКоманды");

	Если СтрНачинаетсяС(ПервыйАргумент, "-") Тогда
		ВывестиСправку();
		ВызватьИсключение "Не известная опция";

	КонецЕсли;

	ВывестиСправку();

	ВызватьИсключение "Вызвать исключение не корректное использование";

КонецПроцедуры

// Функция проверяет строку, что она является ли синонимом текущей команды
//
// Параметры:
//   СтрокаПроверки - строка - имя команды, для проверки
//
// Возвращаемое значение:
//   булево - истина. если это синоним или имя текущей команды, иначе ложь
Функция ЭтоСинонимКоманды(СтрокаПроверки) Экспорт
	Возврат Не Синонимы.Найти(СтрокаПроверки) = Неопределено;
КонецФункции

// Процедура подготавливает команды к запуску
// Формирует строку использования и
// настраивает парсер для выполнения парсинга входящих параметров
// Обязательно вызывается пред выполнением команды
Процедура НачалоЗапуска() Экспорт

	КомандыРодителиДляПодчиненной = Новый Массив;

	Для каждого КомандаРодитель Из КомандыРодители Цикл
		КомандыРодителиДляПодчиненной.Добавить(КомандаРодитель);
	КонецЦикла;

	КомандыРодителиДляПодчиненной.Добавить(ЭтотОбъект);

	Для каждого Подчиненнаякоманда Из ВложенныеКоманды Цикл
		Подчиненнаякоманда.КомандыРодители = КомандыРодителиДляПодчиненной;
	КонецЦикла;

	ДобавитьОпцииВИндекс();
	ДобавитьАргументыВИндекс();

	Лог.Отладка("Входящий спек: %1", Спек);

	Если ПустаяСтрока(Спек) Тогда

		Лог.Отладка("Количество опций строки: %1", Опции.Количество());
		Если Опции.Количество() > 0 Тогда
			Спек = "[ОПЦИИ] ";
		КонецЕсли;
		
		Если Аргументы.Количество() > 0 Тогда
			Спек = Спек + "-- ";
		КонецЕсли;

		Лог.Отладка("Количество аргументы строки: %1", Аргументы.Количество());
		Для каждого арг Из Аргументы Цикл
			
			ИмяАргумента = арг.Ключ.Имя;
			КлассАргумента = арг.Ключ;

			ДополнитьИмяАргументаМассива(ИмяАргумента, КлассАргумента);
			ДополнитьИмяАргументаНеобязательного(ИмяАргумента, КлассАргумента);
	
			Лог.Отладка("Добавляю аргумет <%1> в спек <%2>", ИмяАргумента, Спек);
			Спек = Спек + ИмяАргумента + " ";
		
		КонецЦикла;

	КонецЕсли;
	
	Лог.Отладка("Разбираю строку использования с помощью лексера");

	Лексер = Новый Лексер(Спек).Прочитать();
	Если Лексер.ЕстьОшибка() Тогда
		Лексер.ВывестиИнформациюОбОшибке();
		ВызватьИсключение "Ошибка разбора строки использования";
	КонецЕсли;

	ТокеныПарсера = Лексер.ПолучитьТокены();

	ПараметрыПарсера =  Новый Структура;
	ПараметрыПарсера.Вставить("Спек", Спек);
	ПараметрыПарсера.Вставить("Опции", Опции);
	ПараметрыПарсера.Вставить("Аргументы", Аргументы);
	ПараметрыПарсера.Вставить("ОпцииИндекс", ОпцииИндекс);
	ПараметрыПарсера.Вставить("АргументыИндекс", АргументыИндекс);

	Парсер = Новый Парсер(ТокеныПарсера, ПараметрыПарсера);
	НачальноеСостояние = парсер.Прочитать();

	ВывестиПутьПарсераВОтладке();

КонецПроцедуры

// Функция добавляет опцию команды и возвращает экземпляр данной опции
//
// Параметры:
//   Имя      - строка - имя опции, в строке допустимо задавать синоним через пробел, например "s some-opt"
//   Значение - строка - значение опции по умолчанию
//   Описание - объект - описание опции для справки.
//
// Возвращаемое значение:
//   ПараметрКоманды - Созданный параметр команды
//
// Дополнительно смотри справку по классу ПараметрКоманды
Функция Опция(Имя, Значение = "", Описание = "") Экспорт

	НоваяОпция = Новый ПараметрКоманды("опция", Имя, Значение, Описание);
	Опции.Вставить(НоваяОпция, НоваяОпция);

	Возврат НоваяОпция;

КонецФункции

// Функция добавляет аргумент команды и возвращает экземпляр данной аргумента
//
// Параметры:
//   Имя      - строка - имя аргумента, в строке допустимо использование только из БОЛЬШИХ латинских букв, например "ARG"
//   Значение - строка - значение аргумента по умолчанию
//   Описание - объект - описание аргумента для справки.
//
// Возвращаемое значение:
//   ПараметрКоманды - Созданный параметр команды
//
// Дополнительно смотри справку по классу ПараметрКоманды
Функция Аргумент(Имя, Значение = "", Описание = "") Экспорт

	НовыйАргумент = Новый ПараметрКоманды("аргумент", Имя, Значение, Описание);
	Аргументы.Вставить(НовыйАргумент, НовыйАргумент);

	Возврат НовыйАргумент;

КонецФункции

// Функция возвращает значение опции по переданному имени/синониму опции
//
// Параметры:
//   ИмяОпции - строка - имя или синоним опции
//
// Возвращаемое значение:
//   ПараметраКоманды, Неопределенно - класс опции, находящийся в индексе Опций команды
//										Неопределенно, в случае отсутствия в индексе опций с запрошенным именем 
Функция ОпцияИзИндекса(Знач ИмяОпции) Экспорт
	
	Если СтрНачинаетсяС(ИмяОпции, "-")
		Или СтрНачинаетсяС(ИмяОпции, "--") Тогда
		// Ничего не делаем переданы уже нормализированные опции
	Иначе
		Префикс = "-";
		Если СтрДлина(ИмяОпции) > 1 Тогда
				Префикс = "--";
		КонецЕсли;
		ИмяОпции = СтрШаблон("%1%2", Префикс, ИмяОпции);
	КонецЕсли;

	ОпцииИндекса = ОпцииИндекс[ИмяОпции];

	Возврат ОпцииИндекса;

КонецФункции

// Функция возвращает параметры команды для аргумента по переданному имени аргумента
//
// Параметры:
//   ИмяАргумента - строка - имя аргумента
//
// Возвращаемое значение:
//   ПараметраКоманды, Неопределенно - класс аргумента, находящийся в индексе Аргументов команды
//										Неопределенно, в случае отсутствия в индексе аргумента с запрошенным именем 
Функция АргументИзИндекса(Знач ИмяАргумента) Экспорт
	
	АргументИндекса = АргументыИндекс[ВРег(ИмяАргумента)];

	Возврат АргументИндекса;

КонецФункции

// Процедура устанавливает процедуру "ВыполнитьКоманду" выполнения для команды
//
// Параметры:
//   ОбъектРеализации - объект - класс, объект реализующий процедуру выполнения команды.
//   ИмяПроцедуры - строка - имя процедуры, отличное от стандартного "ВыполнитьКоманду"
//
Процедура УстановитьДействиеВыполнения(ОбъектРеализации, ИмяПроцедуры = "ВыполнитьКоманду") Экспорт

	РефлекторПроверки = ПолучитьРефлекторКласса(ОбъектРеализации);
	ЕстьМетод = РефлекторПроверки.ЕстьПроцедура(ИмяПроцедуры, 1);

	Если Не ЕстьМетод Тогда
		ВызватьИсключение НоваяИнформацияОбОшибке("Ошибка установки действия <ВыполнитьКоманду>. Объект <%1> не содержит требуемого метода <%2>", ОбъектРеализации, ИмяПроцедуры);
	КонецЕсли;

	ДелегатДействия = Делегаты.Создать(ОбъектРеализации, ИмяПроцедуры);
	ДобавитьВИндексДействиеКоманды("ВыполнитьКоманду", ДелегатДействия);

КонецПроцедуры

// Процедура устанавливает процедуру "ПередВыполнениемКоманды" выполнения для команды
// запускаемую перед выполнением "ВыполнитьКоманду"
//
// Параметры:
//   ОбъектРеализации - объект - класс, объект реализующий процедуру выполнения команды.
//   ИмяПроцедуры - строка - имя процедуры, отличное от стандартного "ПередВыполнениемКоманды"
//
Процедура УстановитьДействиеПередВыполнением(ОбъектРеализации, ИмяПроцедуры = "ПередВыполнениемКоманды") Экспорт

	Лог.Отладка("Установка метода: перед выполнением класс <%1> имя процедуры <%2>", ОбъектРеализации, ИмяПроцедуры);

	РефлекторПроверки = ПолучитьРефлекторКласса(ОбъектРеализации);
	ЕстьМетод = РефлекторПроверки.ЕстьПроцедура(ИмяПроцедуры, 1);

	Если Не ЕстьМетод Тогда
		ВызватьИсключение НоваяИнформацияОбОшибке("Ошибка установки действия <ПередВыполнениемКоманды>. Объект <%1> не содержит требуемого метода <%2>", ОбъектРеализации, ИмяПроцедуры);
	КонецЕсли;

	Лог.Отладка(" >> метод %2 у класс <%1> найден", ОбъектРеализации, ИмяПроцедуры);

	ДелегатДействия = Делегаты.Создать(ОбъектРеализации, ИмяПроцедуры);
	ДобавитьВИндексДействиеКоманды("ПередВыполнениемКоманды", ДелегатДействия);

КонецПроцедуры

// Процедура устанавливает процедуру "ПослеВыполненияКоманды" выполнения для команды
// запускаемую после выполнением "ВыполнитьКоманду"
//
// Параметры:
//   ОбъектРеализации - объект - класс, объект реализующий процедуру выполнения команды.
//   ИмяПроцедуры - строка - имя процедуры, отличное от стандартного "ПослеВыполненияКоманды"
//
Процедура УстановитьДействиеПослеВыполнения(ОбъектРеализации, ИмяПроцедуры = "ПослеВыполненияКоманды") Экспорт

	Лог.Отладка("Установка метода: после выполнением класс <%1> имя процедуры <%2>", ОбъектРеализации, ИмяПроцедуры);

	РефлекторПроверки = ПолучитьРефлекторКласса(ОбъектРеализации);
	ЕстьМетод = РефлекторПроверки.ЕстьПроцедура(ИмяПроцедуры, 1);

	Если Не ЕстьМетод Тогда
		ВызватьИсключение НоваяИнформацияОбОшибке("Ошибка установки действия <ПослеВыполненияКоманды>. Объект <%1> не содержит требуемого метода <%2>", ОбъектРеализации, ИмяПроцедуры);
	КонецЕсли;

	Лог.Отладка(" >> метод %2 у класс <%1> найден", ОбъектРеализации, ИмяПроцедуры);

	ДелегатДействия = Делегаты.Создать(ОбъектРеализации, ИмяПроцедуры);
	ДобавитьВИндексДействиеКоманды("ПослеВыполненияКоманды", ДелегатДействия);
	
КонецПроцедуры

// Процедура устанавливает процедуру "ВывестиСправку" для текущей команды
//
// Параметры:
//   ОбъектРеализации - объект - класс, объект реализующий процедуру вывода справки.
//   ИмяПроцедуры - строка - имя процедуры, отличное от стандартного "ВывестиСправку"
//
Процедура УстановитьДействиеВывестиСправку(ОбъектРеализации, ИмяПроцедуры = "ВывестиСправку") Экспорт

	Лог.Отладка("Установка метода: после выполнением класс <%1> имя процедуры <%2>", ОбъектРеализации, ИмяПроцедуры);

	РефлекторПроверки = ПолучитьРефлекторКласса(ОбъектРеализации);
	ЕстьМетод = РефлекторПроверки.ЕстьПроцедура(ИмяПроцедуры, 1);

	Если Не ЕстьМетод Тогда
		ВызватьИсключение НоваяИнформацияОбОшибке("Ошибка установки действия <ВывестиСправку>. Объект <%1> не содержит требуемого метода <%2>", ОбъектРеализации, ИмяПроцедуры);
	КонецЕсли;

	Лог.Отладка(" >> метод %2 у класс <%1> найден", ОбъектРеализации, ИмяПроцедуры);

	ДелегатДействия = Делегаты.Создать(ОбъектРеализации, ИмяПроцедуры);

	ДобавитьВИндексДействиеКоманды("ВывестиСправку", ДелегатДействия);
	
КонецПроцедуры

#Область Работа_с_входящими_аргументами

Процедура ОчиститьАргументы(АргументыCLI)

	НовыйМассивАргументов = Новый Массив;

	Для каждого арг Из АргументыCLI Цикл

		Если ПустаяСтрока(арг) Тогда
			Продолжить;
		КонецЕсли;

		НовыйМассивАргументов.Добавить(арг);

	КонецЦикла;

	АргументыCLI = Новый ФиксированныйМассив(НовыйМассивАргументов);

КонецПроцедуры

Функция ФлагУстановлен(Знач АргументыCLI, Знач Флаг)

	Если АргументыCLI.Количество() = 0 Тогда
		Возврат Ложь;
	КонецЕсли;

	Возврат АргументыCLI[0] = Флаг;

КонецФункции

Функция ПолучитьОпцииИАргументы(Знач АргументыCLI)

	ПоследнийИндекс = -1;
	Лог.Отладка("Приверяю аргументы. Количество %1", АргументыCLI.Количество());

	Для каждого ТекущийАргумент Из АргументыCLI Цикл

		Для каждого ВложеннаяКоманда Из ВложенныеКоманды Цикл

			Лог.Отладка("Ищу подчиненную команду %1", ВложеннаяКоманда.ПолучитьИмяКоманды());
			Если ВложеннаяКоманда.ЭтоСинонимКоманды(ТекущийАргумент) Тогда
				Лог.Отладка("Подчиненная команда %1 найдена", ВложеннаяКоманда.ПолучитьИмяКоманды());
				Возврат ПоследнийИндекс;
			КонецЕсли;

		КонецЦикла;

		ПоследнийИндекс = ПоследнийИндекс + 1;

	КонецЦикла;

	Возврат ПоследнийИндекс;

КонецФункции

#КонецОбласти

#Область Работа_с_индексом_опций_и_аргументов

Процедура ДобавитьОпцииВИндекс()

	Для каждого КлючЗначение Из Опции Цикл

		КлассОпции = КлючЗначение.Ключ;
		КлассОпции.ИзПеременнойОкружения();

		Для каждого ИмяПараметра Из КлассОпции.НаименованияПараметров Цикл

			ОпцииИндекс.Вставить(ИмяПараметра, КлассОпции);

		КонецЦикла;

	КонецЦикла;

КонецПроцедуры

Процедура ДобавитьАргументыВИндекс()

	Для каждого КлючЗначение Из Аргументы Цикл

		КлассАргумента = КлючЗначение.Ключ;
		КлассАргумента.ИзПеременнойОкружения();

		Для каждого ИмяПараметра Из КлассАргумента.НаименованияПараметров Цикл

				АргументыИндекс.Вставить(ИмяПараметра, КлассАргумента);

		КонецЦикла;

	КонецЦикла;

КонецПроцедуры

Функция ВыполнитьДействиеКоманды(ИмяДействия)

	ДелегатДействия = ИндексДействийКоманды[ИмяДействия];
	
	Если ДелегатДействия = Неопределено Тогда
		Возврат Ложь;
	КонецЕсли;

	ДелегатДействия.Исполнить(ЭтотОбъект);

	Возврат Истина;
	
КонецФункции

#КонецОбласти

#Область Работа_с_рефлектором_объектов

Функция ПолучитьРефлекторКласса(КлассПроверки)
	
	Если Не КлассПроверки = КлассРеализации Тогда
		
		Возврат	Новый РефлекторОбъекта(КлассРеализации);

	Иначе

		Возврат РасширенныйРефлектор;

	КонецЕсли;

КонецФункции

#КонецОбласти

#Область Работа_со_справкой

Функция НужноВывестиСправку(Знач АргументыCLI)

	Если АргументыCLI.Количество() = 0 Тогда
		Возврат Ложь;
	КонецЕсли;

	Лог.Отладка("Вывожу справку: %1", ФлагУстановлен(АргументыCLI, "--help"));
	Возврат ФлагУстановлен(АргументыCLI, "--help");

КонецФункции

Функция ПолучитьТаблицуДанныхДляСправки()
	
	Таблица = Новый ТаблицаЗначений;
	Таблица.Колонки.Добавить("Наименование");
	Таблица.Колонки.Добавить("Описание");
	Таблица.Колонки.Добавить("ПодробноеОписание");
	Таблица.Колонки.Добавить("ПеременнаяОкружения");
	Таблица.Колонки.Добавить("СкрытьЗначение");
	Таблица.Колонки.Добавить("НаименованияПараметров");
	Таблица.Колонки.Добавить("Значение");

	Возврат Таблица;

КонецФункции

Функция ТаблицаАргументовДляСправки()
	
	Если Аргументы.Количество() = 0  Тогда
		Возврат ПолучитьТаблицуДанныхДляСправки();
	КонецЕсли;

	ТаблицаАргументов = ПолучитьТаблицуАргументов();

	ОбработатьТаблицуПараметровДляСправки(ТаблицаАргументов);

	Возврат ТаблицаАргументов;
КонецФункции

Функция ТаблицаОпцийДляСправки()

	Если Опции.Количество() = 0  Тогда
		Возврат ПолучитьТаблицуДанныхДляСправки();
	КонецЕсли;

	ТаблицаОпций = ПолучитьТаблицуОпций();
		
	ОбработатьТаблицуПараметровДляСправки(ТаблицаОпций);

	Возврат ТаблицаОпций;

КонецФункции

Процедура ВывестиТаблицуСправки(ТаблицаДанных)
	
	ДобавочнаяДлинаДополнения = 3;

	ШаблонНаименования =  "  %1"+ Символы.Таб + "%2";
	
	Для каждого СтрокаТаблицы Из ТаблицаДанных Цикл

		Сообщить(СтрШаблон(ШаблонНаименования, СтрокаТаблицы.Наименование, СтрокаТаблицы.Описание));

		Если Не ПустаяСтрока(СтрокаТаблицы.ПодробноеОписание) Тогда
			
			СтрокаНаименования = СтрШаблон("  %2%1%", Символы.Таб, СтрокаТаблицы.Наименование);

			ДлинаДополнения = СтрДлина(СтрокаНаименования) + ДобавочнаяДлинаДополнения;
			МассивСтрок = СтрРазделить(СтрокаТаблицы.ПодробноеОписание, Символы.ПС, Ложь);

			Для каждого СтрокаОписания Из МассивСтрок Цикл
				ДопОписаниеСтроки = ДополнитьСтрокуПробеламиДо(СтрокаОписания, ДлинаДополнения);
				Сообщить(ДопОписаниеСтроки);
			КонецЦикла;

		КонецЕсли;

	КонецЦикла;

	Сообщить("");

КонецПроцедуры

Процедура ОбработатьТаблицуПараметровДляСправки(ТаблицаПараметров)
	
	МаксимальнаяДлина = 9;

	Для каждого СтрокаТаблицы Из ТаблицаПараметров Цикл

		СтрокаТаблицы.Наименование = ФорматироватьНаименованиеПараметраДляСправки(СтрокаТаблицы.НаименованияПараметров);
		СтрокаТаблицы.Описание = СформироватьОписаниеДляСправки(СтрокаТаблицы);
		МаксимальнаяДлина = Макс(МаксимальнаяДлина, СтрДлина(СтрокаТаблицы.Наименование) + 1);

	КонецЦикла;

	Для каждого СтрокаТаблицы Из ТаблицаПараметров Цикл

		ТекущаяДлина = СтрДлина(СтрокаТаблицы.Наименование);
		Если ТекущаяДлина = МаксимальнаяДлина Тогда
			Продолжить;
		КонецЕсли;

		СтрокаТаблицы.Наименование = ДополнитьСтрокуПробелами(СтрокаТаблицы.Наименование, МаксимальнаяДлина - ТекущаяДлина);

	КонецЦикла;

КонецПроцедуры

Функция СформироватьОписаниеДляСправки(СтрокаТаблицы)

	ПеременныеОкружения = ФорматироватьПеременнуюОкруженияОпцииДляСправки(СтрокаТаблицы.ПеременнаяОкружения);
	ЗначениеОпции = ФорматироватьЗначениеОпцииДляСправки(СтрокаТаблицы.Значение, СтрокаТаблицы.СкрытьЗначение);
	
	МассивСоединения = Новый Массив;
	МассивСоединения.Добавить(СтрокаТаблицы.Описание);
	Если Не ПустаяСтрока(ПеременныеОкружения) Тогда
		МассивСоединения.Добавить(ПеременныеОкружения);	
	КонецЕсли;
	Если Не ПустаяСтрока(ЗначениеОпции) Тогда
		МассивСоединения.Добавить(ЗначениеОпции);
	КонецЕсли;
	
	ОписаниеДляСправки = СтрСоединить(МассивСоединения, " ");

	Возврат ОписаниеДляСправки
	
КонецФункции

Функция ДополнитьСтрокуПробелами(Знач НачальнаяСтрока, КоличествоПробелов)

	Для Счетчик = 1 По КоличествоПробелов Цикл
		НачальнаяСтрока = НачальнаяСтрока + " ";
	КонецЦикла;

	Возврат НачальнаяСтрока;

КонецФункции

Функция ДополнитьСтрокуПробеламиДо(Знач НачальнаяСтрока, Знач КоличествоПробелов)

	СтрокаПробелов = "";

	Для Счетчик = 1 По КоличествоПробелов Цикл
		СтрокаПробелов = СтрокаПробелов + " ";
	КонецЦикла;

	Возврат СтрокаПробелов + НачальнаяСтрока;

КонецФункции

Функция ФорматироватьНаименованиеПараметраДляСправки(Знач НаименованияПараметров)

	ОграничениеДлины = 2;

	Если НаименованияПараметров.Количество() = 1 Тогда
		
		НаименованиеПараметра = НаименованияПараметров[0];

		Если Не СтрНачинаетсяС(НаименованиеПараметра, "-") Тогда
			Возврат НаименованиеПараметра;
		КонецЕсли;

		Если СтрДлина(НаименованиеПараметра) = ОграничениеДлины Тогда
			Возврат НаименованиеПараметра;
		Иначе 
			Возврат СтрШаблон("    %1", НаименованиеПараметра);
		КонецЕсли;	
	
	КонецЕсли;

	ПроцессорКоллекций = Новый ПроцессорКоллекций;
	ПроцессорКоллекций.УстановитьКоллекцию(НаименованияПараметров);
	СортированныеНаименования = ПроцессорКоллекций
		.Сортировать("Результат = СтрДлина(Элемент1) >  СтрДлина(Элемент2)")
		.Получить(Тип("Массив"));

	НаименованиеПараметра = СтрСоединить(СортированныеНаименования, ", ");

	Лог.Отладка("Наименование опции для справки <%1>", НаименованиеПараметра);

	Возврат НаименованиеПараметра;

КонецФункции

Функция ФорматироватьЗначениеОпцииДляСправки(Знач ЗначениеОпции, Знач СкрытьЗначение)

	Если СкрытьЗначение Тогда
		Возврат "";
	КонецЕсли;

	Возврат СтрШаблон("(по умолчанию %1)", ЗначениеОпции);

КонецФункции

Функция ФорматироватьПеременнуюОкруженияОпцииДляСправки(Знач ПеременнаяОкружения)

	Если ПустаяСтрока(СокрЛП(ПеременнаяОкружения)) Тогда
		Возврат "";
	КонецЕсли;

	СтрокаПеременнойОкружения = ПеременнаяОкружения;
	МассивПО = СтрРазделить(СтрокаПеременнойОкружения, " ", Ложь);

	Результат = "(env";

	СтрокаРазделитель = " ";

	Для ИИ = 0 По МассивПО.ВГраница() Цикл

		Если ИИ > 0  Тогда
			СтрокаРазделитель = ", ";
		КонецЕсли;

		Результат = Результат + СтрШаблон("%1$%2", СтрокаРазделитель, МассивПО[ИИ]);

	КонецЦикла;

	Возврат Результат + ")";

КонецФункции

#КонецОбласти

#Область Вспомогательные_процедуры_и_функции

Процедура ВывестиПутьПарсераВОтладке()

	Если Лог.Уровень() = УровниЛога.Отладка Тогда
		
		ОбработчикВыборкиПути = Новый ВыборСовпадений();
		Лог.Отладка("Вывожу текущий путь парсинга: ");
		Лог.Отладка(ОбработчикВыборкиПути.СгенеритьСтрокуПути(НачальноеСостояние));

	КонецЕсли;
	
КонецПроцедуры

// Дополняет признаком "[]" необязательности для аргумента
//
// Параметры:
//   ИмяАргумента - Строка - Имя аргумента
//   КлассАргумента - Класс - класс аргумента
//
Процедура ДополнитьИмяАргументаНеобязательного(ИмяАргумента, КлассАргумента)
	
	Если НЕ КлассАргумента.ПолучитьОбязательностьВвода() Тогда
		
		ИмяАргумента = СтрШаблон("[%1]", ИмяАргумента);

	КонецЕсли;
	
КонецПроцедуры

// Дополняет признаком "..." для аргумента массива
//
// Параметры:
//   ИмяАргумента - Строка - Имя аргумента
//   КлассАргумента - Класс - класс аргумента
//
Процедура ДополнитьИмяАргументаМассива(ИмяАргумента, КлассАргумента) 
	
	Если КлассАргумента.ЭтоМассив() Тогда
		
		ИмяАргумента = СтрШаблон("%1...", ИмяАргумента);

	КонецЕсли;
	
КонецПроцедуры

Процедура ДобавитьВИндексДействиеКоманды(ИмяДействия, ДелегатДействия)
	
	ИндексДействийКоманды.Вставить(ИмяДействия, ДелегатДействия);

КонецПроцедуры

Процедура УстановитьСтандартныеОбработчики(РеализованныеМетодыКоманды) 
	
	Если РеализованныеМетодыКоманды.ОписаниеКоманды Тогда
		КлассРеализации.ОписаниеКоманды(ЭтотОбъект);
	КонецЕсли;

	Если РеализованныеМетодыКоманды.ПередВыполнениемКоманды Тогда
		ДелегатДействия = Делегаты.Создать(КлассРеализации, "ПередВыполнениемКоманды");
		ДобавитьВИндексДействиеКоманды("ПередВыполнениемКоманды", ДелегатДействия);
	КонецЕсли;

	Если РеализованныеМетодыКоманды.ВыполнитьКоманду Тогда
		ДелегатДействия = Делегаты.Создать(КлассРеализации, "ВыполнитьКоманду");
		ДобавитьВИндексДействиеКоманды("ВыполнитьКоманду", ДелегатДействия);
	КонецЕсли;

	Если РеализованныеМетодыКоманды.ПослеВыполненияКоманды Тогда
		ДелегатДействия = Делегаты.Создать(КлассРеализации, "ПослеВыполненияКоманды");
		ДобавитьВИндексДействиеКоманды("ПослеВыполненияКоманды", ДелегатДействия);
	КонецЕсли;

	Если РеализованныеМетодыКоманды.ВывестиСправку Тогда
		ДелегатДействия = Делегаты.Создать(КлассРеализации, "ВывестиСправку");
		ДобавитьВИндексДействиеКоманды("ВывестиСправку", ДелегатДействия);
	КонецЕсли;

КонецПроцедуры

Функция НоваяИнформацияОбОшибке(Знач ТекстСообщения,
								Знач Параметр1 = Неопределено, Знач Параметр2 = Неопределено, Знач Параметр3 = Неопределено,
								Знач Параметр4 = Неопределено, Знач Параметр5 = Неопределено, Знач Параметр6 = Неопределено,
								Знач Параметр7 = Неопределено, Знач Параметр8 = Неопределено, Знач Параметр9 = Неопределено)

	Если Параметр1 <> Неопределено Тогда
		ТекстСообщения = СтрШаблон(ТекстСообщения, Параметр1,
			Параметр2, Параметр3, Параметр4, Параметр5, Параметр6, Параметр7, Параметр8, Параметр9);
	КонецЕсли;

	ИнфИсключение = Новый ИнформацияОбОшибке(ТекстСообщения, ЭтотОбъект);

	Возврат ИнфИсключение;

КонецФункции

Функция ПолучитьТаблицуОпций() Экспорт

	Возврат ПолучитьТаблицуПараметров(Опции);

КонецФункции

Функция ПолучитьТаблицуАргументов() Экспорт

	Возврат ПолучитьТаблицуПараметров(Аргументы);

КонецФункции

Функция ПолучитьТаблицуПараметров(ИндексПараметров)
	
	ТаблицаДанных = ПолучитьТаблицуДанныхДляСправки();

	Для каждого КлючЗначение Из ИндексПараметров Цикл

		ПараметрСправки = КлючЗначение.Ключ;

		НоваяЗапись = ТаблицаДанных.Добавить();

		НоваяЗапись.Наименование			= ПараметрСправки.Имя;
		НоваяЗапись.Описание				= ПараметрСправки.Описание;
		НоваяЗапись.ПодробноеОписание		= ПараметрСправки.ПолучитьПодробноеОписание();
		НоваяЗапись.ПеременнаяОкружения		= ПараметрСправки.ПеременнаяОкружения;
		НоваяЗапись.СкрытьЗначение			= ПараметрСправки.СкрытьЗначение;
		НоваяЗапись.НаименованияПараметров	= ПараметрСправки.НаименованияПараметров;
		НоваяЗапись.Значение 				= ПараметрСправки.ЗначениеВСтроку();

	КонецЦикла;

	Возврат ТаблицаДанных;

КонецФункции

#КонецОбласти

Процедура ПриСозданииОбъекта(ИмяКоманды, ОписаниеКоманды, КлассРеализацииКоманды, ПриложениеКоманды = Неопределено)

	Синонимы = СтрРазделить(ИмяКоманды, " ", Ложь);
	Имя = Синонимы[0];
	Описание = ОписаниеКоманды;
	КлассРеализации = КлассРеализацииКоманды;

	ВложенныеКоманды = Новый Массив;
	КомандыРодители = Новый Массив;
	Опции = Новый Соответствие;
	Аргументы = Новый Соответствие;

	ОпцииИндекс = Новый Соответствие;
	АргументыИндекс = Новый Соответствие;

	ИндексДействийКоманды = Новый Соответствие;

	Приложение = ПриложениеКоманды;

	Спек = "";
	ПодробноеОписание = "";

	РасширенныйРефлектор = Новый РефлекторОбъекта(КлассРеализации);

	ИнтерфейсКоманды = Новый ИнтерфейсОбъекта();
	ИнтерфейсКоманды.П("ОписаниеКоманды", 1)
					.П("ПередВыполнениемКоманды", 1)
					.П("ВыполнитьКоманду", 1)
					.П("ПослеВыполненияКоманды", 1)
					.П("ВывестиСправку", 1)
					;
	
	РеализованныеМетодыКоманды = РасширенныйРефлектор.РеализованныеМетодыИнтерфейса(ИнтерфейсКоманды);
	УстановитьСтандартныеОбработчики(РеализованныеМетодыКоманды);

КонецПроцедуры

Лог = Логирование.ПолучитьЛог("oscript.lib.cli_command");