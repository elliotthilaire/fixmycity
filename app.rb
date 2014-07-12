require 'sinatra'
require 'data_mapper'
require 'dm-sqlite-adapter'
require 'carrierwave/datamapper'

require_relative 'configure'

## This is an example model.
class Report
  include DataMapper::Resource
  property :id, Serial
  property :description, String
  property :photo_url, String
  property :latitude, Float
  property :longitude, Float
  property :contact, String
  property :status, Enum[ :new, :open, :closed, :invalid ], default: :open
  property :created_at, DateTime
end

get '/' do
  erb :index
end

get '/hi' do
   erb :hi
end


# This is required, do not remove.
# It tells datamapper that there are no more models to load.
DataMapper.finalize

# DataMapper.auto_migrate!
DataMapper.auto_upgrade!