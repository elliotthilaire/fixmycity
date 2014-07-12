require 'sinatra'
require 'data_mapper'


get '/hi' do
  "Hello World!"
end


# This is required, do not remove.
# It tells datamapper that there are no more models to load.
DataMapper.finalize

# DataMapper.auto_migrate!
DataMapper.auto_upgrade!