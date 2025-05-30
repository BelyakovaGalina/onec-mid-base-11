#Область ПрограммныйИнтерфейс

Процедура ДополнитьФорму(Форма) Экспорт
// ++ БелГН Задача 01 07.05.2025
	ИмяФормы = Форма.ИмяФормы;            
	
	Если ИмяФормы = "Документ.ЗаказПокупателя.Форма.ФормаДокумента" Тогда
		ДобавитьПолеКонтактноеЛицоВГруппуШапкаПраво(Форма);
		ДобавитьГруппуСогласованнаяСкидкаВГруппуШапкаЛево(Форма);
		ДобавитьПолеСтатусЗаказаВГруппуШапкаЛево(Форма);
	ИначеЕсли ИмяФормы = "Документ.ЗаказПокупателя.Форма.ФормаСписка" Тогда
		ВставитьПолеСтатусЗаказа(Форма);
	ИначеЕсли ИмяФормы = "Документ.ПоступлениеТоваровУслуг.Форма.ФормаДокумента" Тогда
		ДобавитьПолеКонтактноеЛицоВГруппуШапкаПраво(Форма);
	ИначеЕсли ИмяФормы = "Документ.РеализацияТоваровУслуг.Форма.ФормаДокумента" Тогда
		ДобавитьПолеКонтактноеЛицоВГруппуШапкаПраво(Форма);
	ИначеЕсли ИмяФормы = "Документ.ОплатаОтПокупателя.Форма.ФормаДокумента" Тогда
		ВставитьПолеКонтактноеЛицоВГруппуШапкаПраво(Форма, Форма.Элементы.Основание);
	ИначеЕсли ИмяФормы = "Документ.ОплатаПоставщику.Форма.ФормаДокумента" Тогда
		ВставитьПолеКонтактноеЛицоВГруппуШапкаПраво(Форма, Форма.Элементы.СуммаДокумента);
	КонецЕсли;
// --
КонецПроцедуры
	
#КонецОбласти        

#Область СлужебныйПрограммныйИнтерфейс

Процедура ДобавитьПолеКонтактноеЛицоВГруппуШапкаПраво(Форма) Экспорт
// ++ БелГН Задача 01 07.05.2025
	ПолеВвода = Форма.Элементы.Добавить("КонтактноеЛицо",Тип("ПолеФормы"),Форма.Элементы.ГруппаШапкаПраво);
	ПолеВвода.Вид = ВидПоляФормы.ПолеВвода;
	ПолеВвода.ПутьКДанным = "Объект.ДК_КонтактноеЛицо";
// --
КонецПроцедуры

Процедура ДобавитьПолеСтатусЗаказаВГруппуШапкаЛево(Форма) Экспорт
// ++ БелГН Задача 12-4 11.05.2025
	ПолеВвода = Форма.Элементы.Добавить("СтатусЗаказа",Тип("ПолеФормы"),Форма.Элементы.ГруппаШапкаЛево);
	ПолеВвода.Вид = ВидПоляФормы.ПолеВвода;
	ПолеВвода.ПутьКДанным = "Объект.ДК_СтатусЗаказа";
// --
КонецПроцедуры

Процедура ВставитьПолеСтатусЗаказа(Форма) Экспорт
// ++ БелГН Задача 12-4 11.05.2025
	Форма.Список.ТекстЗапроса = СтрЗаменить(Форма.Список.ТекстЗапроса,
			"ДокументЗаказПокупателя.Номер КАК Номер,","	ДокументЗаказПокупателя.Номер КАК Номер," + 
	Символы.ПС+ "	ДокументЗаказПокупателя.ДК_СтатусЗаказа КАК ДК_СтатусЗаказа,");
	
	ДобавляемоеПоле = Форма.Элементы.Вставить("СтатусЗаказа",Тип("ПолеФормы"),,Форма.Элементы.Список);
	ДобавляемоеПоле.ПутьКДанным = "Список.ДК_СтатусЗаказа";   
	ДобавляемоеПоле.ЦветТекста =  WebЦвета.Красный;
// --
КонецПроцедуры

Процедура ДобавитьГруппуСогласованнаяСкидкаВГруппуШапкаЛево(Форма) Экспорт
// ++ БелГН Задача 02 07.05.2025
	ГруппаСкидки = Форма.Элементы.Добавить("ГруппаСогласоватьСкидку",Тип("ГруппаФормы"),Форма.Элементы.ГруппаШапкаЛево);
	ГруппаСкидки.Вид = ВидГруппыФормы.ОбычнаяГруппа;
	ГруппаСкидки.Заголовок = "Группа согласовать скидку";
	ГруппаСкидки.ОтображатьЗаголовок = Ложь;

	ПолеВвода = Форма.Элементы.Добавить("ДК_СогласованнаяСкидка",Тип("ПолеФормы"),ГруппаСкидки);
	ПолеВвода.Вид = ВидПоляФормы.ПолеВвода;
	ПолеВвода.ПутьКДанным = "Объект.ДК_СогласованнаяСкидка";
	ПолеВвода.УстановитьДействие("ПриИзменении","ДК_СогласованнаяСкидкаПриИзменении");

	КомандаПерерасчета = Форма.Команды.Добавить("ПересчитатьСумму");
	КомандаПерерасчета.Заголовок = "Пересчитать сумму";
	КомандаПерерасчета.Действие = "ДК_КомандаПересчитатьСумму"; 
	КомандаПерерасчета.Картинка = БиблиотекаКартинок.Обновить;
	КомандаПерерасчета.Отображение = ОтображениеКнопки.КартинкаИТекст; 
	
	КнопкаКоманды = Форма.Элементы.Добавить("КнопкаПересчитатьСумму",Тип("КнопкаФормы"),ГруппаСкидки);
	КнопкаКоманды.ИмяКоманды = "ПересчитатьСумму";
	КнопкаКоманды.Вид = ВидКнопкиФормы.ОбычнаяКнопка;
// --
КонецПроцедуры

Процедура ВставитьПолеКонтактноеЛицоВГруппуШапкаПраво(Форма,СледующаяКнопка) Экспорт
// ++ БелГН Задача 01 07.05.2025
	ПолеВвода = Форма.Элементы.Вставить("КонтактноеЛицо",Тип("ПолеФормы"),,СледующаяКнопка);
	ПолеВвода.Вид = ВидПоляФормы.ПолеВвода;
	ПолеВвода.ПутьКДанным = "Объект.ДК_КонтактноеЛицо";
// --
КонецПроцедуры
	
#КонецОбласти