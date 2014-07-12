require 'sinatra'
require 'data_mapper'
require 'dm-sqlite-adapter'
require 'csv'
require 'SecureRandom'

require_relative 'configure'
require_relative 'helpers'
require_relative 'models'

get '/test_findstop' do
  "Hello World!"
  find_closest_busstop(-27.5584, 153.07714)
end

get '/data' do
   array = Report.all
   # array must become JSON
   array.to_json
end

get '/' do
  @reports = Report.all
  erb :index
end

get '/report' do
  erb :report
end

post '/report' do

  # Instead of filename, use a uuid
  # but make sure to retain the file extension 
  filename = params[:file][:filename]
  filename = SecureRandom.uuid() << File.extname(filename)

  file = params[:file][:tempfile]

  # Try to save the file first, if that succeeds, 
  # then try to insert the db record.
  File.open("./public/images/img/#{filename}", 'wb') do |f|
    f.write(file.read)
  end

  Report.create(
     description: params['description'],
     latitude: params['latitude'],
     longitude: params['longitude'],
     contact: params['contact'],
     photo_url: "./public/images/img/#{filename}"
  )

  erb :successfulsubmission
 
end



# This is required, do not remove.
# It tells datamapper that there are no more models to load.
DataMapper.finalize

# DataMapper.auto_migrate!
DataMapper.auto_upgrade!
