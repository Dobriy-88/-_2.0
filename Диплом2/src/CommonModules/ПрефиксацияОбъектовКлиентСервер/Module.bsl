///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2022, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Удаляет префикс информационной базы и префикс организации из переданной строки НомерОбъекта.
// Переменная НомерОбъекта должна соответствовать шаблону: ООГГ-ХХХ...ХХ или ГГ-ХХХ...ХХ, где:
//    ОО - префикс организации;
//    ГГ - префикс информационной базы;
//    "-" - разделитель;
//    ХХХ...ХХ - номер/код объекта.
// Незначащие символы префиксов (символ ноль - "0") также удаляются.
//
// Параметры:
//    НомерОбъекта - Строка - номер или код объекта из которого требуется удалить префиксы.
//    УдалитьПрефиксОрганизации - Булево - признак удаления префикса организации;
//                                         по умолчанию равен Ложь.
//    УдалитьПрефиксИнформационнойБазы - Булево - признак удаления префикса информационной базы;
//                                                по умолчанию равен Ложь.
//
// Возвращаемое значение:
//     Строка - номер объекта без префиксов.
//
// Пример:
//    УдалитьПрефиксыИзНомераОбъекта("0ФГЛ-000001234", Истина, Истина) = "000001234"
//    УдалитьПрефиксыИзНомераОбъекта("0ФГЛ-000001234", Ложь, Истина)   = "Ф-000001234"
//    УдалитьПрефиксыИзНомераОбъекта("0ФГЛ-000001234", Истина, Ложь)   = "ГЛ-000001234"
//    УдалитьПрефиксыИзНомераОбъекта("0ФГЛ-000001234", Ложь, Ложь)     = "ФГЛ-000001234"
//
Функция УдалитьПрефиксыИзНомераОбъекта(Знач НомерОбъекта, УдалитьПрефиксОрганизации = Ложь, УдалитьПрефиксИнформационнойБазы = Ложь) Экспорт
	
	Если Не НомерСодержитСтандартныйПрефикс(НомерОбъекта) Тогда
		Возврат НомерОбъекта;
	КонецЕсли;
	
	// Изначально пустая строка префикса номера объекта.
	ПрефиксОбъекта = "";
	
	НомерСодержитПятизначныйПрефикс = НомерСодержитПятизначныйПрефикс(НомерОбъекта);
	
	Если НомерСодержитПятизначныйПрефикс Тогда
		ПрефиксОрганизации        = Лев(НомерОбъекта, 2);
		ПрефиксИнформационнойБазы = Сред(НомерОбъекта, 3, 2);
	Иначе
		ПрефиксОрганизации = "";
		ПрефиксИнформационнойБазы = Лев(НомерОбъекта, 2);
	КонецЕсли;
	
	ПрефиксОрганизации        = СтроковыеФункцииКлиентСервер.УдалитьПовторяющиесяСимволы(ПрефиксОрганизации, "0");
	ПрефиксИнформационнойБазы = СтроковыеФункцииКлиентСервер.УдалитьПовторяющиесяСимволы(ПрефиксИнформационнойБазы, "0");
	
	// Добавляем префикс организации.
	Если Не УдалитьПрефиксОрганизации Тогда
		
		ПрефиксОбъекта = ПрефиксОбъекта + ПрефиксОрганизации;
		
	КонецЕсли;
	
	// Добавляем префикс информационной базы.
	Если Не УдалитьПрефиксИнформационнойБазы Тогда
		
		ПрефиксОбъекта = ПрефиксОбъекта + ПрефиксИнформационнойБазы;
		
	КонецЕсли;
	
	Если Не ПустаяСтрока(ПрефиксОбъекта) Тогда
		
		ПрефиксОбъекта = ПрефиксОбъекта + "-";
		
	КонецЕсли;
	
	Возврат ПрефиксОбъекта + Сред(НомерОбъекта, ?(НомерСодержитПятизначныйПрефикс, 6, 4));
КонецФункции

// Удаляет лидирующие нули из номера объекта.
// Переменная НомерОбъекта должна соответствовать шаблону: ООГГ-ХХХ...ХХ или ГГ-ХХХ...ХХ, где.
// ОО - префикс организации;
// ГГ - префикс информационной базы;
// "-" - разделитель;
// ХХХ...ХХ - номер/код объекта.
//
// Параметры:
//    НомерОбъекта - Строка - номер или код объекта из которого требуется лидирующие нули.
// 
// Возвращаемое значение:
//     Строка - номер объекта без лидирующих нулей.
//
Функция УдалитьЛидирующиеНулиИзНомераОбъекта(Знач НомерОбъекта) Экспорт
	
	ПользовательскийПрефикс = ПользовательскийПрефикс(НомерОбъекта);
	
	Если НомерСодержитСтандартныйПрефикс(НомерОбъекта) Тогда
		
		Если НомерСодержитПятизначныйПрефикс(НомерОбъекта) Тогда
			Префикс = Лев(НомерОбъекта, 5);
			Номер = Сред(НомерОбъекта, 6 + СтрДлина(ПользовательскийПрефикс));
		Иначе
			Префикс = Лев(НомерОбъекта, 3);
			Номер = Сред(НомерОбъекта, 4 + СтрДлина(ПользовательскийПрефикс));
		КонецЕсли;
		
	Иначе
		
		Префикс = "";
		Номер = Сред(НомерОбъекта, 1 + СтрДлина(ПользовательскийПрефикс));
		
	КонецЕсли;
	
	// Удаляем лидирующие нули слева в номере.
	Номер = СтроковыеФункцииКлиентСервер.УдалитьПовторяющиесяСимволы(Номер, "0");
	
	Возврат Префикс + ПользовательскийПрефикс + Номер;
КонецФункции

// Удаляет все пользовательские префиксы из номера объекта (все нецифровые символы).
// Переменная НомерОбъекта должна соответствовать шаблону: ООГГ-ХХХ...ХХ или ГГ-ХХХ...ХХ, где.
// ОО - префикс организации;
// ГГ - префикс информационной базы;
// "-" - разделитель;
// ХХХ...ХХ - номер/код объекта.
//
// Параметры:
//     НомерОбъекта - Строка - номер или код объекта из которого требуется лидирующие нули.
// 
// Возвращаемое значение:
//     Строка - номер объекта без пользовательских префиксов.
//
Функция УдалитьПользовательскиеПрефиксыИзНомераОбъекта(Знач НомерОбъекта) Экспорт
	
	СтрокаЦифровыхСимволов = "0123456789";
	
	Если НомерСодержитСтандартныйПрефикс(НомерОбъекта) Тогда
		
		Если НомерСодержитПятизначныйПрефикс(НомерОбъекта) Тогда
			Префикс     = Лев(НомерОбъекта, 5);
			НомерПолный = Сред(НомерОбъекта, 6);
		Иначе
			Префикс     = Лев(НомерОбъекта, 3);
			НомерПолный = Сред(НомерОбъекта, 4);
		КонецЕсли;
		
	Иначе
		
		Префикс     = "";
		НомерПолный = НомерОбъекта;
		
	КонецЕсли;
	
	Номер = "";
	
	Для Индекс = 1 По СтрДлина(НомерПолный) Цикл
		
		Символ = Сред(НомерПолный, Индекс, 1);
		
		Если СтрНайти(СтрокаЦифровыхСимволов, Символ) > 0 Тогда
			Номер = Сред(НомерПолный, Индекс);
			Прервать;
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат Префикс + Номер;
КонецФункции

// Получает пользовательский префикс номера/кода объекта.
// Переменная НомерОбъекта должна соответствовать шаблону: ООГГ-ААХ...ХХ или ГГ-ААХ...ХХ, где.
// ОО - префикс организации;
// ГГ - префикс информационной базы;
// "-" - разделитель;
// АА - пользовательский префикс;
// ХХ..ХХ - номер/код объекта.
//
// Параметры:
//    НомерОбъекта - Строка - номер или код объекта из которого требуется получить пользовательский префикс.
// 
// Возвращаемое значение:
//     Строка - пользовательский префикс.
//
Функция ПользовательскийПрефикс(Знач НомерОбъекта) Экспорт
	
	// Возвращаемое значение функции (пользовательский префикс).
	Результат = "";
	
	Если НомерСодержитСтандартныйПрефикс(НомерОбъекта) Тогда
		
		Если НомерСодержитПятизначныйПрефикс(НомерОбъекта) Тогда
			НомерОбъекта = Сред(НомерОбъекта, 6);
		Иначе
			НомерОбъекта = Сред(НомерОбъекта, 4);
		КонецЕсли;
		
	КонецЕсли;
	
	СтрокаЦифровыхСимволов = "0123456789";
	
	Для Индекс = 1 По СтрДлина(НомерОбъекта) Цикл
		
		Символ = Сред(НомерОбъекта, Индекс, 1);
		
		Если СтрНайти(СтрокаЦифровыхСимволов, Символ) > 0 Тогда
			Прервать;
		КонецЕсли;
		
		Результат = Результат + Символ;
		
	КонецЦикла;
	
	Возврат Результат;
КонецФункции

// Получает номер документа для вывода на печать; из номера удаляются префиксы и лидирующие нули.
// Функция:
// отбрасывает префикс организации,
// отбрасывает префикс информационной базы (опционально),
// отбрасывает пользовательские префиксы (опционально),
// удаляет лидирующие нули в номере объекта.
//
// Параметры:
//    НомерОбъекта - Строка - номер или код объекта, который преобразуется для вывода на печать.
//    УдалитьПрефиксИнформационнойБазы - Булево - признак удаления префикса информационной базы.
//    УдалитьПользовательскийПрефикс - Булево - признак удаления пользовательского префикса.
//
// Возвращаемое значение:
//     Строка - номер на печать.
//
Функция НомерНаПечать(Знач НомерОбъекта, УдалитьПрефиксИнформационнойБазы = Ложь, УдалитьПользовательскийПрефикс = Ложь) Экспорт
	
	// {Обработчик: ПриПолученииНомераНаПечать} Начало
	СтандартнаяОбработка = Истина;
	
	ПрефиксацияОбъектовКлиентСерверПереопределяемый.ПриПолученииНомераНаПечать(НомерОбъекта, СтандартнаяОбработка,
		УдалитьПрефиксИнформационнойБазы, УдалитьПользовательскийПрефикс);
	
	Если СтандартнаяОбработка = Ложь Тогда
		Возврат НомерОбъекта;
	КонецЕсли;
	// {Обработчик: ПриПолученииНомераНаПечать} Окончание
	
	НомерОбъекта = СокрЛП(НомерОбъекта);
	
	// Удаляем пользовательские префиксы из номера объекта.
	Если УдалитьПользовательскийПрефикс Тогда
		
		НомерОбъекта = УдалитьПользовательскиеПрефиксыИзНомераОбъекта(НомерОбъекта);
		
	КонецЕсли;
	
	// Удаляем лидирующие нули из номера объекта.
	НомерОбъекта = УдалитьЛидирующиеНулиИзНомераОбъекта(НомерОбъекта);
	
	// Удаляем префикс организации и префикс информационной базы из номера объекта.
	НомерОбъекта = УдалитьПрефиксыИзНомераОбъекта(НомерОбъекта, Истина, УдалитьПрефиксИнформационнойБазы);
	
	Возврат НомерОбъекта;
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция НомерСодержитСтандартныйПрефикс(Знач НомерОбъекта)
	
	ПозицияРазделителя = СтрНайти(НомерОбъекта, "-");
	
	Возврат (ПозицияРазделителя = 3 Или ПозицияРазделителя = 5);
	
КонецФункции

Функция НомерСодержитПятизначныйПрефикс(Знач НомерОбъекта)
	
	Возврат СтрНайти(НомерОбъекта, "-") = 5;
	
КонецФункции

#КонецОбласти
