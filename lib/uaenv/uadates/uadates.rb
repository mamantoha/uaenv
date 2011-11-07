# encoding: utf-8

require 'date'

module UaEnv

  module UaDates
    UA_MONTHNAMES = [nil] + %w{ січень лютий березень квітень травень червень липень серпень вересень жовтень листопад грудень }
    UA_DAYNAMES = %w(неділя понеділок вівторок середа червер п'ятниця субота)
    UA_ABBR_MONTHNAMES = [nil] + %w{ січ лют бер кві тра чер лип сер вер жов лис гру }
    UA_ABBR_DAYNAMES = %w(нд пн вт ср чт пт сб)
    UA_INFLECTED_MONTHNAMES = [nil] + %w{ січня лютого березня квітня травня червня липня серпня вересня жовтня листопада грудня }
    UA_DAYNAMES_E = [nil] + %w{перше друге третє четверте п'яте шосте сьоме восьме дев'яте десяте одинадцяте дванадцяте тринадцяте чотирнадцяте п'ятнадцяте шістнадцяте сімнадцяте вісімнадцяте дев'ятнадцяте двадцяте двадцять тридцяте тридцять}

    # http://www.ruby-doc.org/core-1.9.3/Time.html#method-i-strftime
    # http://ruby-doc.org/stdlib-1.9.3/libdoc/date/rdoc/DateTime.html#method-i-strftime
    # Literal string:
    #   %% - Literal ``%'' character
    #
    # http://unicode.org/reports/tr20/tr20-1.html
    # U+FFFC  Object replacement character
    # офіційно застосовується для позначення вкладеного об'єкту
    @@ignored = [0xEF, 0xBF, 0xBC].pack("U*").freeze 

    def self.ua_strftime(format='%d.%m.%Y', time='')
      clean_fmt = format.to_s.gsub(/%%/, @@ignored).
        gsub(/%a/, UA_ABBR_DAYNAMES[time.wday]).
        gsub(/%A/, UA_DAYNAMES[time.wday]).
        gsub(/%b/, UA_ABBR_MONTHNAMES[time.mon]).
        gsub(/%d(\s)*%B/, time.day.to_s + '\1' + UA_INFLECTED_MONTHNAMES[time.mon]).
        gsub(/%B/, UA_MONTHNAMES[time.mon]).
        gsub(@@ignored, '%%')
    end

  end # module UaDates

end # module UaEnv

class Time
  alias_method :strftime_nouaenv, :strftime
  
  def strftime(format)
    UaEnv::UaDates::ua_strftime(format, self)
    #strftime_nouaenv(format)
  end
end

class DateTime
  alias_method :strftime_nouaenv, :strftime
  
  def strftime(format)
    UaEnv::UaDates::ua_strftime(format, self)
    #strftime_nouaenv(format)
  end
end
