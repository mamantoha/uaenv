# -*- encoding: utf-8 -*-

require 'test/unit'
require_relative '../lib/uaenv'

class TransliterationTestCase < Test::Unit::TestCase
  def test_national_transliteration
    assert_equal "Zghurskyi", "Згурський".translify
    assert_equal "Galagan", "Ґалаґан".translify
    assert_equal "Ternopil", "Тернопіль".translify_natinal
    assert_equal "Yizhakevych", "Їжакевич".translify_national
  end

  def test_national_transliteration
    assert_equal "Zorâna", "Зоряна".translify_iso9a
    assert_equal "Ģalaģan", "Ґалаґан".translify_iso9a
    assert_equal "Yizhakevy`ch", "Їжакевич".translify_iso9b
    assert_equal "Ternopil`", "Тернопіль".translify_iso9b
    assert_equal "Ternopil", "Цялюлєї".translify_iso9b
  end

end
