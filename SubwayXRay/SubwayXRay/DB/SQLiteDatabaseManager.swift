//
//  SQLiteDatabaseManager.swift
//  demoSQLiteDB
//
//  Created by MyMac on 22/12/23.
//

import Foundation

struct SQLiteDatabaseManager {
    let db = SQLiteDB.shared
    
    func openDataBase() {
        _ = db.open(copyFile:true)
        //let data = db.query(sql:"select * from stops")
        let data = db.query(sql:"select * from trips t, stop_times st where t.route_id = '1' and t.trip_id = st.trip_id and st.stop_sequence = 1")
        let row = data[0]
        print(data.count)
    }
    
    func getAllACEStopes() -> [StopRoute] {
        _ = db.open(copyFile:true)
        let stopRouteData = db.query(sql:"SELECT unique_stops.route_id, unique_stops.stop_id, stop_name, stop_lat, stop_lon FROM stops, (SELECT stop_id, route_id FROM stop_times, (SELECT trip_id, route_id FROM trips WHERE route_id IN ('A', 'C', 'E') GROUP BY direction_id ) AS unique_trips WHERE stop_times.trip_id = unique_trips.trip_id GROUP BY stop_id) AS unique_stops WHERE stops.stop_id = unique_stops.stop_id")
        
        let stopRoute = stopRouteData.map { stopData in
            StopRoute(stop_id: stopData["stop_id"] as? String ?? "",
                      stop_name: stopData["stop_name"] as? String ?? "",
                      route_id: stopData["route_id"] as? String ?? "",
                      stop_lat: stopData["stop_lat"] as? Double ?? 0.0,
                      stop_lon: stopData["stop_lon"] as? Double ?? 0.0)
        }
        
        return stopRoute
    }
    
    func getAll1Stopes() -> [StopRoute] {
        _ = db.open(copyFile:true)
        let stopRouteData = db.query(sql:"SELECT unique_stops.route_id, unique_stops.stop_id, stop_name, stop_lat, stop_lon FROM stops, (SELECT stop_id, route_id FROM stop_times, (SELECT trip_id, route_id FROM trips WHERE route_id IN ('1') GROUP BY direction_id ) AS unique_trips WHERE stop_times.trip_id = unique_trips.trip_id GROUP BY stop_id) AS unique_stops WHERE stops.stop_id = unique_stops.stop_id")
        
        let stopRoute = stopRouteData.map { stopData in
            StopRoute(stop_id: stopData["stop_id"] as? String ?? "",
                      stop_name: stopData["stop_name"] as? String ?? "",
                      route_id: stopData["route_id"] as? String ?? "",
                      stop_lat: stopData["stop_lat"] as? Double ?? 0.0,
                      stop_lon: stopData["stop_lon"] as? Double ?? 0.0)
        }
        
        return stopRoute
    }
}
