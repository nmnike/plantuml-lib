﻿
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Параметры.Свойство("База", База);
	
	МетаданныеБазы = Метаданные;	
	СписокОбъектов = Неопределено;
		
	// Создать корень.
	ЭлементыКорня = ДеревоПодсистем.ПолучитьЭлементы();
	Корень = ЭлементыКорня.Добавить();
	Корень.Подсистема = МетаданныеБазы.Имя;
	
	// Добавить в корень подсистемы.
	ДополнитьДеревоОбъектами(МетаданныеБазы, 
		Корень.ПолучитьЭлементы(), 
		МетаданныеБазы.Подсистемы, 
		СписокОбъектов);
	
	Если ТипЗнч(СписокОбъектов) = Тип("СписокЗначений") Тогда
		ЭлементыВерхнегоУровня = ДеревоПодсистем.ПолучитьЭлементы();	
		ОтметитьПоОбъектамРекурсивно(ЭлементыВерхнегоУровня, СписокОбъектов);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ОтметитьПоОбъектамРекурсивно(Знач ЭлементыДерева, Знач РезультатОтбора)
	
	Для Каждого ЭлементДерева Из ЭлементыДерева Цикл
		ПодчиненныеЭлементыДерева = ЭлементДерева.ПолучитьЭлементы();
		
		Если ПодчиненныеЭлементыДерева.Количество() > 0 Тогда
			ОтметитьПоОбъектамРекурсивно(ПодчиненныеЭлементыДерева, РезультатОтбора);
		Иначе
			Если РезультатОтбора.НайтиПоЗначению(ЭлементДерева.ПолноеИмя) <> Неопределено Тогда
				ОтметитьТекущиеДанныеНаСервере(ЭлементДерева, 1);
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура ДополнитьДеревоОбъектами(МетаданныеБазы, ЭлементыДерева, Знач ОбъектыМетаданных, Знач СписокОбъектов = Неопределено)
	
	Для Каждого ОбъектМетаданных Из ОбъектыМетаданных Цикл
		
		Элемент = ЭлементыДерева.Добавить();
		Элемент.Подсистема = ОбъектМетаданных.Имя;
		Элемент.КартинкаОбъекта = БиблиотекаКартинок.РежимПросмотраСпискаИерархическийСписок;
		Элемент.ПолноеИмя = ОбъектМетаданных.ПолноеИмя();
		
		ДополнитьДеревоОбъектами(МетаданныеБазы, 
			Элемент.ПолучитьЭлементы(), 
			ОбъектМетаданных.Подсистемы);
		
		Если СписокОбъектов <> Неопределено Тогда
			Если СписокОбъектов.НайтиПоЗначению(Элемент.ПолноеИмя) <> Неопределено Тогда
				Элемент.Отметка = 1;
				
				ОтметитьТекущиеДанныеНаСервере(Элемент);
			КонецЕсли;
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура ДеревоОтметкаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.ДеревоПодсистем.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ОтметитьТекущиеДанные(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура ОтметитьТекущиеДанные(ТекущиеДанные)
	
	// Отметку 3-го состояния флажка не разрешаем.
	ТекущиеДанные.Отметка = ?(ТекущиеДанные.Отметка = 2, 0, ТекущиеДанные.Отметка);
	
	// Безусловные отметки всем подчиненным элементам.
	УстановитьОтметки(ТекущиеДанные, "Вниз");
	
	// И определенные отметки всем родителям.
	УстановитьОтметки(ТекущиеДанные, "Вверх");
	
КонецПроцедуры

&НаСервере
Процедура ОтметитьТекущиеДанныеНаСервере(ТекущиеДанные, Отметка = Неопределено)
	
	Если Отметка <> Неопределено Тогда
		ТекущиеДанные.Отметка = Отметка;
	КонецЕсли;
	
	// Отметку 3-го состояния флажка не разрешаем.
	ТекущиеДанные.Отметка = ?(ТекущиеДанные.Отметка = 2, 0, ТекущиеДанные.Отметка);
	
	// Безусловные отметки всем подчиненным элементам.
	УстановитьОтметкиНаСервере(ТекущиеДанные, "Вниз");
	
	// И определенные отметки всем родителям.
	УстановитьОтметкиНаСервере(ТекущиеДанные, "Вверх");
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьОтметки(ТекущиеДанные, Знач Направление)
	
	Если Направление = "Вниз" Тогда
		ДочерниеЭлементы = ТекущиеДанные.ПолучитьЭлементы();
		
		Для Каждого ЭлементДерева Из ДочерниеЭлементы Цикл
			ЭлементДерева.Отметка = ТекущиеДанные.Отметка;
			
			УстановитьОтметки(ЭлементДерева, Направление);
		КонецЦикла;
	Иначе
		ЭлементРодителя = ТекущиеДанные.ПолучитьРодителя();
		Если ЭлементРодителя = Неопределено Тогда
			Возврат;
		КонецЕсли;
		
		ДочерниеЭлементы = ЭлементРодителя.ПолучитьЭлементы();
		МаксимальнаяОтметка = 0;
		МинимальнаяОтметка = 3;
		
		Для Каждого ЭлементДерева Из ДочерниеЭлементы Цикл
			МаксимальнаяОтметка = Макс(МаксимальнаяОтметка, ЭлементДерева.Отметка);
			МинимальнаяОтметка = Мин(МинимальнаяОтметка, ЭлементДерева.Отметка);
		КонецЦикла;
		
		Если МаксимальнаяОтметка = 0 Тогда
			НоваяОтметка = 0;
		ИначеЕсли МинимальнаяОтметка = МаксимальнаяОтметка Тогда
			НоваяОтметка = 1;
		Иначе
			НоваяОтметка = 2;
		КонецЕсли;
		
		ЭлементРодителя.Отметка = НоваяОтметка;
		
		УстановитьОтметки(ЭлементРодителя, Направление);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьОтметкиНаСервере(ТекущиеДанные, Знач Направление)
	
	Если Направление = "Вниз" Тогда
		ДочерниеЭлементы = ТекущиеДанные.ПолучитьЭлементы();
		
		Для Каждого ЭлементДерева Из ДочерниеЭлементы Цикл
			ЭлементДерева.Отметка = ТекущиеДанные.Отметка;
			
			УстановитьОтметкиНаСервере(ЭлементДерева, Направление);
		КонецЦикла;
	Иначе
		ЭлементРодителя = ТекущиеДанные.ПолучитьРодителя();
		Если ЭлементРодителя = Неопределено Тогда
			Возврат;
		КонецЕсли;
		
		ДочерниеЭлементы = ЭлементРодителя.ПолучитьЭлементы();
		МаксимальнаяОтметка = 0;
		МинимальнаяОтметка = 3;
		
		Для Каждого ЭлементДерева Из ДочерниеЭлементы Цикл
			МаксимальнаяОтметка = Макс(МаксимальнаяОтметка, ЭлементДерева.Отметка);
			МинимальнаяОтметка = Мин(МинимальнаяОтметка, ЭлементДерева.Отметка);
		КонецЦикла;
		
		Если МаксимальнаяОтметка = 0 Тогда
			НоваяОтметка = 0;
		ИначеЕсли МинимальнаяОтметка = МаксимальнаяОтметка Тогда
			НоваяОтметка = 1;
		Иначе
			НоваяОтметка = 2;
		КонецЕсли;
		
		ЭлементРодителя.Отметка = НоваяОтметка;
		
		УстановитьОтметкиНаСервере(ЭлементРодителя, Направление);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ВыбратьОбъекты(Команда)
	
	СписокОбъектов = ПолучитьСписокОбъектовПодсистем();
	
	Закрыть(СписокОбъектов);
	
КонецПроцедуры

&НаСервере
Функция ПолучитьСписокОбъектовПодсистем()
		
	МетаданныеБазы = Метаданные;
	СписокОбъектовМетаданных = Новый СписокЗначений;
	
	СписокПодсистем = Новый СписокЗначений;
	СписокОтмеченныхПодсистем(ДеревоПодсистем.ПолучитьЭлементы(), СписокПодсистем);
	
	// Дополним список объектов выбранными подсистемами.
	СписокОбъектовМетаданных.ЗагрузитьЗначения(СписокПодсистем.ВыгрузитьЗначения());
	
	// Затем дополним список объектов объектами метаданных, входящими в состав выбранных подсистем.
	Для Каждого ЭлементСписка Из СписокПодсистем Цикл
		ОбъектПодсистемы = МетаданныеБазы.НайтиПоПолномуИмени(ЭлементСписка.Значение);
		Если ОбъектПодсистемы = Неопределено Тогда
			Продолжить;
		КонецЕсли;
		
		Для Каждого ОбъектМетаданных Из ОбъектПодсистемы.Состав Цикл
			ПолноеИмяОбъекта = ОбъектМетаданных.ПолноеИмя();
			
			Если СписокОбъектовМетаданных.НайтиПоЗначению(ПолноеИмяОбъекта) = Неопределено Тогда
				СписокОбъектовМетаданных.Добавить(ПолноеИмяОбъекта);
			КонецЕсли;
		КонецЦикла;
	КонецЦикла;
	
	СписокОбъектовМетаданных.СортироватьПоЗначению();
	
	Возврат СписокОбъектовМетаданных;
	
КонецФункции

&НаСервере
Процедура СписокОтмеченныхПодсистем(Знач ЭлементыДерева, СписокПодсистем)
	
	Для Каждого ЭлементДерева Из ЭлементыДерева Цикл
		Если ЭлементДерева.Отметка = 0 Тогда
			Продолжить;
		КонецЕсли;
		
		Если ЭлементДерева.Отметка = 1 Тогда
			СписокПодсистем.Добавить(ЭлементДерева.ПолноеИмя);
		КонецЕсли;
		
		СписокОтмеченныхПодсистем(ЭлементДерева.ПолучитьЭлементы(), СписокПодсистем);
	КонецЦикла;
	
КонецПроцедуры