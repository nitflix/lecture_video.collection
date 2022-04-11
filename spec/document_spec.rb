# frozen_string_literal: true

require 'rspec/collection_matchers'
require_relative '../lib/models/document'
require 'nokogiri'

RSpec.describe Document do
  let(:response) do
    File.read('spec/fixture.html')
  end

  subject(:document) do
    described_class.new Nokogiri::HTML(response)
  end

  it 'lists all the videos' do
    expect(subject).to have(32).titles
  end
end
