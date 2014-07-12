require_relative 'app.rb'

for i in (0..100)
    lat = -27.57 + (rand() - 0.5) / 100 
    lng = 153.047 + (rand() - 0.5) / 100  
    description = (0...20).map { (65 + rand(26)).chr }.join
    contact = 'person@example.com' 
    Report.create(
            description: description,
            latitude: lat,
            longitude: lng, 
            contact: contact
    )
    
    if false
        puts lat
        puts lng
        puts description
        puts contact
    end
end

