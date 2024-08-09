//
//  ContentView.swift
//  ObjectDetectionDemo
//
//  Created by Vivek Singh on 08/08/24.
//

import SwiftUI

/// The main view for the home screen, allowing the user to select an image and navigate to object detection.
struct HomeView: View {
    @State private var isImagePickerPresented = false
    @State private var selectedImage: UIImage?
    @State private var navigateToSelectedImageView = false

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()

                Text("Welcome to Object Detection")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()

                Spacer()

                Button(action: {
                    isImagePickerPresented.toggle()
                }) {
                    Text("Select Photo")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .padding(.horizontal)
                .sheet(isPresented: $isImagePickerPresented) {
                    ImagePickerView(selectedImage: $selectedImage)
                }

                NavigationLink(
                    value: selectedImage,
                    label: {
                        EmptyView()
                    }
                )
                .navigationDestination(isPresented: $navigateToSelectedImageView) {
                    SelectedImageView(image: selectedImage ?? UIImage())
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Home")
            .onChange(of: selectedImage) { oldImage, newImage in
                if newImage != nil {
                    navigateToSelectedImageView = true
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
