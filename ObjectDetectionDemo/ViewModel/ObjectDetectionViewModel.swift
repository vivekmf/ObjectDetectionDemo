//
//  ObjectDetectionViewModel.swift
//  ObjectDetectionDemo
//
//  Created by Vivek Singh on 09/08/24.
//

import SwiftUI
import CoreML
import Vision
import UIKit

class ObjectDetectionViewModel: ObservableObject {
    @Published var selectedImage: UIImage?
    @Published var detectedObjects: [DetectedObject] = []

    private var model: VNCoreMLModel?
    private var labelColorMap: [String: Color] = [:]
    private let colorPalette: [Color] = [
        .red, .green, .blue, .orange, .purple, .yellow, .pink, .brown, .cyan, .indigo
    ]

    init() {
        // Load the Core ML model
        do {
            let yoloModel = try YOLOv3Tiny(configuration: MLModelConfiguration())
            model = try VNCoreMLModel(for: yoloModel.model)
        } catch {
            print("Failed to load model: \(error.localizedDescription)")
        }
    }

    func selectImage(_ image: UIImage) {
        selectedImage = image
        detectObjectsInImage(image)
    }

    private func detectObjectsInImage(_ image: UIImage) {
        guard let model = model else { return }

        let request = VNCoreMLRequest(model: model) { [weak self] request, error in
            self?.processDetections(for: request, error: error)
        }
        request.imageCropAndScaleOption = .scaleFill

        guard let ciImage = CIImage(image: image) else { return }

        let handler = VNImageRequestHandler(ciImage: ciImage, options: [:])
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try handler.perform([request])
            } catch {
                print("Failed to perform detection: \(error.localizedDescription)")
            }
        }
    }

    private func processDetections(for request: VNRequest, error: Error?) {
        guard let results = request.results as? [VNRecognizedObjectObservation] else { return }

        var detectedObjects: [DetectedObject] = []

        for observation in results {
            let label = observation.labels.first?.identifier ?? "Unknown"
            let confidence = observation.labels.first?.confidence ?? 0
            let boundingBox = observation.boundingBox

            let color = colorForLabel(label)

            let detectedObject = DetectedObject(label: label, confidence: confidence, boundingBox: boundingBox, color: color)
            detectedObjects.append(detectedObject)
        }

        DispatchQueue.main.async {
            self.detectedObjects = detectedObjects
        }
    }

    private func colorForLabel(_ label: String) -> Color {
        if let color = labelColorMap[label] {
            return color
        } else {
            let color = colorPalette[labelColorMap.count % colorPalette.count]
            labelColorMap[label] = color
            return color
        }
    }
}
