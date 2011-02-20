class MockPage
  attr_reader :title
  attr_accessor :doctype
  attr_accessor :mock_script
  attr_accessor :mock_style
  
  def at(type)
    return doctype if type =~ /!DOCTYPE/ 
    return MockTitle.new
  end
  
  def search(element)
    if(element == "script")
      @mock_script ||=
      [
        '<script type="text/javascript" src="http://peterbodskov.dk/wp-content/plugins/syntaxhighlighter/syntaxhighlighter3/scripts/shCore.js?ver=3.0.83b"></script>',
        '<script type="text/javascript" src="http://peterbodskov.dk/wp-content/plugins/syntaxhighlighter/syntaxhighlighter3/scripts/shBrushBash.js?ver=3.0.83b"></script>',
        '<script type="text/javascript">
        	(function(){})();</script>'
      ]
    elsif(element == "link")
      @mock_style ||=
      [
       '<link rel="stylesheet" href="http://peterbodskov.dk/wp-content/themes/space_to_earth/style.css" type="text/css" media="screen" />'  
      ]
    end
  end
end

class MockTitle
  def inner_html
    "Mocked title"
  end
end