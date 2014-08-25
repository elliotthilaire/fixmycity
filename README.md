# Fix My City!

Fix My City! is a submission to the 2014 [GovHack](http://www.govhack.org/) competition. It won [Best Use of Brisbane City Council
Transportation Data](http://www.govhack.org/2014-winners/) 

Our idea was to create a very simple mobile friendly webapp that allows members of the public to take photos of things that need attention in our city and upload them without having to provide all the details manually. These are populated automatically using Brisbane City Council data from http://data.gov.au.
'Fix My City!' works by allowing a person to take an photo of a problem and submit it (like they would take a photo and upload it on facebook), thereby allowing a member of the public a simple, rapid way of informing their city council of a problem.
'Fix My City!' uses a number of innovative features including the clever use of geolocation data so that if a person submits a problem relating to a busstop, "Fix My City!" automatically knows which the bus stop the person is having a problem with.
 
For the council, "Fix My City!" provides a central database of submitted problems which contain useful information such as a picture of the problem, the location of the problem, the date when the problem was located (including a map-point of where the problem is located), the problem category as well as whether the problem has been resolved.
This makes it simple for the council maintainence department to make an effective coordinated response to these problems in a rapid manner.


## Team Rameelcajo

* Randall Fernando
* Mei Wang Brough-Smyth
* Elliott Hilaire
* Caleb Hattingh
* Josh Donnelly
* Youngmin Kim

## Requirements

Ruby 2.0.0, gems and bundler

## Setup 

Install gems
    
    bundle install

Launch shotgun (shotgun will reload itself when files change during development)

    bundle exec shotgun app.rb

Open http://localhost:9393 in your browser

## Explaination

Html templates go in views. Using the erb templating language.

Assets (images, css, js) go in public.


## To do

* not stored in database when you report a problem. (After install data-mapper with this command "gem2.0 install data_mapper", it is working)
* For entity_type, we need unification. For example, Bus stop, not Bus Stop.



## License

The MIT License (MIT)

Copyright (c) [2014] [Team Rameelcajo]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
