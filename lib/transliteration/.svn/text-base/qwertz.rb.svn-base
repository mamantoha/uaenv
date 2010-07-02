# encoding: utf-8

# Text is converted as if it typed with wrong language selected on en/ua qwerty winkeys keyboard. Non-cyrillic characters also converted.
#
module UaEnv::Transliteration::QWERTY

  UA_LOWER = %w{ й ц у к е н г ш щ з х ї ф і в а п р о л д ж є я ч с м и т ь б ю . }
  UA_UPPER = %w{ Й Ц У К Е Н Г Ш Щ З Х Ї Ф І В А П Р О Л Д Ж Є Я Ч С М И Т Ь Б Ю , }
  UA = UA_LOWER + UA_UPPER

  LAT_LOWER = %w{ q w e r t y u i o p [ ] a s d f g h j k l ; ' z x c v b n m , . /  }
  LAT_UPPER = %w{ Q W E R T Y U I O P { } A S D F G H J K L : " Z X C V B N M < > ?  }
  LAT = LAT_LOWER + LAT_UPPER

  TABLE_LAT_KEYS = {}
  LAT.each_with_index { |char, index| TABLE_LAT_KEYS[char] = UA[index] }

  TABLE_UA_KEYS = {}
  UA.each_with_index { |char, index| TABLE_UA_KEYS[char] = LAT[index] }


  # Просто замінює символи набрані латиницею у відповідні кириличні символи
  def self.decode_ua(str)
    chars = str.split(//)
    result = ''
    chars.each{ |char| result << ( LAT.include?(char) ? TABLE_LAT_KEYS[char] : char ) }
    
    return result
  end

  # Просто замінює символи набрані кирилицею у відповідні латинські символи
  def self.decode_lat(str)
    chars = str.split(//)
    result = ''
    chars.each { |char| result << ( UA.include?(char) ? TABLE_UA_KEYS[char] : char ) }
    
    return result
  end

end
