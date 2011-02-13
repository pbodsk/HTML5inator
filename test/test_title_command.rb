require_relative '../lib/commands/title_command'
require_relative '../lib/parse/page_provider'
require 'test/unit'

class TestTitleCommand < Test::Unit::TestCase
  def setup
    #@page = Parse::PageProvider.new("http://peterbodskov.dk").page
    @page = MockPage.new
    @title_command = Commands::TitleCommand.new 
  end
  
  def test_can_create 
    refute_nil(@title_command)      
  end
  
  def test_will_return_title
    @title_command.execute(@page)
    assert_equal("Mocked title", @title_command.title)
  end  
end