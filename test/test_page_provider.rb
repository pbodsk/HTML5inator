require_relative '../lib/parse/page_provider'
require 'test/unit'

class TestPageProvider < Test::Unit::TestCase
  def test_can_create
    page_reader = Parse::PageProvider.new("http://peterbodskov.dk")
    refute_nil(page_reader)
    refute_nil(page_reader.page)
  end
  
  def test_will_throw_error_if_empty_url_is_provided  
    assert_raises(RuntimeError) {Parse::PageProvider.new("")}
  end  
end