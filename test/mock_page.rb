class MockPage
  attr_reader :title
  attr_accessor :doctype
  
  def at(type)
    return doctype if type =~ /!DOCTYPE/ 
    return MockTitle.new
  end
end

class MockTitle
  def inner_html
    "Mocked title"
  end
end