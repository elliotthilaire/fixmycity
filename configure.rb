
class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
end

configure :development do
  db_path = ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/db/development.db"
  DataMapper.setup(:default, db_path)
end

configure :production do
  db_path = ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/db/production.db"
  DataMapper.setup(:default, db_path)
end

configure :test do
  DataMapper.setup(:default, 'sqlite::memory:')
end