# Fix My City!

Fix My City! is a submission to the 2014 GovHack project.

Our idea was to create a very simple mobile friendly webapp that allows members of the public to take photos of things that need attention in our city and upload them without having to provide all the details manually. These are populated automatically using Brisbane City Council data from http://data.gov.au.
'Fix My City!' works by allowing a person to take an photo of a problem and submit it (like they would take a photo and upload it on facebook), thereby allowing a member of the public a simple, rapid way of informing their city council of a problem.
'Fix My City!' uses a number of innovative features including the clever use of geolocation data so that if a person submits a problem relating to a busstop, "Fix My City!" automatically knows which the bus stop the person is having a problem with.
 
For the council, "Fix My City!" provides a central database of submitted problems which contain useful information such as a picture of the problem, the location of the problem, the date when the problem was located (including a map-point of where the problem is located), the problem category as well as whether the problem has been resolved.
This makes it simple for the council maintainence department to make an effective coordinated response to these problems in a rapid manner.




## Team Rameelcajo

Randall Fernando

Mei Wang Brough-Smyth

Elliott Hilaire

Caleb Hattingh

Josh Donnelly

Youngmin Kim

## Setup 

Install ruby 2.0.0

run bundle install

run bundle exec shotgun app.rb

Open http://localhost:9393 in your browser

## Explanation

Html templates go in views. Using the erb templating language.

Assets (images, css, js) go in public.


## To do

- Map loads to London as the default location. (This is Young, I fixed this, Now the map show Brisbane)
- not stored in database when you report a problem. (After install data-mapper with this command "gem2.0 install data_mapper", it is working)
- For entity_type, we need unification. For example, Bus stop, not Bus Stop.



