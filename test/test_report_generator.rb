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
  
  def test_can_accept_script_tag_visitor_on_scripts_with_type_set
    @script_tag_command = Commands::ScriptTagCommand.new
    refute_nil(@script_tag_command)
    @script_tag_command.execute(@page)
    refute_nil(/<li>/ =~ @script_tag_command.accept(@report_generator))
  end
  
  def test_can_accept_script_tag_visitor_on_scripts_without_type_set
    @script_tag_command = Commands::ScriptTagCommand.new
    refute_nil(@script_tag_command)
    @page.mock_script = ["&lt;script src='blah.js'&gt; &lt;script&gt;"]
    
    @script_tag_command.execute(@page)
    
    assert_equal('<p>You have already omitted type="text/javascript" from your &lt;script&gt; tags, good</p>', @script_tag_command.accept(@report_generator))
  end

  def test_can_accept_css_tag_visitor_on_css_with_type_set
    @css_tag_command = Commands::CssTagCommand.new
    refute_nil(@css_tag_command)
    @css_tag_command.execute(@page)
    refute_nil(/<li>/ =~ @css_tag_command.accept(@report_generator))
  end

  def test_can_accept_css_tag_visitor_on_css_without_type_set
    @css_tag_command = Commands::CssTagCommand.new
    refute_nil(@css_tag_command)
    @page.mock_style = ["&lt;link href='blah.css'&gt; /&gt;"]
    
    @css_tag_command.execute(@page)
    
    assert_equal('<p>You have already omitted type="text/css" from your &lt;link&gt; tags, good</p>', @css_tag_command.accept(@report_generator))
  end
  
end