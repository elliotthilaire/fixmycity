require 'sinatra'
require 'data_mapper'
require 'dm-sqlite-adapter'
require 'carrierwave/datamapper'

require_relative 'configure'
require_relative 'helpers'

require 'csv'
$bus_stops = CSV.read('raw_data/brisbane_bus_stops.csv', headers:true)


## This is an example model.
class Report
  include DataMapper::Resource
  property :id, Serial
  property :description, String  
  property :latitude, Float
  property :longitude, Float
  property :contact, String
  property :status, Enum[ :new, :open, :closed, :invalid ], default: :open
  property :created_at, DateTime
  mount_uploader :photo, ImageUploader
  property :photo_url, String
end

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

    filename = params[:file][:filename]
    file = params[:file][:tempfile]

	Report.create(
   		description: params['description'],
   		latitude: params['latitude'],
   		longitude: params['longitude'],
   		contact: params['contact'],
   		photo_url: "./public/images/img/#{filename}"
   	)
 
	File.open("./public/images/img/#{filename}", 'wb') do |f|
		f.write(file.read)
	end

  
end



# This is required, do not remove.
# It tells datamapper that there are no more models to load.
DataMapper.finalize

# DataMapper.auto_migrate!
DataMapper.auto_upgrade!
