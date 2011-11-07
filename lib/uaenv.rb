# -*- encoding: utf-8 -*-

require_relative "uaenv/version"

module UaEnv
  # Каталог, куди встановлений модуль UaEnv. Потрібен для автоматичного копіювання у інші додатки.
  INSTALLATION_DIRECTORY = File.expand_path(File.dirname(__FILE__) + '/../') #:nodoc:
  
  def self.load_component(name) #:nodoc:
    require File.join(UaEnv::INSTALLATION_DIRECTORY, "lib/uaenv", name.to_s, name.to_s)
  end

  def self.reload_component(name) #:nodoc:
    load File.join(UaEnv::INSTALLATION_DIRECTORY, "lib/uaenv", name.to_s, "#{name}.rb")
  end
end

UaEnv::load_component :datetime # Дата і час без локалі
UaEnv::load_component :pluralizer # Вивід чисел прописом
UaEnv::load_component :transliteration # Транслітерація
UaEnv::load_component :fio # Відмінювання прізвища, імені і по батькові у давальний відмінок
