# encoding: utf-8

module UaEnv

  module DateTime

    # http://unicode.org/reports/tr20/tr20-1.html
    # U+FFFC  Object replacement character
    # офіційно застосовується для позначення вкладеного об'єкту
    @@ignored = [0xEF, 0xBF, 0xBC].pack("U*").freeze 

    def self.ua_strftime(date='%d.%m.%Y', time='')
      date.gsub!(/%%/, @@ignored)
      date.gsub!(/%a/, Date::UA_ABBR_DAYNAMES[time.wday])
      date.gsub!(/%A/, Date::UA_DAYNAMES[time.wday])
      date.gsub!(/%b/, Date::UA_ABBR_MONTHNAMES[time.mon])
      date.gsub!(/%d(\s)*%B/, time.day.to_s + '\1' + Date::UA_INFLECTED_MONTHNAMES[time.mon])
      date.gsub!(/%B/, Date::UA_MONTHNAMES[time.mon])
      date.gsub!(@@ignored, '%%')
    end

  end # module DateTime

end # module UaEnv

class Date
  UA_MONTHNAMES = [nil] + %w{ січень лютий березень квітень травень червень липень серпень вересень жовтень листопад грудень }
  UA_DAYNAMES = %w(неділя понеділок вівторок середа червер п'ятниця субота)
  UA_ABBR_MONTHNAMES = [nil] + %w{ січ лют бер кві тра чер лип сер вер жов лис гру }
  UA_ABBR_DAYNAMES = %w(нд пн вт ср чт пт сб)
  UA_INFLECTED_MONTHNAMES = [nil] + %w{ січня лютого березня квітня травня червня липня серпня вересня жовтня листопада грудня }
  UA_DAYNAMES_E = [nil] + %w{перше друге третє четверте п'яте шосте сьоме восьме дев'яте десяте одинадцяте дванадцяте тринадцяте чотирнадцяте п'ятнадцяте шістнадцяте сімнадцяте вісімнадцяте дев'ятнадцяте двадцяте двадцять тридцяте тридцять}
end

class Time
  alias_method :strftime_nouaenv, :strftime
  
  def strftime(date)
    UaEnv::DateTime::ua_strftime(date, self)
    strftime_nouaenv(date)
  end
end
