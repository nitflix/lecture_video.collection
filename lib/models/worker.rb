require 'redis'
require_relative './client'

# @nodoc
class Worker
  def initialize(db, collection, client)
    @db = db
    @collection = collection
    @client = client
  end

  def write
    collection.each do |entry|
      db.set entry[:courseHref], []
    end
  end

  def work
    collection.each do |entry|
      href = entry[:courseHref]
      document_titles = client.update(href).document_titles
      db.set href, document_titles
    end
  end

  private

  attr_reader :db, :collection, :client
end
