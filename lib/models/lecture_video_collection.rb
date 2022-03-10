# frozen_string_literal: true

require 'nokogiri'
require 'net/http'
require 'open-uri'
require 'json'

# nodoc
class LectureVideoCollection
  DOMAIN = 'https://ocw.mit.edu'

  def initialize(attributes = {})
    @attributes = attributes
  end

  def enqueue_for_download
    collect.flat_map do |course|
      res = nil
      ['lecture-videos', 'video-lectures'].each do |pattern|
        begin
        res = URI.open("#{DOMAIN}/#{course['href']}/#{ pattern }")
        break if res.is_a?(Tempfile)
        rescue OpenURI::HTTPError
        end
      end

      if !res.nil?
      doc = Nokogiri::HTML res
      titles = doc.css('.medialisting a').map do |link|
        link.attr('title')
      end
      end

      puts '#' * 50, titles.inspect
      titles.compact || 'Nothing...'
    end.compact
  end

  def collect
    @attributes.select do |course|
      course['completeVideo'] == true
    end
  end
end

