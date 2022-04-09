

# nodoc
class Document
  attr_reader :response

  def initialize(response)
    @response = response
  end

  def titles
    @titles ||= document.css('.medialisting a').map do |link|
      link.attr('title')
    end

    @titles.compact
  end

  def document
    response
  end
end
