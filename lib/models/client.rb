require 'nokogiri'
require 'mechanize'
require 'json'
require_relative './document'
require_relative './bot'

class Client
  attr_writer :href

  def initialize(bot)
    @bot = bot
  end

  def document_titles
    Document.new(response).titles
  end


  EmptyTempFile = Class.new Tempfile

  def response
    bot.follow_meta_refresh
    bot.redirect_ok
    buffer = []
    PATTERNS.each do |pattern|
      buffer << bot.get(URI("#{url}/video_galleries/#{pattern}"))
    rescue Mechanize::ResponseCodeError => e
      buffer << e
    end

    buffer.detect do |obj|
      obj.is_a? Mechanize::Page
    end
  end

  def url
    "#{DOMAIN}/#{href}"
  end

  PATTERNS = %w[lecture-videos video-lectures].freeze
  DOMAIN = 'https://ocw.mit.edu'.freeze

  private_constant :PATTERNS, :DOMAIN

  private

  attr_reader :href, :bot
end
#   def enqueue_for_download
#     video_courses.flat_map do |course|
#       puts '#' * 50, course['href']
#       response = Fetcher.new(course).response
#
#       @buffer[course['href']] = [Document.new(response).titles]
#     end
#
#     File.open("/work/tmp/#{collection_name}.json", 'w') do |file|
#     #   then run  a container with the environment
#     #   and babysit until they are all downloaded
#     #   maybe even starting with lowest quality audio
#     #   then video
#     #   and thumbnails
#     # individuaal environment files for each container
#     #   notes/course['href']
#     #     export COURSE_HREF=
#     #     export LECTURE_TITLE=
#       file.write @buffer.to_json
#     end
#   end
#
# # nodoc
