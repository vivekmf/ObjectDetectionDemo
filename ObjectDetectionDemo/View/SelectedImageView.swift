//
//  SelectedImageView.swift
//  ObjectDetectionDemo
//
//  Created by Vivek Singh on 09/08/24.
//

import SwiftUI

struct SelectedImageView: View {
    var image: UIImage
    
    var body: some View {
        VStack {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .padding()
            
            HStack(spacing: 16) {
                NavigationLink(
                    destination: HomeView().toolbar(.hidden, for: .navigationBar),
                    label: {
                        SelectedImageButtonView(iconName: "photo.on.rectangle", text: "Select Image", gradient: Gradient(colors: [.blue, .purple]))
                    }
                )
                
                NavigationLink(
                    destination: ObjectDetectionView(image: image),
                    label: {
                        SelectedImageButtonView(iconName: "magnifyingglass", text: "View Objects", gradient: Gradient(colors: [.purple, .blue]))
                    }
                )
            }
            .padding()
        }
        .navigationTitle("Selected Image")
    }
}

struct SelectedImageButtonView: View {
    var iconName: String
    var text: String
    var gradient: Gradient
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .resizable()
                .scaledToFit()
                .frame(width: 22, height: 22)
                .foregroundColor(.white)
            
            Text(text)
                .font(.headline)
                .foregroundColor(.white)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(LinearGradient(gradient: gradient, startPoint: .leading, endPoint: .trailing))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

#Preview {
    SelectedImageView(image: UIImage(named: "sampleImage") ?? UIImage())
}
