//
//  ContentView.swift
//  SubwayXRay
//
//  Created by MyMac on 25/12/23.
//

import SwiftUI
import RealityKit
import RealityKitContent
import MapKit

struct ContentView: View {
    
    @State private var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    @StateObject var locationManager = LocationManager()
    @State var cloudFunctionManager = CloudFunctionManager()
    @State private var stopRouteACE = [StopRoute]()
    @State private var stopRouteFor1 = [StopRoute]()
    @State var aceData: [TransitRealtime_FeedEntity]?
    @AppStorage("apiKey") var apiKey = "mI2cquz12l3pD4XDomPFR6Evd0Y1aiGQ6pBnpKHx"
    
    var body: some View {
        Map(position: $cameraPosition) {
            
            //For ACE
            let coordinates = stopRouteACE.map { CLLocationCoordinate2D(latitude: $0.stop_lat, longitude: $0.stop_lon) }
            MapPolyline(coordinates: coordinates)
                .stroke(Color("Blue"), lineWidth: 10)
            
            //For 1
            let coordinates1 = stopRouteFor1.map { CLLocationCoordinate2D(latitude: $0.stop_lat, longitude: $0.stop_lon) }
            MapPolyline(coordinates: coordinates1)
                .stroke(Color("Orange"), lineWidth: 10)
            
            //For ACE
            ForEach(stopRouteACE) { route in
                Annotation(route.stop_name, coordinate: CLLocationCoordinate2D(latitude: route.stop_lat, longitude: route.stop_lon), anchor: .leading) {
                    ZStack {
                        Image(systemName: "tram.circle.fill")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .foregroundColor(.white)
                            .background(Color("Blue"))
                            .clipShape(Circle())
                    }
                }
                .annotationTitles(.visible)
            }
            
            //For 1
            ForEach(stopRouteFor1) { route in
                Annotation(route.stop_name, coordinate: CLLocationCoordinate2D(latitude: route.stop_lat, longitude: route.stop_lon), anchor: .leading) {
                    ZStack {
                        Image(systemName: "tram.circle.fill")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .foregroundColor(.white)
                            .background(Color("Orange"))
                            .clipShape(Circle())
                    }
                }
                .annotationTitles(.visible)
            }
        }
        .safeAreaPadding(.all)
        .mapStyle(.standard)
        .preferredColorScheme(.light)
        .mapControls {
            MapUserLocationButton()
            MapCompass()
            MapPitchToggle()
            MapScaleView()
        }
        .onAppear {
            cameraPosition = .region(locationManager.region)
            self.stopRouteACE = SQLiteDatabaseManager().getAllACEStopes()
            self.stopRouteFor1 = SQLiteDatabaseManager().getAll1Stopes()
            
            print(self.stopRouteACE[0])
            //self.cloudFunctionManager.getGTFSACE()
            self.serviceACEPull()
            /*Task {
                do {
                    try await self.cloudFunctionManager.getGTFSACE()
                }
                catch let error {
                    print(error.localizedDescription)
                }
            }*/
        }
        .onMapCameraChange {
            print("")
        }
    }
    
    private func routePolyline(stops: [StopRoute]) -> MKPolyline {
        let coordinates = stops.map { CLLocationCoordinate2D(latitude: $0.stop_lat, longitude: $0.stop_lon) }
        return MKPolyline(coordinates: coordinates, count: coordinates.count)
    }
    
    func serviceACEPull() {
        var request = URLRequest(url: URL(string: "https://api-endpoint.mta.info/Dataservice/mtagtfsfeeds/nyct%2Fgtfs-ace")!)
        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
        print(request)
        
        URLSession.shared.dataTask(with: request) { (data, _, _) in
            // custom type
            
            guard let response = try? TransitRealtime_FeedMessage(serializedData: data!) else {
                // error
                return
            }
            
            guard let receivedFromJSON = try? TransitRealtime_FeedMessage(jsonUTF8Data: response.jsonUTF8Data()) else{
                return
            }
            aceData = receivedFromJSON.entity
            print(aceData as Any)
                        
        }.resume()
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
