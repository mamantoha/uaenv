# encoding: utf-8

# Функція схиляє прізвище, ім'я і по батькові в
# давальний відмінок. Наразі функція потребує серйозних доопрацювань!
#
# * Деякі українські прізвища з очевидною семантикою (наприклад Кіт, Чорновіл, Кривоніс, Білокінь) просто не підлягають відмінюванню за правилами.


module UaEnv::FIO

  # Схиляє прізвища, імені і по батькові (ПІП) у давальний відмінок ("кому? чому?").
  # Приведений код може містити неточності, ви можете вільно використовувати його на власний розсуд.
  # Тестування продовжується. Присилайте свої відгуки і зауваження.
  # (1.9)
  def self.dative_case(first_name, second_name, patronymic)
    if !first_name.empty? && !second_name.empty? && !patronymic.empty?
      if patronymic[-1] == 'ч'
        # Схиляння чоловічого прізвища
        first_name = male_first_name_dative_case(first_name)
        # Схиляння імені чоловіка
        second_name = male_second_name_dative_case(second_name)
        # Схилення по батькові
        patronymic = patronymic + 'у'
      else
        # Схилення жіночого прізвища
        first_name = female_first_name_dative_case(first_name)
        # Схиляння жіночого імені
        second_name = female_second_name_dative_case(second_name)
        # Схилення по батькові
        patronymic = patronymic[0..-2] + 'ій'
      end
    else
      # Якийсь із параметрів порожній.
    end
    return first_name, second_name, patronymic
  end

  private

  # Схилення чоловічого імені у давальний відмінок
  # (1.9)
  #
  def self.male_second_name_dative_case(second_name)
    case second_name[-1]
    when /й|ь/
      # Сергі(й) => Сергі(ю)
      second_name = second_name[0..-2] + "ю"
    when /а|я/
      # Сан(я) => Сан(і)
      second_name = second_name[0..-2] + "і"
    when /о/
      # Михайл(о) => Михайл(у)
      second_name = second_name[0..-2] + "у"
    else
      # Антон => Антон(у)
      second_name = second_name + "у"
    end

    return second_name
  end

  # Схилення чоловічого прізвища у давальний відмінок
  # (1.9)
  def self.male_first_name_dative_case(first_name)
    case first_name[-1]
    when /й/
      if (first_name[-2] =~ /и/)
        # Гладки(й) => Гладк(ому)
        first_name = first_name[0..-3] + "ому"
      else
        # Водол(і)(й) => Водолі(ю)
        first_name = first_name[0..-2] + "ю"
      end
    when /о/
      # Головченк(о) => Головченк(у)
      first_name = first_name[0..-2] + "у"
    when /а|я/
      # Всі прізвища які закінчуються на а, перед яким йдуть голосні букви(найчастіше у), не відміняються
      # Гал(у)(а) => Галуа
      if first_name[-2] =~ /у/
        # Нічого не робити
      else
        # Зол(а) => Зол(і)
        first_name = first_name[0..-2] + "і"
      end
    when /і|е|є|у|и|ю/
      # Всі прізвище з е, є, у, і, и, ю на кінці не відмінюються
      # Дал(і) => Далі
    else
      # Так схиляються всі типові чоловічі прізвища
      first_name = first_name + "у"
    end

    return first_name
  end

  # Схилення жіночого прізвища у давальний відмінок
  # (1.9)
  #
  def self.female_first_name_dative_case(first_name)
    case first_name[-1]
      when /о|и|і|й|б|в|г|д|ж|з|к|л|м|н|п|р|с|т|ф|х|ц|ч|ш|щ|ь/
        # Нічого не робити
      when /я/
        # Гмир(я) => Гмир(і)
        first_name = first_name[0..-2] + "і"
      when /а/
        if first_name[-3..-2] == "ав"
          # Перевірка деяких грузинських прізвищ
          first_name = first_name[0..-2] + "і"
        elsif first_name[-2] =~ /у/
          # Нічого не робити
          # Мар(у)(а) => Маруа
        else
          first_name = first_name[0..-2] + "ій"
        end
      else
        # Мамінов(а) => Мамінов(ій)
        first_name = first_name[0..-2] + "ій"
      end

    return first_name
  end

  # Схилення жіночого імені у давальний відмінок
  # (1.9)
  #
  def self.female_second_name_dative_case(second_name)
    case second_name[-1]
    when /а|я/
      if second_name[-2] =~ /і|о/
        # Мар(і)(я)=> Марі(ї)
        second_name = second_name[0..-2] + "ї"
      elsif second_name[-2] == "к"
        # Марин(к)(а)=> Марин(ці)
        second_name = second_name[0..-3] + "ці"
      else
        # Кат(я) => Кат(і)
        second_name = second_name[0..-2] + "і"
      end
    when /в/
      # Любо(в) => Любов(і)
      second_name = second_name + "і"
    end

    return second_name
  end

end
