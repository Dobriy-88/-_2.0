#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
	
#Область СлужебныеПроцедурыИФункции

Процедура ЗаполнитьГрафик(ДатаНачала, ДатаОкончания, ВыходныеДни, ГрафикРаботы) Экспорт 
	
	Набор = РегистрыСведений.ВКМ_ГрафикиРаботы.СоздатьНаборЗаписей();
	Набор.Отбор.ГрафикРаботы.Установить(ГрафикРаботы);
	Набор.Прочитать();
	
	ЧислоСекундВСутках = 86400;
	
	ДатаН = ДатаНачала;
	Для к = 0 По Набор.Количество() - 1 Цикл
		
		Запись = Набор[к];
		Если Запись.Дата < ДатаНачала Тогда
			Продолжить;
		ИначеЕсли Запись.Дата = ДатаН Тогда
			Запись.ГрафикРаботы = ГрафикРаботы;
			
			Если СтрНайти(ВыходныеДни, Строка(ДеньНедели(ДатаН))) Тогда
				Запись.Значение = 0;
			Иначе	          
				Запись.Значение = 1;
			КонецЕсли;
			
			ДатаН = ДатаН + ЧислоСекундВСутках;
		Иначе
			Пока ДатаН < Мин(Запись.Дата, ДатаОкончания) Цикл
				НоваяЗапись = Набор.Добавить();
				НоваяЗапись.Дата = ДатаН;
				НоваяЗапись.ГрафикРаботы = ГрафикРаботы;
				
				Если СтрНайти(ВыходныеДни, Строка(ДеньНедели(ДатаН))) Тогда
					НоваяЗапись.Значение = 0;
				Иначе	          
					НоваяЗапись.Значение = 1;
				КонецЕсли; 
				
				ДатаН = ДатаН + ЧислоСекундВСутках;
			КонецЦикла; 
			Если Запись.Дата > ДатаОкончания Тогда
				Прервать;
			Иначе
				Запись.ГрафикРаботы = ГрафикРаботы;
				
				Если СтрНайти(ВыходныеДни, Строка(ДеньНедели(ДатаН))) Тогда
					Запись.Значение = 0;
				Иначе	          
					Запись.Значение = 1;
				КонецЕсли;
			КонецЕсли;
			ДатаН = ДатаН + ЧислоСекундВСутках;
		КонецЕсли; 
	КонецЦикла;
	Набор.Записать();
	
	Пока ДатаН <= ДатаОкончания Цикл
		Запись = Набор.Добавить();
		Запись.Дата = ДатаН;
		Запись.ГрафикРаботы = ГрафикРаботы;
		
		Если СтрНайти(ВыходныеДни, Строка(ДеньНедели(ДатаН))) Тогда
			Запись.Значение = 0;
		Иначе	          
			Запись.Значение = 1;
		КонецЕсли; 
		
		ДатаН = ДатаН + ЧислоСекундВСутках;
	КонецЦикла; 
	
	Набор.Записать();
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли