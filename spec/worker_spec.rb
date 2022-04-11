require_relative '../lib/models/worker'
require_relative '../lib/models/lecture_video_collection'
RSpec.describe Worker do
  let(:db) do
    double(Redis)
  end

  let(:client) do
    double(Client)
  end

  describe '#write' do
    after do
      # db.del('stubbed')
    end
    subject(:worker) do
      described_class.new db, mock_collection, client
    end
    let(:collection) do
      double(LectureVideoCollection)
    end
    let(:mock_collection) do
      14.times.map do
        { courseHref: 'stubbed' }
      end
    end
    xit 'adds an entry to the database for each video in the collection' do
      # expect(collection).to receive(:each).and_return mock_collection
      expect(db).to receive(:set).with('stubbed', []).exactly(14).times
      worker.write
    end

    describe 'writing document titles to the db' do
      let(:document_titles) do
        ['test']
      end
      let(:courseHref) do
        'courses/6-006-introduction-to-algorithms-spring-2020'
      end
      let(:example_collection) do
        [{ courseHref: courseHref }]
      end
      subject do
        described_class.new db, example_collection, client
      end
      it 'writes the response from the client to the entry in the database' do
        allow(client).to receive(:update).and_return client
        expect(client).to receive(:document_titles).and_return document_titles
        expect(db).to receive(:set).with(courseHref, document_titles).exactly(1).times
        subject.work
      end
    end
  end
end
