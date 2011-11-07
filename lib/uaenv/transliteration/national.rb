# encoding: utf-8

# ** Notes for the Ukrainian National system
# Transliteration can be rendered in a simplified form: 
# 1. Doubled consonants ж, х, ц, ч, ш are simplified, for example Запоріжжя Zaporizhia.
# 2. Apostrophe and soft sign are omitted, except for ьо and ьї which are always rendered as ’o and ’i.
# 3. gh is used in the romanization of зг (zgh), avoiding confusion with ж (zh).
# 4. The second variant is used at the beginning of a word.


module UaEnv::Transliteration::National

  UA_UPPER = %w{ А Б В Г Ґ Д Е Є Ж З И І Ї Й К Л М Н О П Р С Т У Ф Х Ц Ч Ш Щ Ю Я Ь ' }
  UA_LOWER = %w{ а б в г ґ д е є ж з и і ї й к л м н о п р с т у ф х ц ч ш щ ю я ь ' }

  UA = UA_LOWER + UA_UPPER

  NATIONAL_LOWER   = ['a', 'b', 'v', ['h', 'gh'], 'g', 'd',
                      'e', ['ie','ye'], 'zh', 'z', 'y', 'i',
                      ['i','yi'], ['i','y'], 'k', 'l', 'm', 'n',
                      'o', 'p', 'r', 's', 't', 'u',
                      'f', 'kh', 'ts', 'ch', 'sh', 'sch',
                      ['iu','yu'], ['ia','ya'], '\'', '"'
                     ]

  NATIONAL_UPPER = NATIONAL_LOWER.map{ |i| i.is_a?( Array ) ? i.map{ |j| j.upcase } : i.upcase }

  NATIONAL = NATIONAL_LOWER + NATIONAL_UPPER

  TABLE = {}
  UA.each_with_index {|char,index| TABLE[char] = NATIONAL[index]}


  # Просто замінює кирилицю в строці на латиницю
  def self.translify(str)
    chars = str.split(//)

    result = ''
    chars.each_with_index do | char, index |
      variant = (index != 0 ? ( chars[index - 1] == " " ? 1 : 0 ) : 1)
      if UA_UPPER.include?(char) && UA_LOWER.include?(chars[index+1])
        # "Яна" => "Yana"
        ch = (TABLE[char].is_a?(Array) ? TABLE[char][variant].downcase.capitalize : TABLE[char].downcase.capitalize)
        result << ch

      elsif UA_UPPER.include?(char)
        # "ЯНА" => "YANA"
        ch = (TABLE[char].is_a?(Array) ? TABLE[char][variant] : TABLE[char] )
        result << ch

      elsif UA_LOWER.include?(char)
        # "яна" => "yana"
        ch = (TABLE[char].is_a?(Array) ? TABLE[char][variant] : TABLE[char] )
        result << ch

      else
        result << char
      end

    end
    return result

  end


end
