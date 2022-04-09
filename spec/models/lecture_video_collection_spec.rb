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

  let(:bot) do
    double(:Bot, get: '')
  end

  subject(:lecture_video_collection) do
    described_class.new fixed_attributes, 'engineering', bot
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
    end
    it 'sends a batch to the downloader' do
      expect_any_instance_of(Fetcher).to receive(:new).exactly(14).times.and_return ''
      lecture_video_collection.enqueue_for_download
    end
  end
end
