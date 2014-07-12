require 'sinatra'
require 'data_mapper'
require 'dm-sqlite-adapter'

require_relative 'configure'

## This is an example model.
class Post
  include DataMapper::Resource
  property :id, Serial
  property :title, String
  property :body, Text
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