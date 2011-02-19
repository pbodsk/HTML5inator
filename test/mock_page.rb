class MockPage
  attr_reader :title
  attr_accessor :doctype
  
  def at(type)
    return doctype if type =~ /!DOCTYPE/ 
    return MockTitle.new
  end
  
  def search(element)
    if(element == "script")
      [
        '<script type="text/javascript" src="http://peterbodskov.dk/wp-content/plugins/syntaxhighlighter/syntaxhighlighter3/scripts/shCore.js?ver=3.0.83b"></script>',
        '<script type="text/javascript" src="http://peterbodskov.dk/wp-content/plugins/syntaxhighlighter/syntaxhighlighter3/scripts/shBrushBash.js?ver=3.0.83b"></script>',
        '<script type="text/javascript">
        	(function(){})();</script>'
      ]
    end
  end
end

class MockTitle
  def inner_html
    "Mocked title"
  end
end