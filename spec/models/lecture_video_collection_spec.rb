# frozen_string_literal: true

require 'rspec'
require_relative '../../lib/models/lecture_video_collection'

RSpec.describe LectureVideoCollection do
  let(:fixed_data) do
    File.read 'spec/fixture.json'
  end

  let(:fixed_attributes) do
    JSON.parse fixed_data
  end
  subject do
    described_class.new fixed_attributes
  end
  describe '#collect' do
    context 'when the response is a 404' do
      it 'matches againsts the alternate pattern'
      it 'logs the attempted request'
    end
    it 'enumerates the videos in the collection' do
      expect(subject.collect.count).to eql 85
    end
  end

  describe '#enqueue_for_download' do
    it 'sends a batch to the downloader'
  end
end
