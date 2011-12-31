# -*- encoding: utf-8 -*-

require 'test/unit'
require_relative '../lib/uaenv'

class TransliterationTestCase < Test::Unit::TestCase
  def test_national_transliteration
    assert_equal "Zghurskyi", "Згурський".translify
    assert_equal "Galagan", "Ґалаґан".translify
    assert_equal "Ternopil", "Тернопіль".translify_national
    assert_equal "Yizhakevych", "Їжакевич".translify_national
  end

  def test_iso_transliteration
    assert_equal "Zorâna", "Зоряна".translify_iso9a
    assert_equal "Ģalaģan", "Ґалаґан".translify_iso9a
    assert_equal "Yizhakevy`ch", "Їжакевич".translify_iso9b
    assert_equal "Ternopil`", "Тернопіль".translify_iso9b
    assert_equal "Cyacya", "Цяця".translify_iso9b
    assert_equal "Czukerka", "Цукерка".translify_iso9b
  end

end
