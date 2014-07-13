
$bus_stops = CSV.read('raw_data/brisbane_bus_stops.csv', headers:true)
$playgrounds = CSV.read('raw_data/playgrounds.csv', headers:true)
$bbqs= CSV.read('raw_data/bbq.csv', headers:true)
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
    (lat1-lat2)**2 + (long1-long2)**2
end

def find_closest_busstop(lat,long)
    min_idx = $bus_stops.length + 1
    min_dist = 1e20
    $bus_stops.each_with_index {|val, i| 
        # TODO This is ugly, we should use column names for lookups,
        # not indexes
        bslat = val[6].to_f
        bslong = val[7].to_f
        #s = s << sm.to_s << "\t" << val[6] << "\t" << val[7] << "<br>" # "hello\n" 
        dist = distance(lat,long,bslat,bslong)
        #print "#{i} = #{dist}\n"
        if dist < min_dist
            min_idx = i
            min_dist = dist
        end
        #if i > 10 
        #    break
        #end
    }
    found = $bus_stops[min_idx]
    #s = s << $bus_stops[min_idx].to_s
    #s
end

def get_idx(type)
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

def get_csv_array(type)
    if type == 'Bus Stop'
        return $bus_stops
    elsif type == 'Playground'
        return $playgrounds
    else
        return $bus_stops
    end
end

def find_closest(lat,long,type)
    idx = get_idx(type)
    csv_array = idx[:csvarray]# get_csv_array(type) # For bus stops, this is $bus_stops
    min_idx = csv_array.length + 1
    min_dist = 1e20
    puts idx[:lat]
    lat_idx = idx[:lat] # For bus stops, column 6  
    lng_idx = idx[:lng] # For bus stops, column 7
    puts lat_idx
    csv_array.each_with_index {|val, i| 
        bslat = val[lat_idx].to_f
        bslong = val[lng_idx].to_f
        dist = distance(lat,long,bslat,bslong)
        if dist < min_dist
            min_idx = i
            min_dist = dist
        end
    }
    found = csv_array[min_idx]
    description = ""
    for i in idx[:description]
        description = description << "#{found[i]}" << '; '
    end
    return {
        :entity_type => type, 
        :entity_description => description,
        :lat => found[lat_idx].to_f,
        :lng => found[lng_idx].to_f 
    }
end
