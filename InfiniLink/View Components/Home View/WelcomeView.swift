//
//  WelcomeView.swift
//  InfiniLink
//
//  Created by John Stanley on 5/2/22.
//

import SwiftUI

struct WelcomeView: View {
    @ObservedObject var bleManager = BLEManager.shared
    @ObservedObject var deviceInfo = BLEDeviceInfo.shared
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            if !bleManager.isConnectedToPinetime || deviceInfo.firmware == "" {
                if bleManager.isConnectedToPinetime {
                    ZStack {
                        DeviceView()
                            .disabled(true)
                            .blur(radius: 70)
                        VStack(spacing: 16) {
                            Text(NSLocalizedString("connecting", comment: "Connecting..."))
                                .font(.title.weight(.bold))
                            Button {
                                bleManager.disconnect()
                            } label: {
                                Text(NSLocalizedString("stop_connecting", comment: "Stop Connecting"))
                                    .padding()
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .clipShape(Capsule())
                            }
                        }
                    }
                } else {
                    ZStack {
                        //VStack {
                        GeometryReader { geometry in
                            Image("WatchHomePagePineTime")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geometry.size.height * 1.1, height: geometry.size.height * 1.1, alignment: .center)
                                .position(x: geometry.size.width / 2, y: geometry.size.height / 2.0)
                                .shadow(color: colorScheme == .dark ? Color.darkGray : Color.lightGray, radius: 128, x: 0, y: 0)
                                .brightness(colorScheme == .dark ? -0.01 : 0.06)
                            //.clipped()
                        }
                        VStack() {
                            VStack(spacing: 5) {
                                Text("Welcome to InfiniLink")
                                    .font(.system(size: 28).weight(.medium))
                                    .foregroundColor(colorScheme == .dark ? Color.gray : Color.gray)
                                    //.foregroundColor(.lightGray)
                                //.padding(32)
                                    //.padding(.top)
                                    .padding(.top)
                                    .padding(.top, 25)
                                    .padding(.horizontal)
                                    .multilineTextAlignment(.center)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                Spacer()
                                //if bleManager.isSwitchedOn {
                                Button(NSLocalizedString("start_pairing", comment: "")) {
                                    SheetManager.shared.sheetSelection = .connect
                                    SheetManager.shared.showSheet = true
                                }
                                .buttonStyle(NeumorphicButtonStyle(bgColor: colorScheme == .dark ? Color.darkGray : Color.lightGray))
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.bottom, 15)
                                .padding(.horizontal)
                                .onAppear {
                                    if bleManager.isSwitchedOn {
                                        bleManager.startScanning()
                                    }
                                }
                                Text("Don't hve a Watch?")
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .padding(.horizontal)
                                    .foregroundColor(.gray)
                                Text("Learn more about the PineTime")
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .foregroundColor(.blue)
                                    .padding(.bottom, 5)
                                //.padding(.bottom)
                                    .padding(.horizontal)
                                //                            } else {
                                //                                Text("Bluetooth is Disabled")
                                //                                    .frame(maxWidth: .infinity, alignment: .center)
                                //                                    .padding(.bottom)
                                //                                    .padding(.bottom)
                                //                                    .padding(.horizontal)
                                //                            }
                            }
                            //.padding(.vertical, 20)
                            .padding()
                        }
                    }
                    //.fullBackground(imageName: "WatchHomePagePineTime")
                }
                
            } else {
                DeviceView()
            }
        }
        .background {
            ZStack {
                VStack {
                    Circle()
                        .fill(Color("Blue"))
                        .scaleEffect(0.7)
                        .offset(x: 20)
                        .blur(radius: 60)
                    Circle()
                        .fill(Color("Blue"))
                        .scaleEffect(0.7, anchor: .leading)
                        .offset(y: -20)
                        .blur(radius: 56)
    
                }
                Rectangle()
                    .fill(colorScheme == .dark ? Color.black : Color.white)
                    .opacity(0.9)
            }
            .ignoresSafeArea()
        }
        .onAppear {
            if bleManager.isSwitchedOn {
                bleManager.startScanning()
            }
        }
        .onDisappear {
            if bleManager.isScanning {
                bleManager.stopScanning()
            }
        }
        
    }
    
}

struct NeumorphicButtonStyle: ButtonStyle {
    var bgColor: Color

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(15)
            .frame(maxWidth: .infinity, alignment: .center)
            .font(.body.weight(.semibold))
            .foregroundColor(Color.white)
            .background(Color.blue)
            .clipShape(Capsule())
            .foregroundColor(.primary)
    }
}

public extension View {
    func fullBackground(imageName: String) -> some View {
       return background(
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    //.edgesIgnoringSafeArea(.all)
       )
       .frame(alignment: .center)
    }
}

#Preview {
    NavigationView {
        ContentView()
            .onAppear {
                BLEManager.shared.isConnectedToPinetime = false
                //BLEManagerVal.shared.firmwareVersion = "1.13.0"
            }
    }
}
