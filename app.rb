require 'sinatra'
require 'data_mapper'
require 'dm-sqlite-adapter'

require_relative 'configure'

require 'csv'
$bus_stops = CSV.read('raw_data/brisbane_bus_stops.csv')

def find_closest_busstop(lat,long)
    s = ""
    $bus_stops.each_with_index {|val, i| 
        s = s << "hello\n" 
        if i > 10 
            break
        end
    }
    s
end

## This is an example model.
class Post
  include DataMapper::Resource
  property :id, Serial
  property :title, String
  property :body, Text
  property :created_at, DateTime
end

get '/test_findstop' do
  "Hello World!"
  find_closest_busstop(0.0,0.0)
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
