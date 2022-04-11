require_relative '../lib/models/client'
require 'rspec/collection_matchers'
RSpec.describe Client do
  describe '#document_titles' do
    # it 'logs the attempted request'

    # shared_context 'document response'
    let(:fixture) do
      File.read('spec/fixture.html')
    end

    let(:response) do
      Nokogiri::HTML(fixture)
    end

    let(:bot) do
      # double(Bot)
      Bot.new
    end

    subject do
      described_class.new bot
    end
    xit 'fetches a document' do
      subject.href = 'courseHref'
      expect(subject).to receive(:response).and_return response
      expect(subject).to have(32).document_titles
    end

    it 'trys different URL patterns to find results' do
      # uri = URI('https://ocw.mit.edu//lecture-videos')
      # expect(bot).to receive(:get).with(uri).and_raise Mechanize::ResponseCodeError
      subject.href = 'courses/aeronautics-and-astronautics/16-660j-introduction-to-lean-six-sigma-methods-january-iap-2012'
      puts subject.document_titles
    end
  end
end
