# ObjectDetectionDemo

## Overview

This project is a SwiftUI-based mobile application that allows users to select an image and detect objects within it using the YOLOv3-Tiny model integrated with Core ML. The app is built with a clean MVVM architecture, ensuring scalability, readability, and maintainability.

## Features

- **Object Detection**: Detects multiple objects in an image using the YOLOv3-Tiny model.
- **Image Picker**: Allows users to select an image from their photo library.
- **Real-Time Detection**: Objects are detected in real-time with confidence scores and bounding boxes.
- **Modular Architecture**: Code is organized in a modular way using SwiftUI, UIKit, and Core ML.

## Project Structure

The project is organized into several files, each responsible for specific functionality:

- **App Entry Point:**
  - `ObjectDetectionDemoApp.swift`: Contains the main entry point of the app and launches the `SplashScreen`.

- **View Models:**
  - `ObjectDetectionViewModel.swift`: Handles the business logic of detecting objects using Core ML and Vision.

- **Views:**
  - `HomeView.swift`: The main view of the app where users can start by selecting an image.
  - `ImagePickerView.swift`: A SwiftUI wrapper for the `ImagePicker` to handle image selection.
  - `ObjectDetectionView.swift`: Displays the selected image along with detected objects.
  - `SelectedImageView.swift`: Allows users to view the selected image and navigate to object detection.
  - `SplashScreen.swift`: The initial screen that shows a splash animation before the `HomeView` is displayed.

- **Helpers:**
  - `ImagePicker.swift`: A UIKit-based image picker wrapped in a SwiftUI-compatible view.

## Installation

### Prerequisites

- Xcode 15.0 or later
- iOS 15.0 or later

### Setup

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/vivekmf/ObjectDetectionDemo.git
