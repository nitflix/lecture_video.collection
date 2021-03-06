# frozen_string_literal: true

require 'nokogiri'
require 'mechanize'
require 'net/http'
require 'open-uri'
require 'json'

# nodoc
class LectureVideoCollection
  attr_reader :collection_name
  def initialize(attributes = {}, collection_name)
    @attributes = attributes
    @buffer = {}
    @collection_name = collection_name
  end

  def enqueue_for_download
    video_courses.flat_map do |course|
      puts '#' * 50, course['href']
      response = Fetcher.new(course).response

      @buffer[course['href']] = [Document.new(response).titles]
    end

    File.open("/work/tmp/#{collection_name}.json", 'w') do |file|
    #   then run  a container with the environment
    #   and babysit until they are all downloaded
    #   maybe even starting with lowest quality audio
    #   then video
    #   and thumbnails
    # individuaal environment files for each container
    #   notes/course['href']
    #     export COURSE_HREF=
    #     export LECTURE_TITLE=
      file.write @buffer.to_json
    end
  end

  def video_courses
    @video_courses ||= @attributes.select do |course|
      course['completeVideo'] == true
    end
  end
end

# nodoc
class Fetcher
  attr_reader :course

  def initialize(course)
    @course = course
    @buffer = []
  end

  PATTERNS = %w[lecture-videos video-lectures]
  DOMAIN = 'https://ocw.mit.edu'

  def bot
    return @bot if @bot

    @bot ||= Mechanize.new
    @bot.follow_meta_refresh
    @bot.redirect_ok
    @bot
  end

  EmptyTempFile = Class.new Tempfile

  def response
    PATTERNS.each do |pattern|
      @buffer << bot.get(URI("#{url}/#{pattern}"))
    rescue Mechanize::ResponseCodeError
      @buffer << EmptyTempFile.new
    end

    @buffer.select do |obj|
      obj.is_a? Mechanize::Page
    end.first || Nokogiri::HTML(Tempfile.new)
  end

  def url
    "#{DOMAIN}/#{course['href']}"
  end
end

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
