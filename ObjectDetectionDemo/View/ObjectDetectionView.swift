//
//  ObjectDetectionView.swift
//  ObjectDetectionDemo
//
//  Created by Vivek Singh on 09/08/24.
//

import SwiftUI

struct ObjectDetectionView: View {
    let image: UIImage
    @ObservedObject var viewModel = ObjectDetectionViewModel()

    var body: some View {
        VStack {
            if viewModel.selectedImage == nil {
                Text("Detecting objects...")
                    .onAppear {
                        viewModel.selectImage(image)
                    }
            } else if let detectedImage = viewModel.selectedImage {
                GeometryReader { geometry in
                    ZStack {
                        Image(uiImage: detectedImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .overlay(
                                detectionOverlay(for: geometry.size)
                            )
                    }
                }
                .aspectRatio(image.size, contentMode: .fit)
            }
        }
        .padding()
        .navigationTitle("Object Detection")
    }

    private func detectionOverlay(for imageSize: CGSize) -> some View {
        ForEach(viewModel.detectedObjects) { object in
            let boundingBox = boundingBox(for: object.boundingBox, in: imageSize)

            ZStack {
                Rectangle()
                    .stroke(object.color, lineWidth: 2)
                    .frame(width: boundingBox.width, height: boundingBox.height)
                    .position(x: boundingBox.midX, y: boundingBox.midY)

                Text("\(object.label) (\(Int(object.confidence * 100))%)")
                    .font(.caption)
                    .background(object.color.opacity(0.7))
                    .foregroundColor(.white)
                    .position(x: boundingBox.midX, y: boundingBox.minY - 10)
            }
        }
    }

    private func boundingBox(for normalizedRect: CGRect, in imageSize: CGSize) -> CGRect {
        let adjustedWidth = normalizedRect.width * imageSize.width
        let adjustedHeight = normalizedRect.height * imageSize.height
        let adjustedX = normalizedRect.minX * imageSize.width
        let adjustedY = (1 - normalizedRect.maxY) * imageSize.height

        return CGRect(x: adjustedX, y: adjustedY, width: adjustedWidth, height: adjustedHeight)
    }
}
