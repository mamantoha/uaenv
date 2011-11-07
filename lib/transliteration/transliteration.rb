# encoding: utf-8

# See also:
# http://en.wikipedia.org/wiki/Romanization_of_Ukrainian
# http://uk.wikipedia.org/wiki/Транслітерація_української_мови_латиницею
# http://www.sdip.gov.ua/ukr/laws/3267/?print=yes

module UaEnv
  module Transliteration #:nodoc:
  end
end

require File.join(File.dirname(__FILE__), 'national')
require File.join(File.dirname(__FILE__), 'iso9')
require File.join(File.dirname(__FILE__), 'qwertz')

# Реалізує транслітерацію будь-якого об'єкта, що реалізує String
module UaEnv::Transliteration::StringFormatting
  
  #Транслітерація строки у латиницю
  def translify_national
    UaEnv::Transliteration::National::translify(self.to_s)
  end

  def translify_national!
    self.replace(self.translify_national)
  end

  def translify_iso9
    UaEnv::Transliteration::ISO9::translify(self.to_s)
  end

  def translify_iso9!
    self.replace(self.translify_iso9)
  end

  # alias_method :new, :old
  alias_method :translify, :translify_national
  alias_method :translify!, :translify_national!
end

class Object::String
  include UaEnv::Transliteration::StringFormatting
end
