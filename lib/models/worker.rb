require 'redis'

# @nodoc
class Worker
  def initialize(db, collection)
    @db = db
    @collection = collection
  end

  def write
    collection.each do |entry|
      db.set 'foo', entry
    end
  end

  private

  attr_reader :db, :collection
end
