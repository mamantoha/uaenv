# -*- encoding: utf-8 -*-

require 'test/unit'
require File.dirname(__FILE__) + '/../lib/uaenv'

class PropysomTestCase < Test::Unit::TestCase
  def test_ints
    assert_equal "одна тисяча дев'ятсот вісімдесят шість", 1986.propysom
    assert_equal "двадцять одне", 21.propysom(3)
    assert_equal "сімсот мільярдів дев'яносто мільйонів п'ять тисяч одна", 700090005001.propysom(2)
    assert_equal "шістнадцять тисяч дев'ятсот сорок п'ять комп'ютерів", 16945.propysom_items(1, "комп'ютер", "комп'ютери", "комп'ютерів")
    assert_equal "сім чуд", 7.propysom_items(3, "чудо", "чуда", "чуд")
  end

  def test_floats
    assert_equal "сім цілих дев'яносто п'ять тисячних", (7.095).propysom
    assert_equal "чотириста сорок одне ціла п'ять десятих", (441.50000).propysom(3)
    assert_equal "нуль цілих сто двадцять три мільйона чотириста п'ятдесят шість тисяч сімсот вісімдесят дев'ять мільярдних", (0.123456789).propysom
    assert_equal "двадцять одна ціла двадцять одна сота", (21.21).propysom(2)
    assert_equal "двадцять одне ціла двадцять одна сота", (21.210000000000000000000000000987654321).propysom(3)
  end

  def test_items
    assert_equal "привидів" ,13.items("привид", "привиди", "привидів")
  end

  def test_grn
    assert_equal "тринадцять гривень п'ятнадцять копійок", (13.15).grn
    assert_equal "сто гривень", (99.996).grn
    assert_equal "три копійки", (0.03).grn
  end

end
