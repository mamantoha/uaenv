# -*- encoding: utf-8 -*-

require 'test/unit'
require_relative '../lib/uaenv'

class DateTimeTestCase < Test::Unit::TestCase
  def test_ua_time
    assert_equal "пт, п'ятниця, січ, січень", Time.local(2007,"jan",5).strftime("%a, %A, %b, %B")
  end

  def test_ua_date
    assert_equal "пт, п'ятниця, січ, січень", DateTime.new(2007, 1, 5).strftime("%a, %A, %b, %B")
  end

  def test_time
    assert_equal "Fri, Friday, Jan, January", Time.local(2007,"jan",5).strftime_nouaenv("%a, %A, %b, %B")
  end

  def test_date
    assert_equal "Fri, Friday, Jan, January", DateTime.new(2007, 1, 5).strftime_nouaenv("%a, %A, %b, %B")
  end

end
