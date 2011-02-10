#coding: utf-8
require_relative '../lib/commands/title_command'
require_relative '../lib/parse/page_provider'
require 'test/unit'

class TestTitleCommand < Test::Unit::TestCase
  def setup
    @page = Parse::PageProvider.new("http://peterbodskov.dk").page
    @title_command = Commands::TitleCommand.new 
  end
  
  def test_can_create 
    refute_nil(@title_command)      
  end
  
  def test_will_return_title
    assert_equal(@title_command.execute(@page), "Peter Bødskov")
  end  
end