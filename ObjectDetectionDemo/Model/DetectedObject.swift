//
//  DetectedObject.swift
//  ObjectDetectionDemo
//
//  Created by Vivek Singh on 09/08/24.
//

import Foundation
import CoreGraphics
import SwiftUI

struct DetectedObject: Identifiable {
    var id: UUID { UUID() }
    let label: String
    let confidence: Float
    let boundingBox: CGRect
    let color: Color
}
