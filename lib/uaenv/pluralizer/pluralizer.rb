# encoding: utf-8

module UaEnv

  module Pluralization #:nodoc:

    # Вибирає потрібний відмінок в залежності від числа
    def self.choose_plural( amount, *variants )
      variant = ( (amount % 10 == 1 && amount % 100 != 11) ? ( 1 ) : ( amount % 10 >= 2 && amount % 10 <= 4 && (amount % 100 < 10 || amount % 100 >= 20) ) ? 2 : 3 )

      variants[variant - 1]
    end # self.choose_plural

    def self.grn( amount )
      pts = []
      pts << UaEnv::Pluralization::sum_string( amount.to_i, 2, "гривня", "гривні", "гривень" ) unless amount.to_i == 0

      if amount.kind_of?( Float )
        remainder = ( amount.divmod(1)[1] * 100 ).round

        if ( remainder == 100 )
          pts = [UaEnv::Pluralization::sum_string(amount.to_i+1, 2, 'гривня', 'гривні', 'гривень')]
        else
          pts << UaEnv::Pluralization::sum_string(remainder.to_i, 2, 'копійка', 'копійки', 'копійок')
        end

      end
      pts.join(' ')
    end # self.grn

    #  Виконує перетворення числа з цифрового виду в символьний
    #  (amount, gender, one_item='', two_items='', five_items='')
    #    amount - числівник
    #    gender   = 1 - чоловічий, = 2 - жіночий, = 3 - середній
    #    one_item - називний відмінок однини (= 1)
    #    two_items - родовий відмінок однини (= 2-4)
    #    five_items - родовий відмінок множини ( = 5-10)
    def self.sum_string(amount, gender, one_item='', two_items='', five_items='')
      into = ''
      tmp_val ||= 0

      return "нуль " + five_items if amount == 0

      tmp_val = amount

      # одиниці
      into, tmp_val = sum_string_fn(into, tmp_val, gender, one_item, two_items, five_items)

      return into if tmp_val == 0

      # тисячі
      into, tmp_val = sum_string_fn(into, tmp_val, 2, "тисяча", "тисячі", "тисяч")

      return into if tmp_val == 0

      # мільйони
      into, tmp_val = sum_string_fn(into, tmp_val, 1, "мільйон", "мільйона", "мільйонів")

      return into if tmp_val == 0

      # мільярдів
      into, tmp_val = sum_string_fn(into, tmp_val, 1, "мільярд", "мільярда", "мільярдів")

      return into
    end # self.sum_string

    private
    def self.sum_string_fn(into, tmp_val, gender, one_item='', two_items='', five_items='')
      rest, rest1, end_word, ones, tens, hundreds = [nil]*6
      #
      rest = tmp_val % 1000
      tmp_val = tmp_val / 1000
      if rest == 0
        # останні три знаки нульові
        into = five_items + " " if into == ""
        return [into, tmp_val]
      end
      #
      # починаємо підрахунок з Rest
      end_word = five_items
      # сотні
      hundreds = case rest / 100
        when 0 then ""
        when 1 then "сто "
        when 2 then "двісті "
        when 3 then "триста "
        when 4 then "чотириста "
        when 5 then "п'ятсот "
        when 6 then "шістсот "
        when 7 then "сімсот "
        when 8 then "вісімсот "
        when 9 then "дев'ятсот "
      end

      # десятки
      rest = rest % 100
      rest1 = rest / 10
      ones = ""
      case rest1
        when 0 then tens = ""
        when 1 # особливий випадок
          tens = case rest
            when 10 then "десять "
            when 11 then "одинадцять "
            when 12 then "дванадцять "
            when 13 then "тринадцять "
            when 14 then "чотирнадцять "
            when 15 then "п'ятнадцять "
            when 16 then "шістнадцять "
            when 17 then "сімнадцять "
            when 18 then "вісімнадцять "
            when 19 then "дев'ятнадцять "
          end
        when 2 then tens = "двадцять "
        when 3 then tens = "тридцять "
        when 4 then  tens = "сорок "
        when 5 then tens = "п'ятдесят "
        when 6 then tens = "шістдесят "
        when 7 then tens = "сімдесят "
        when 8 then tens = "вісімдесят "
        when 9 then tens = "дев'яносто "
      end
      #

      if rest1 < 1 or rest1 > 1 # одиниці
        case rest % 10
          when 1
            ones = case gender
              when 1 then "один "
              when 2 then "одна "
              when 3 then "одне "
            end
            end_word = one_item
          when 2
            if gender == 2
              ones = "дві "
            else
              ones = "два "
            end
            end_word = two_items
          when 3
            ones = "три " if end_word = two_items
          when 4
            ones = "чотири " if end_word = two_items
          when 5
            ones = "п'ять "
          when 6
            ones = "шість "
          when 7
            ones = "сім "
          when 8
            ones = "вісім "
          when 9
            ones = "дев'ять "
        end
      end

      # складання строки
      st = ''
      return [(st << hundreds.to_s << tens.to_s  << ones.to_s << end_word.to_s << " " << into.to_s).strip, tmp_val]
    end # def self.sum_string_fn


    # Реалізує вивід прописом будь-якого об'єкта, що реалізує Float
    module FloatFormatting
      # Повертає суму прописом із врахуванням дробової частини. Дробова частина закруглюється до мільйонної, або (якщо
      # дробова частина закінчується нулями) до  найближчої долі (500 тисячних закруглюється до 5 десятих).
      # Додатковий аргумент - рід іменника (1 - чоловічий, 2 - жіночий, 3 - середній)
      def propysom(gender = 2)
        raise "Це не число!" if self.nan?
        st = UaEnv::Pluralization::sum_string(self.to_i, gender, "ціла", "цілих", "цілих")

        remainder = self.to_s.match(/\.(\d+)/)[1]

        signs = remainder.to_s.size - 1

        it = [["десята", "десятих"]]
        it << ["сота", "сотих"]
        it << ["тисячна", "тисячних"]
        it << ["десятитисячна", "десятитисячних"]
        it << ["стотисячна", "стотисячних"]
        it << ["мільйонна", "мільйонних"]
        it << ["десятиммільйонна", "десятимільйонних", "десятимільйонних"]
        it << ["стомільнна", "стомільйонних", "стомільйонних"]
        it << ["мільярдна", "мільярдних", "мільярдних"]
        it << ["десятимільярдна", "десятимільярдних", "десятимільярдних"]
        it << ["стомільярдна", "стомільярдних", "стомільярдних"]
        it << ["трильйонна", "трильйонних", "трильйонних"]

        while it[signs].nil?
          remainder = (remainderi/10).round
          signs = remainder.to_s.size - 1
        end

        suf1, suf2, suf3 = it[signs][0], it[signs][1], it[signs][2]
        st + " " + UaEnv::Pluralization::sum_string(remainder.to_i, 2, suf1, suf2, suf2)
      end


      def propysom_items(gender=1, *forms)
        if self == self.to_i
          return self.to_i.propysom_items(gender, *forms)
        else
          self.propysom(gender) + " " + forms[1]
        end
      end



    end # module FloatFormatting


    # Реалізує вивід прописом будь-якого об'єкта, що реалізує Numeric
    module NumericFormatting
      # Вибирає коректний варіант числівника в залежності від роду і числа і оформляє суму прописом
      #   234.propysom => "двісті сорок три"
      #   221.propysom(2) => "двісті двадцять одна"
      def propysom(gender = 1)
        UaEnv::Pluralization::sum_string(self, gender, "")
      end

      def propysom_items(gender=1, *forms)
        self.propysom(gender) + " " + UaEnv::Pluralization::choose_plural(self.to_i, *forms)
      end

      # Вибирає коректний варіант числівника у залежності від роду і числа. Наприклад:
      # * 4.items("монітор", "монітори", "моніторів") => "монітори"
      def items(one_item, two_items, five_items)
        UaEnv::Pluralization::choose_plural(self, one_item, two_items, five_items)
      end

      # Виводить суму у гривнях прописом. Наприклад:
      # * (128.83).grn => "сто двадцять вісім гривень вісімдесят три копійки"
      def grn
        UaEnv::Pluralization::grn(self)
      end
    end # module NumericFormatting

  end # module Pluralization

end # module UaEnv


class Object::Numeric
  include UaEnv::Pluralization::NumericFormatting
end


class Object::Float
  include UaEnv::Pluralization::FloatFormatting
end
