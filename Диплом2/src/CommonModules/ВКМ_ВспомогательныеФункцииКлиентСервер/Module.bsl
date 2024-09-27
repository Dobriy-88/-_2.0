
#Область СлужебныеПроцедурыИФункции

Функция РеквизитыДоговораСтрокой(Номер, Дата, ВидДоговора) Экспорт
	
	НаименованиеДоговора = Новый Массив;
	
	Если ЗначениеЗаполнено(ВидДоговора) Тогда
		Если ВидДоговора = ПредопределенноеЗначение("Перечисление.ВидыДоговоровКонтрагентов.Покупатель") Тогда
			НаименованиеДоговора.Добавить("Договор продажи");
		ИначеЕсли ВидДоговора = ПредопределенноеЗначение("Перечисление.ВидыДоговоровКонтрагентов.Поставщик") Тогда
			НаименованиеДоговора.Добавить("Договор поставки");
		ИначеЕсли ВидДоговора = ПредопределенноеЗначение("Перечисление.ВидыДоговоровКонтрагентов.ВКМ_Абонент") Тогда
			НаименованиеДоговора.Добавить("Абонентский договор");
		КонецЕсли;
	КонецЕсли;
	
	Если ЗначениеЗаполнено(Номер) Тогда
		НаименованиеДоговора.Добавить("№ " + СокрЛП(Номер));
	КонецЕсли;
	
	Если ЗначениеЗаполнено(Дата) Тогда
		НаименованиеДоговора.Добавить(СтрШаблон(НСтр("ru = 'от %1 г.'"), Формат(Дата, "ДЛФ=D")));
	КонецЕсли;
	
	Возврат СтрСоединить(НаименованиеДоговора, " ");
	
КонецФункции

#КонецОбласти