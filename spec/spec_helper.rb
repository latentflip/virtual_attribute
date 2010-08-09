require "rubygems"
require "active_record"
require "logger"

#Active Record needs a logger
ActiveRecord::Base.logger = Logger.new('/dev/null')


#To allow us to test an ActiveRecord object without a database
class Tableless < ActiveRecord::Base
  def self.columns
    @columns ||= [];
  end

  def self.column(name, sql_type = nil, default = nil, null = true)
    columns << ActiveRecord::ConnectionAdapters::Column.new(name.to_s, default,
      sql_type.to_s, null)
  end

  # Override the save method to prevent exceptions.
  def save(validate = true)
    validate ? valid? : true
  end
end
