//
//  SubwayXRayApp.swift
//  SubwayXRay
//
//  Created by MyMac on 25/12/23.
//

import SwiftUI
import FirebaseCore

@main
struct SubwayXRayApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
