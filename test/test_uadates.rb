# -*- encoding: utf-8 -*-

require 'test/unit'
require_relative '../lib/uaenv'

class DateTimeTestCase < Test::Unit::TestCase
  def test_ua_time
    assert_equal "пт, п'ятниця, січ, січень", Time.local(2007,"jan",5).ua_strftime("%a, %A, %b, %B")
  end

  def test_ua_date
    assert_equal "пт, п'ятниця, січ, січень", DateTime.new(2007, 1, 5).ua_strftime("%a, %A, %b, %B")
  end

  def test_time
    assert_equal "Fri, Friday, Jan, January", Time.local(2007,"jan",5).strftime("%a, %A, %b, %B")
  end

  def test_date
    assert_equal "Fri, Friday, Jan, January", DateTime.new(2007, 1, 5).strftime("%a, %A, %b, %B")
  end
end

class DistanceOfTimeTest < Test::Unit::TestCase
  def test_distance_of_time_in_words
    assert_format_eq "півхвилини", 0, 31, true
    assert_format_eq "менше хвилини", 0, 31
    assert_format_eq "2 хвилини", 0, 140
    assert_format_eq "близько 2 годин", 0, 60 * 114
    assert_format_eq "близько 3 годин", 0, 60 * 120 + 60 * 60
    assert_format_eq "близько 5 годин", 60 * 60 * 5 
    assert_format_eq "3 дні", 60 * 60 * 24 * 3
  end
      
  def assert_format_eq(str, *from_and_distance)
    assert_equal str, UaEnv::UaDates.distance_of_time_in_words(*from_and_distance) 
  end
end
