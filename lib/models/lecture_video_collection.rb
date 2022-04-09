# frozen_string_literal: true


# nodoc
class LectureVideoCollection
  def initialize(attributes = {})
    @attributes = attributes
  end

  def to_a
    @video_collection ||= attributes.select do |course|
      course['completeVideo'] == true
    end
  end

  private

  attr_reader :attributes
end
