
$bus_stops = CSV.read('raw_data/brisbane_bus_stops.csv', headers:true)
$playgrounds = CSV.read('raw_data/playgrounds.csv', headers:true)
$bbqs= CSV.read('raw_data/bbq.csv', headers:true)
# There was some unicode problem in the public art CSV file.
#$public_art= CSV.read('raw_data/public_art.csv', headers:true)
$drinking_taps= CSV.read('raw_data/dataset_drinking_fountain_taps3.csv', headers:true)
$parks= CSV.read('raw_data/parks.csv', headers:true)
$parking_meters= CSV.read('raw_data/parking_meter_areas.csv', headers:true)
$public_toilets= CSV.read('raw_data/public_toilets.csv', headers:true)
$dog_parks= CSV.read('raw_data/dog_parks.csv', headers:true)
$citycycle_stations= CSV.read('raw_data/citycycle_stations.csv', headers:true)
$tennis_courts= CSV.read('raw_data/tennis_courts.csv', headers:true)
$boat_ramps= CSV.read('raw_data/boat_ramps.csv', headers:true)
$ferry_terminals= CSV.read('raw_data/ferry_terminals.csv', headers:true)
$skate_parks= CSV.read('raw_data/skate_parks.csv', headers:true)

def distance(lat1,long1,lat2,long2)
    # Pythagorean distance, i.e. hypoteneuse
    (lat1-lat2)**2 + (long1-long2)**2
end

def get_idx(type)
    # Given a type, return the column indexes for a concatenated description
    # and the column index for latitude and the one for longitude.
    if type == 'Bus stop'
        description = [1,2,5]
        lat=6
        lng=7
        csvarray=$bus_stops
    elsif type == 'Playground'
        description = [1,2,3,4,6]
        lat=8
        lng=9
        csvarray=$playgrounds
    elsif type == 'BBQ'
        description = [1,2,11]
        lat=10
        lng=9
        csvarray=$bbqs
    elsif type == 'Public art'
        description = [0,1,6,7,10,11]
        lat=12
        lng=13
        csvarray=$public_art
    elsif type == 'Drinking fountain tap'
        description = [2,3,5,8]
        lat=12
        lng=11
        csvarray=$drinking_taps
    elsif type == 'Park'
        description = [1,2,3,4]
        lat=7
        lng=8
        csvarray=$parks
    elsif type == 'Parking meter'
        description = [1,7,8]
        lat=12
        lng=13
        csvarray=$parking_meters
    elsif type == 'Public toilet'
        description = [1,2,3,4,5]
        lat=8
        lng=9
        csvarray=$public_toilets
    elsif type == 'Dog park'
        description = [1,2,3,4,6]
        lat=8
        lng=9
        csvarray=$dog_parks
    elsif type == 'City Cycle station'
        description = [1,2,3,4]
        lat=8
        lng=9
        csvarray=$citycycle_stations
    elsif type == 'Tennis court'
        description = [2,1]
        lat=5
        lng=6
        csvarray=$tennis_courts
    elsif type == 'Boat ramp'
        description = [1,2]
        lat=6
        lng=7
        csvarray = $boat_ramps
    elsif type == 'Ferry terminal'
        description = [1,2,5]
        lat=6
        lng=7
        csvarray = $ferry_terminals
    elsif type == 'Skate park'
        description = [1,2,3]
        lat=4
        lng=5
        csvarray = $skate_parks
    else
        description = [1,2,5]
        lat=6
        lng=7
        csvarray = $bus_stops
    end
    return { 
        :lat => lat, 
        :lng => lng, 
        :description => description,
        :csvarray => csvarray
    }
end

def find_closest(lat,long,type)
    # Get the column numbers and CSV data for this type
    idx = get_idx(type)
    # Extract the row data
    csv_array = idx[:csvarray]
    # Initialize "minimum distance" parameters.  These will be
    # updated during the loop below.
    min_idx = csv_array.length + 1
    min_dist = 1e20
    # Store the given (user-uploaded) latitude and longitude
    lat_idx = idx[:lat] # For bus stops, column 6  
    lng_idx = idx[:lng] # For bus stops, column 7
    # Loop over the council data, compute distance to the
    # user-supplied coordinates. Each time a smaller distance
    # is found, store the index of the council data record that
    # was closer.
    csv_array.each_with_index {|val, i| 
        # Casting
        bslat = val[lat_idx].to_f
        bslong = val[lng_idx].to_f
        # Calculate distance to user-provided coordinates
        dist = distance(lat,long,bslat,bslong)
        # If this distance is smaller than the most up-to-date
        # smallest value, then replace the stored one with this
        # new one and store the row index
        if dist < min_dist
            min_idx = i
            min_dist = dist
        end
    }
    # Whatever we are left with must be the closest thing, so
    # get the record of council data. Now we extract the required
    # columns out of the row.
    found = csv_array[min_idx]
    # Build a description of the entity by concatenating several
    # columns' data, according to what was defined in "get_idx"
    description = ""
    for i in idx[:description]
        description = description << "#{found[i]}" << '; '
    end
    # Return a hash with the complete combined data
    return {
        :entity_type => type, 
        :entity_description => description,
        :lat => found[lat_idx].to_f,
        :lng => found[lng_idx].to_f 
    }
end
