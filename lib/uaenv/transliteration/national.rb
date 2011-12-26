# encoding: utf-8

# http://zakon2.rada.gov.ua/laws/show/55-2010-%EF

module UaEnv::Transliteration::National

  UA_UPPER = %w{ А Б В Г Ґ Д Е Є Ж З И І Ї Й К Л М Н О П Р С Т У Ф Х Ц Ч Ш Щ Ю Я Ь ' }
  UA_LOWER = %w{ а б в г ґ д е є ж з и і ї й к л м н о п р с т у ф х ц ч ш щ ю я ь ' }


  NATIONAL_LOWER   =
    [ 'a', 'b', 'v', 'h', 'g', 'd', 'e', ['ie','ye'], 'zh', ['z', 'zg'], 'y',
      'i', ['i','yi'], ['i','y'], 'k', 'l', 'm', 'n', 'o', 'p', 'r', 's',
      't', 'u', 'f', 'kh', 'ts', 'ch', 'sh', 'shch', ['iu','yu'], ['ia','ya'], '', '' ]

  NATIONAL_UPPER = NATIONAL_LOWER.map{ |i| i.is_a?( Array ) ? i.map{ |j| j.upcase } : i.upcase }

  UA       = UA_LOWER + UA_UPPER
  NATIONAL = NATIONAL_LOWER + NATIONAL_UPPER

  TABLE = {}
  UA.each_with_index { |char, index| TABLE[char] = NATIONAL[index] }

  def self.translify(str)
    chars = str.split(//)

    result = ''
    chars.each_with_index do | char, index |
      # variant == 1 - [єїйюя] на початку слова або буквосполучення 'зг'
      # variant == 0 - [єїйюя] в інших позиціях
      if char =~ /[з]/i and chars[index + 1] =~ /[г]/i
        variant = 1
      elsif char =~ /[єїйюя]/i and ( index == 0 or chars[index - 1] == " " )
        variant = 1
      else
        variant = 0
      end

      if UA_UPPER.include?(char) and UA_LOWER.include?(chars[index + 1])
        # "Яна" => "Yana"
        ch = ( TABLE[char].is_a?(Array) ? TABLE[char][variant].downcase.capitalize : TABLE[char].downcase.capitalize )
        result << ch
      elsif UA_UPPER.include?(char)
        # "ЯНА" => "YANA"
        ch = ( TABLE[char].is_a?(Array) ? TABLE[char][variant] : TABLE[char] )
        result << ch
      elsif UA_LOWER.include?(char)
        # "яна" => "yana"
        ch = ( TABLE[char].is_a?(Array) ? TABLE[char][variant] : TABLE[char] )
        result << ch
      else
        result << char
      end
    end

    return result
  end
end
