# frozen_string_literal: true

require 'rspec'
require 'pry'
require_relative '../../lib/models/lecture_video_collection'

RSpec.describe LectureVideoCollection do
  let(:fixed_data) do
    File.read 'spec/fixture.json'
  end

  let(:fixed_attributes) do
    JSON.parse fixed_data
  end
  subject(:lecture_video_collection) do
    described_class.new fixed_attributes
  end
  describe '#collect' do
    context 'when the response is a 404' do
      it 'matches againsts the alternate pattern'
      it 'logs the attempted request'
    end
    it 'enumerates the videos in the collection' do
      expect(lecture_video_collection.video_courses.count).to eql 85
    end
  end

  describe '#enqueue_for_download' do
    subject(:queue) do
      lecture_video_collection.enqueue_for_download
    end
    it 'sends a batch to the downloader' do
      expect(subject.count).to eql 14
    end
  end
end
