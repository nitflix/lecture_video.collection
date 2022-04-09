# frozen_string_literal: true

require 'rspec'
require 'json'
require_relative '../../lib/models/lecture_video_collection'

RSpec.describe LectureVideoCollection do
  let(:fixture) do
    File.read 'spec/fixture.json'
  end

  subject(:lecture_video_collection) do
    described_class.new JSON.parse(fixture)
  end

  describe '#collect' do
    it 'enumerates the videos in the collection' do
      expect(lecture_video_collection.to_a.count).to eql 85
    end
  end
end
