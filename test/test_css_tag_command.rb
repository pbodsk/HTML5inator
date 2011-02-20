require_relative '../lib/commands/css_tag_command'
require_relative '../lib/visitors/report_generator'
require_relative '../lib/parse/page_provider'
require_relative 'mock_page'
require 'test/unit'

class TestCssTagCommand < Test::Unit::TestCase
  def setup
    @page = MockPage.new
    @css_tag_command = Commands::CssTagCommand.new 
  end
  
  def test_can_create 
    refute_nil(@css_tag_command)      
  end
  
  def test_will_return_style_tags_on_page
    @css_tag_command.execute(@page)
    assert_equal(1, @css_tag_command.styles.length)
  end
end
