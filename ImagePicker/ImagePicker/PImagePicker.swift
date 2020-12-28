//
//  PImagePicker.swift
//  ImagePicker
//
//  Created by Максим Шаптала on 27.12.2020.
//

import SwiftUI
import PhotosUI

public struct PImagePicker: UIViewControllerRepresentable {
    public func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    
    @Binding public var isOpened: Bool
    
    var imageCallback: (UIImage) -> Void
    var imagesCallback: (Int, UIImage) -> Void
    public var selectionLimit: Int
    
    public init(imageCallback: @escaping (UIImage) -> Void, imagesCallback: @escaping (Int, UIImage) -> Void, isOpened: Binding<Bool>,  limit: Int = 0) {
        self.imageCallback = imageCallback
        self._isOpened = isOpened
        self.selectionLimit = limit
        self.imagesCallback = imagesCallback
    }
    
    public func makeUIViewController(context: Context) -> some UIViewController {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = selectionLimit
        configuration.filter = .images
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }
    
    public func makeCoordinator() -> Coordinator {
        return Coordinator(imagePicker: self)
    }
    
}
