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

    # http://apidock.com/rails/ActionView/Helpers/DateHelper/distance_of_time_in_words
    def self.distance_of_time_in_words(from_time, to_time = 0, include_seconds = false, options = {})
      from_time = from_time.to_time if from_time.respond_to?(:to_time)
      to_time = to_time.to_time if to_time.respond_to?(:to_time)
      distance_in_minutes = (((to_time - from_time).abs)/60).round
      distance_in_seconds = ((to_time - from_time).abs).round

      case distance_in_minutes
        when 0..1
          return (distance_in_minutes == 0) ?
            'менше хвилини' :
            '1 хвилину' unless include_seconds

        case distance_in_seconds
           when 0..5   then 'менше 5 секунд'
           when 6..10  then 'менше 10 секунд'
           when 11..20 then 'менше 20 секунд'
           when 21..40 then 'півхвилини'
           when 41..59 then 'менше хвилини'
           else             '1 хвилину'
         end

         when 2..45      then distance_in_minutes.to_s +
                              " " + distance_in_minutes.items("хвилина", "хвилини", "хвилин")
         when 46..90     then 'близько години'

         when 90..1440   then "близько " + (distance_in_minutes.to_f / 60.0).round.to_s +
                              " " + (distance_in_minutes.to_f / 60.0).round.items("години", 'годин', 'годин')
         when 1441..2880 then '1 день'
         else                  (distance_in_minutes / 1440).round.to_s +
                              " " + (distance_in_minutes / 1440).round.items("день", "дні", "днів")
         end
    end


  end # module UaDates

end # module UaEnv

class Time
  #alias_method :strftime_nouaenv, :strftime

  def ua_strftime(format)
    UaEnv::UaDates::ua_strftime(format, self)
    #strftime_nouaenv(format)
  end
end

class DateTime
  #alias_method :strftime_nouaenv, :strftime

  def ua_strftime(format)
    UaEnv::UaDates::ua_strftime(format, self)
    #strftime_nouaenv(format)
  end
end
