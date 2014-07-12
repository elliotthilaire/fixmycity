
class Report
  include DataMapper::Resource
  property :id, Serial
  property :entity_type, String
  property :entity_description, Text
  property :description, String  
  property :latitude, Float
  property :longitude, Float
  property :submitted_latitude, Float
  property :submitted_longitude, Float
  property :detection_accuracy_m, Float
  property :contact, String
  property :status, Enum[ :new, :open, :closed, :invalid ], default: :open
  property :created_at, DateTime
  property :photo_url, String
end
