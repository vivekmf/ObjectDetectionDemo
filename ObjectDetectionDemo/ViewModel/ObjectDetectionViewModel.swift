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

/// The view model responsible for object detection using Core ML and Vision.
class ObjectDetectionViewModel: ObservableObject {
    @Published var selectedImage: UIImage?
    @Published var detectedObjects: [DetectedObject] = []

    private var model: VNCoreMLModel?
    private var labelColorMap: [String: Color] = [:]
    private let colorPalette: [Color] = [
        .red, .green, .blue, .orange, .purple, .yellow, .pink, .brown, .cyan, .indigo
    ]

    init() {
        loadModel()
    }

    /// Loads the YOLOv3-Tiny Core ML model.
    private func loadModel() {
        do {
            let yoloModel = try YOLOv3Tiny(configuration: MLModelConfiguration())
            model = try VNCoreMLModel(for: yoloModel.model)
        } catch {
            print("Failed to load model: \(error.localizedDescription)")
        }
    }

    /// Selects an image and starts the object detection process.
    func selectImage(_ image: UIImage) {
        selectedImage = image
        detectObjectsInImage(image)
    }

    /// Detects objects in the selected image using the Core ML model.
    private func detectObjectsInImage(_ image: UIImage) {
        guard let model = model else { return }

        // Create a Core ML request for the model.
        let request = VNCoreMLRequest(model: model) { [weak self] request, error in
            self?.processDetections(for: request, error: error)
        }
        request.imageCropAndScaleOption = .scaleFill

        // Convert the UIImage to CIImage.
        guard let ciImage = CIImage(image: image) else { return }

        // Perform the request on a background thread.
        let handler = VNImageRequestHandler(ciImage: ciImage, options: [:])
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try handler.perform([request])
            } catch {
                print("Failed to perform detection: \(error.localizedDescription)")
            }
        }
    }

    /// Processes the results of the object detection request.
    private func processDetections(for request: VNRequest, error: Error?) {
        guard let results = request.results as? [VNRecognizedObjectObservation] else { return }

        var detectedObjects: [DetectedObject] = []

        // Map the detected objects to the DetectedObject model.
        for observation in results {
            let label = observation.labels.first?.identifier ?? "Unknown"
            let confidence = observation.labels.first?.confidence ?? 0
            let boundingBox = observation.boundingBox

            // Assign a color based on the label.
            let color = colorForLabel(label)

            // Create a DetectedObject and add it to the list.
            let detectedObject = DetectedObject(label: label, confidence: confidence, boundingBox: boundingBox, color: color)
            detectedObjects.append(detectedObject)
        }

        // Update the detected objects on the main thread.
        DispatchQueue.main.async {
            self.detectedObjects = detectedObjects
        }
    }

    /// Returns a unique color for each label.
    private func colorForLabel(_ label: String) -> Color {
        if let color = labelColorMap[label] {
            return color
        } else {
            // Cycle through the color palette to assign colors to new labels.
            let color = colorPalette[labelColorMap.count % colorPalette.count]
            labelColorMap[label] = color
            return color
        }
    }
}
