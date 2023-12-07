//
//  SubwayXRayApp.swift
//  SubwayXRay
//
//  Created by MyMac on 07/12/23.
//

import SwiftUI

@main
struct SubwayXRayApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
