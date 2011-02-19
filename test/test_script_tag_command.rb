require_relative '../lib/commands/script_tag_command'
require_relative '../lib/visitors/report_generator'
require_relative '../lib/parse/page_provider'
require_relative 'mock_page'
require 'test/unit'

class TestScriptTagCommand < Test::Unit::TestCase
  def setup
    @page = MockPage.new
    @script_tag_command = Commands::ScriptTagCommand.new 
  end
  
  def test_can_create 
    refute_nil(@script_tag_command)      
  end
  
  def test_will_return_script_tags_on_page
    @script_tag_command.execute(@page)
    assert_equal(3, @script_tag_command.scripts.length)
  end
end
