require_relative 'mock_page'
require 'test/unit'

class TestDoctypeCommand < Test::Unit::TestCase
  def setup
    @page = MockPage.new
    @doctype_command = Commands::DoctypeCommand.new 
    @report_generator = Visitors::ReportGenerator.new
  end
  
  def test_can_create
    refute_nil(@report_generator)
  end
  
  def test_can_accept_doctype_visitor_html5
    @page.doctype = "<!DOCTYPE html SYSTEM>"
    @doctype_command.execute(@page)
    assert_equal("<p>You're already using the HTML5 doctype, good</p>", @doctype_command.accept(@report_generator)) 
  end
  
  def test_can_accept_doctype_visitor_not_html5
    @page.doctype = "<!DOCTYPE htmlfake SYSTEM>"
    @doctype_command.execute(@page)
    assert_equal("<p>Your doctype could be upgraded to <!DOCTYPE html></p>", @doctype_command.accept(@report_generator)) 
  end
  
  def test_can_accept_title_visitor
    @title_command = Commands::TitleCommand.new
    refute_nil(@title_command)
    @title_command.execute(@page)
    assert_equal("<p>Title: Mocked title</p>", @title_command.accept(@report_generator))
  end
  
end