//
//  WatchFace.swift
//  InfiniLink
//
//  Created by Jen on 2/9/24.
//

import Foundation
import SwiftUI

struct WatchFace: View {
    @Environment(\.colorScheme) var colorScheme
    
    var Watchface = 0
    
    var body: some View {
        ZStack {
            Image("WatchScreen")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .brightness(colorScheme == .dark ? 0.0 : 0.065)
            GeometryReader { geometry in
                Image("Watchface-\(Watchface)")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width / 1.85, height: geometry.size.width / 1.85, alignment: .center)
                    .position(x: geometry.size.width / 2.0, y: geometry.size.width / 2.0 - 1.5)
                    .brightness(colorScheme == .dark ? 0.015 : 0.125)
            }
        }
    }
}

#Preview {
    NavigationView {
        DeviceView()
            .onAppear {
                BLEManager.shared.isConnectedToPinetime = true
                BLEManagerVal.shared.firmwareVersion = "1.14.0"
            }
    }
}
