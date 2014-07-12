
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
