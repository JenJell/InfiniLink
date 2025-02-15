//
//  WatchFace.swift
//  InfiniLink
//
//  Created by Jen on 2/9/24.
//

import Foundation
import SwiftUI
import Combine


struct WatchFaceView: View {
    @ObservedObject var bleManagerVal = BLEManagerVal.shared
    @Environment(\.colorScheme) var colorScheme
    
    let date = Date()
    
    @Binding var watchface: Int
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("WatchScreen")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .shadow(color: colorScheme == .dark ? Color.black : Color.secondary, radius: 16, x: 0, y: 0)
                    .brightness(colorScheme == .dark ? -0.02 : 0.035)
                ZStack() {
                    ZStack {
                        switch watchface == -1 ? bleManagerVal.watchFace : watchface {
                        case 0:
                            DigitalWF(geometry: .constant(geometry))
                        case 2:
                            PineTimeStyleWF(geometry: .constant(geometry))
                        default:
                            UnknownWF(geometry: .constant(geometry))
                        }
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .bottomLeading)
                    .scaleEffect(0.53, anchor: .center)
                    .frame(width: geometry.size.width, height: geometry.size.width, alignment: .center)
                    .position(x: geometry.size.width / 2, y: geometry.size.width / 2 - 2)
                    .brightness(colorScheme == .dark ? 0.015 : 0.125)
                    .clipped()
                }
                .frame(width: geometry.size.width, height: geometry.size.width, alignment: .center)
                .clipped()
                Image("WatchHomeClear")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .brightness(colorScheme == .dark ? 0.0 : 0.04)
            }
        }
    }
}

struct PineTimeStyleWF: View {
    @ObservedObject var bleManagerVal = BLEManagerVal.shared
    @Environment(\.colorScheme) var colorScheme
    @Binding var geometry: GeometryProxy
    
    var hour24: Bool {
        switch bleManagerVal.timeFormat {
        case .H12:
            return false
        case .H24:
            return true
        default:
            return true
        }
    }
    
    var backgroundColor: Color {
        switch bleManagerVal.pineTimeStyleData?.ColorBG {
        case .White:
            return .white
        case .Silver:
            return .lightGray
        case .Gray:
            return .gray
        case .Black:
            return .black
        case .Red:
            return .red
        case .Maroon:
            // Add more accurate color
            return .red
        case .Yellow:
            return .yellow
        case .Olive:
            // Add more accurate color
            return .green
        case .Lime:
            // Add more accurate color
            return .green
        case .Green:
            return .green
        case .Cyan:
            return .cyan
        case .Teal:
            return .teal
        case .Blue:
            return .blue
        case .Navy:
            // Add more accurate color
            return .blue
        case .Magenta:
            // Add more accurate color
            return .purple
        case .Purple:
            return .white
        case .Orange:
            return .orange
        case .Pink:
            return .pink
        case nil:
            return .teal
        }
    }
    var barColor: Color {
        switch bleManagerVal.pineTimeStyleData?.ColorBar {
        case .White:
            return .white
        case .Silver:
            return .lightGray
        case .Gray:
            return .gray
        case .Black:
            return .black
        case .Red:
            return .red
        case .Maroon:
            // Add more accurate color
            return .red
        case .Yellow:
            return .yellow
        case .Olive:
            // Add more accurate color
            return .green
        case .Lime:
            // Add more accurate color
            return .green
        case .Green:
            return .green
        case .Cyan:
            return .cyan
        case .Teal:
            return .teal
        case .Blue:
            return .blue
        case .Navy:
            // Add more accurate color
            return .blue
        case .Magenta:
            // Add more accurate color
            return .purple
        case .Purple:
            return .white
        case .Orange:
            return .orange
        case .Pink:
            return .pink
        case nil:
            return .teal
        }
    }
    var timeColor: Color {
        switch bleManagerVal.pineTimeStyleData?.ColorTime {
        case .White:
            return .white
        case .Silver:
            return .lightGray
        case .Gray:
            return .gray
        case .Black:
            return .black
        case .Red:
            return .red
        case .Maroon:
            // Add more accurate color
            return .red
        case .Yellow:
            return .yellow
        case .Olive:
            // Add more accurate color
            return .green
        case .Lime:
            // Add more accurate color
            return .green
        case .Green:
            return .green
        case .Cyan:
            return .cyan
        case .Teal:
            return .teal
        case .Blue:
            return .blue
        case .Navy:
            // Add more accurate color
            return .blue
        case .Magenta:
            // Add more accurate color
            return .purple
        case .Purple:
            return .white
        case .Orange:
            return .orange
        case .Pink:
            return .pink
        case nil:
            return .teal
        }
    }
    
    var body: some View {
        ZStack {
            backgroundColor
            if !hour24 {
                CustomTextView(text: Calendar.current.component(.hour, from: Date()) > 12 ? "P\nM" : "A\nM", font: .custom("JetBrainsMono-ExtraBold", size: geometry.size.width * 0.075), lineSpacing: -4)
                    .foregroundColor(timeColor)
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .bottomLeading)
            }
            if Calendar.current.component(.hour, from: Date()) > 12 && !hour24 {
                CustomTextView(text: "\(String(format: "%02d", Calendar.current.component(.hour, from: Date()) - 12))\n\(String(format: "%02d", Calendar.current.component(.minute, from: Date())))", font: .custom("OpenSans-light", size: geometry.size.width * 0.62), lineSpacing: -geometry.size.width * 0.35)
                    .foregroundColor(timeColor)
                    .position(x: geometry.size.width / 2.3, y: geometry.size.height / 2.0)
            } else {
                CustomTextView(text: "\(String(format: "%02d", Calendar.current.component(.hour, from: Date())))\n\(String(format: "%02d", Calendar.current.component(.minute, from: Date())))", font: .custom("OpenSans-light", size: geometry.size.width * 0.62), lineSpacing: -geometry.size.width * 0.35)
                    .foregroundColor(timeColor)
                    .position(x: geometry.size.width / 2.3, y: geometry.size.height / 2.0)
            }
            GeometryReader { geometry in
                Rectangle()
                    .foregroundColor(barColor)
                    .position(x: geometry.size.width - ((geometry.size.width / 6.0) / 2), y: geometry.size.height / 2 - 2)
                    .frame(width: geometry.size.width / 6.0, height: geometry.size.height + 4, alignment: .center)
            }
        }
    }
}

struct DigitalWF: View {
    @ObservedObject var bleManagerVal = BLEManagerVal.shared
    @Environment(\.colorScheme) var colorScheme
    @Binding var geometry: GeometryProxy
    
    var hour24: Bool {
        switch bleManagerVal.timeFormat {
        case .H12:
            return false
        case .H24:
            return true
        default:
            return true
        }
    }
    
    var body: some View {
        ZStack {
            if !hour24 {
                CustomTextView(text: Calendar.current.component(.hour, from: Date()) > 12 ? "PM" : "AM", font: .custom("JetBrainsMono-Bold", size: geometry.size.width * 0.08), lineSpacing: 0)
                    .foregroundColor(.white)
                    .frame(width: geometry.size.width, height: geometry.size.height / 2.15, alignment: .topTrailing)
            }
            if Calendar.current.component(.hour, from: Date()) > 12 && !hour24 {
                CustomTextView(text: "\(String(format: "%02d", Calendar.current.component(.hour, from: Date()) - 12)):\(String(format: "%02d", Calendar.current.component(.minute, from: Date())))", font: .custom("JetBrainsMono-ExtraBold", size: geometry.size.width * 0.335), lineSpacing: 0)
                    .foregroundColor(.white)
                    .position(x: geometry.size.width / 2.0, y: geometry.size.height / 1.8)
            } else {
                CustomTextView(text: "\(String(format: "%02d", Calendar.current.component(.hour, from: Date()))):\(String(format: "%02d", Calendar.current.component(.minute, from: Date())))", font: .custom("JetBrainsMono-ExtraBold", size: geometry.size.width * 0.335), lineSpacing: 0)
                    .foregroundColor(.white)
                    .position(x: geometry.size.width / 2.0, y: geometry.size.height / 1.8)
            }
        }
    }
}

struct UnknownWF: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var geometry: GeometryProxy
    
    var body: some View {
        VStack {
            ProgressView()
        }
        .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
    }
}

struct CustomTextView: View {
    var text: String
    var font: Font
    var lineSpacing: CGFloat

    var body: some View {
        VStack(alignment: .leading, spacing: lineSpacing) {
            ForEach(text.components(separatedBy: "\n"), id: \.self) { line in
                Text(line)
                    .font(font)
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
