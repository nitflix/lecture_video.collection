

# nodoc
class Document
  attr_reader :response

  def initialize(response)
    @response = response
  end

  def titles
    @titles ||= response.css('.video-title').map(&:children)
  end
end
