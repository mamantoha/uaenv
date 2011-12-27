# encoding: utf-8

# Норма ISO 9, 1995 р.
# Зокрема, застосовується в Німеччині для обов'язкового транслітерування українських прізвищ та імен
# в офіційних документах (паперів при виїзді з України в Німеччину для постійного проживання).
# Приклад транслітерації: «Олександр Віталійович Рибальченко» = "Oleksandr Vìtalìjovič Ribal´čenko"
#
module UaEnv::Transliteration::ISO9A

  UA_UPPER = %w{ А Б В Г Ґ Д Е Є Ж З И І Ї Й К Л М Н О П Р С Т У Ф Х Ц Ч Ш Щ Ю Я Ь ʼ }
  UA_LOWER = %w{ а б в г ґ д е є ж з и і ї й к л м н о п р с т у ф х ц ч ш щ ю я ь ʼ }
  UA = UA_LOWER + UA_UPPER
  ISO9_LOWER = ['a', 'b', 'v', 'g', 'ģ', 'd', 'e', 'ê', 'ž', 'z', 'i', 'ì', 'ï', 'j', 'k', 'l', 'm',
    'n', 'o', 'p', 'r', 's', 't', 'u', 'f', 'h', 'c', 'č', 'š', 'ŝ', 'û', 'â', 'ʹ', 'ʼ']
  # VIM : select text and gU
  ISO9_UPPER = ['A', 'B', 'V', 'G', 'Ģ', 'D', 'E', 'Ê', 'Ž', 'Z', 'I', 'Ì', 'Ï', 'J', 'K', 'L', 'M',
    'N', 'O', 'P', 'R', 'S', 'T', 'U', 'F', 'H', 'C', 'Č', 'Š', 'Ŝ', 'Û', 'Â', 'ʹ', 'ʼ']
  ISO9 = ISO9_LOWER + ISO9_UPPER

  TABLE = {}
  UA.each_with_index { |char, index| TABLE[char] = ISO9[index] }

  def self.translify(str)
    chars = str.split(//)

    result = ''
    chars.each_with_index do |char, index|
      variant = (index != 0 ? ( chars[index - 1] == " " ? 1 : 0 ) : 1) # Воно ту нафік не здалось :) Варіантів нема.

      if UA_UPPER.include?(char) && UA_LOWER.include?(chars[index+1])
        # "Яна" => "Âna"
        ch = (TABLE[char].is_a?(Array) ? TABLE[char][variant].downcase.capitalize : TABLE[char].downcase.capitalize)
        result << ch

      elsif UA_UPPER.include?(char)
        # "ЯНА" => "ÂNA"
        ch = (TABLE[char].is_a?(Array) ? TABLE[char][variant] : TABLE[char] )
        result << ch

      elsif UA_LOWER.include?(char)
        # "яна" => "âna"
        ch = (TABLE[char].is_a?(Array) ? TABLE[char][variant] : TABLE[char] )
        result << ch

      else
        result << char
      end

    end
    return result
  end
end

module UaEnv::Transliteration::ISO9B

  UA_UPPER = %w{ А Б В Г Ґ Д Е Є Ж З И І Ї Й К Л М Н О П Р С Т У Ф Х Ц Ч Ш Щ Ю Я Ь ’ }
  UA_LOWER = %w{ а б в г ґ д е є ж з и і ї й к л м н о п р с т у ф х ц ч ш щ ю я ь ’ }
  UA = UA_LOWER + UA_UPPER
  ISO9_LOWER = ['a', 'b', 'v', 'g', 'g`', 'd', 'e', 'ye', 'zh', 'z', 'y`', 'i', 'yi', 'j', 'k', 'l', 'm',
    'n', 'o', 'p', 'r', 's', 't', 'u', 'f', 'x', ['cz', 'c'], 'ch', 'sh', 'shh', 'yu', 'ya', '`', '\'']

  ISO9_UPPER = ISO9_LOWER.map{ |i| i.is_a?( Array ) ? i.map{ |j| j.upcase } : i.upcase }
  
  ISO9 = ISO9_LOWER + ISO9_UPPER

  TABLE = {}
  UA.each_with_index { |char, index| TABLE[char] = ISO9[index] }

  def self.translify(str)
    chars = str.split(//)

    result = ''
    chars.each_with_index do |char, index|
      # variant == 1 - рекомендується використовувати C перед буквами I, Е, Y, J
      # variant == 0 - в інших випадках CZ
      if char =~ /[ц]/i and chars[index + 1] =~ /[еєйіїяю]/i
        variant = 1
      else
        variant = 0
      end

      if UA_UPPER.include?(char) && UA_LOWER.include?(chars[index+1])
        ch = (TABLE[char].is_a?(Array) ? TABLE[char][variant].downcase.capitalize : TABLE[char].downcase.capitalize)
        result << ch

      elsif UA_UPPER.include?(char)
        ch = (TABLE[char].is_a?(Array) ? TABLE[char][variant] : TABLE[char] )
        result << ch

      elsif UA_LOWER.include?(char)
        ch = (TABLE[char].is_a?(Array) ? TABLE[char][variant] : TABLE[char] )
        result << ch

      else
        result << char
      end

    end
    return result
  end

end
