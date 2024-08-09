//
//  SplashScreen.swift
//  ObjectDetectionDemo
//
//  Created by Vivek Singh on 09/08/24.
//

import Foundation
import SwiftUI

struct SplashScreen: View {
    @State private var isActive = false

    var body: some View {
        if isActive {
            HomeView()
        } else {
            VStack {
                Image(systemName: "camera.macro") // Replace with your app logo
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
                
                Text("Object Detection App")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
            }
            .onAppear {
                // Delay for 2 seconds before transitioning to the HomeView
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}
