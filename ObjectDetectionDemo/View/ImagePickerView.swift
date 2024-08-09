//
//  ImagePickerView.swift
//  ObjectDetectionDemo
//
//  Created by Vivek Singh on 09/08/24.
//

import SwiftUI

struct ImagePickerView: View {
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            ImagePicker(image: $selectedImage, sourceType: .photoLibrary, didFinishPicking: { image in
                self.selectedImage = image
                self.presentationMode.wrappedValue.dismiss()
            })
        }
    }
}
