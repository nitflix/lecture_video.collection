require_relative '../lib/models/worker'
require_relative '../lib/models/lecture_video_collection'
RSpec.describe Worker do
  let(:db) do
    double(Redis)
  end

  describe '#enqueue_for_download' do
    context 'when the response is a 404' do
      # it 'matches againsts the alternate pattern'
      # it 'logs the attempted request'
    end

    subject(:worker) do
      described_class.new db, collection
    end
    let(:collection) do
      double(LectureVideoCollection)
    end

    let(:mock_collection) do
      14.times.map do
        {}
      end
    end
    it 'adds an entry to the database for each video in the collection' do
      expect(collection).to receive(:each).and_return mock_collection
      expect(db).to receive(:set).exactly(14).times
      worker.write
    end
  end
end
