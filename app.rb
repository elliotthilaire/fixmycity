require 'sinatra'
require 'data_mapper'
require 'dm-sqlite-adapter'
require 'csv'
require 'uuid'



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
  uuid = UUID.new

  filename = params[:file][:filename]
  filename = uuid.generate << File.extname(filename)

  file = params[:file][:tempfile]

  # Try to save the file first, if that succeeds, 
  # then try to insert the db record.
  File.open("./public/images/img/#{filename}", 'wb') do |f|
    f.write(file.read)
  end

  # Hard-coded stuff below is for bus stops only
  closest = find_closest_busstop(params['latitude'].to_f, params['longitude'].to_f)
  name = closest[1]
  street = closest[2]
  suburb = closest[5]
  lat = closest[6].to_f
  lng = closest[7].to_f

  ent_description = "#{name}; #{street}; #{suburb}"

  report = Report.create!(
     created_at: DateTime.now,
     entity_type: params['category'],
     entity_description: ent_description,
     description: params['description'],
     latitude: lat,
     longitude: lng,
     submitted_latitude: params['latitude'],
     submitted_longitude: params['longitude'],
     detection_accuracy_m: params['accuracy'],
     contact: params['contact'],
     photo_url: filename
  )

  erb :successfulsubmission
 
end



# This is required, do not remove.
# It tells datamapper that there are no more models to load.
DataMapper.finalize

# DataMapper.auto_migrate!
DataMapper.auto_upgrade!
