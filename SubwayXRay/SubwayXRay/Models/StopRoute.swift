//
//  StopRoute.swift
//  SubwayXRay
//
//  Created by MyMac on 25/12/23.
//

import Foundation

struct StopRoute: Identifiable {
    let id = UUID()
    let stop_id: String
    let stop_name: String
    let route_id: String
    let stop_lat: Double
    let stop_lon: Double
    
    init(stop_id: String, stop_name: String, route_id: String, stop_lat: Double, stop_lon: Double) {
        self.stop_id = stop_id
        self.stop_name = stop_name
        self.route_id = route_id
        self.stop_lat = stop_lat
        self.stop_lon = stop_lon
    }
}
