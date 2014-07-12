require 'sinatra'
require 'data_mapper'
require 'dm-sqlite-adapter'
require 'carrierwave/datamapper'

require_relative 'configure'

require 'csv'
$bus_stops = CSV.read('raw_data/brisbane_bus_stops.csv', headers:true)

def distance(lat1,long1,lat2,long2)
    (lat1-lat2)**2 + (long1-long2)**2
end

def find_closest_busstop(lat,long)
    s = ""
    min_idx = $bus_stops.length + 1
    min_dist = 1e20
    $bus_stops.each_with_index {|val, i| 
        # TODO This is ugly, we should use column names for lookups,
        # not indexes
        bslat = val[6].to_f
        bslong = val[7].to_f
        sm = val[6].to_f + val[7].to_f
        s = s << sm.to_s << "\t" << val[6] << "\t" << val[7] << "<br>" # "hello\n" 
        dist = distance(lat,long,bslat,bslong)
        print "#{i} = #{dist}\n"
        if dist < min_dist
            min_idx = i
            min_dist = dist
        end
        if i > 10 
            break
        end
    }
    s = s << $bus_stops[min_idx].to_s
    s
end

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
