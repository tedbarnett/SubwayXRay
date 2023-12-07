//
//  ContentView.swift
//  SubwayXRay
//
//  Created by MyMac on 07/12/23.
//

import SwiftUI
import RealityKit
import RealityKitContent
import MapKit

struct ContentView: View {
    
    @State private var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
//    @State private var cameraPosition: MapCameraPosition = .automatic
    @StateObject var locationManager = LocationManager()
    
    var body: some View {
                        
        Map(position: $cameraPosition) {

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
        }
        
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
