# frozen_string_literal: true

require 'nokogiri'
require 'net/http'
require 'json'

# nodoc
class LectureVideoCollection
  def initialize(attributes = {})
    @attributes = attributes
  end

  def collect
    @attributes.select do |course|
      course['completeVideo'] == true
    end
  end
end

# uri = URI(ARGV[0])
# res = Net::HTTP.get_response(uri)
#
# puts true if res.is_a?(Net::HTTPSuccess)
# html_doc = Nokogiri::HTML(response)
