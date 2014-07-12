
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