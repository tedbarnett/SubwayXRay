//
//  StopView.swift
//  SubwayXRay
//
//  Created by MyMac on 17/04/24.
//

import SwiftUI

struct StopView: View {
    let stop: StopRoute
    
    var body: some View {
        VStack {
            Text(stop.stop_name)
                .font(.headline)
                .padding(.vertical, 4)
            // You can customize the appearance of the stop name label further if needed
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(8)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(8)
        .position(x: CGFloat(stop.stop_lon), y: CGFloat(stop.stop_lat))
        // Use stop_lon for x-coordinate and stop_lat for y-coordinate
    }
}
//
//#Preview {
//    StopView()
//}
