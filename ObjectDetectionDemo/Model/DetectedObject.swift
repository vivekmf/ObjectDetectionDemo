//
//  DetectedObject.swift
//  ObjectDetectionDemo
//
//  Created by Vivek Singh on 09/08/24.
//

import Foundation
import CoreGraphics
import SwiftUI

/// A model representing a detected object with a unique identifier, label, confidence score, bounding box, and associated color.
struct DetectedObject: Identifiable {
    var id: UUID { UUID() }
    let label: String
    let confidence: Float
    let boundingBox: CGRect
    let color: Color
}
