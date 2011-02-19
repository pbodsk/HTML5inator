require 'open-uri'
require 'hpricot'
module Parse
  class PageProvider
    attr_reader :page
    def initialize(url)
      fail "You must provide a URL" if url.length == 0
      @url = url
      @page = Hpricot(open(@url))
    end
  end
end