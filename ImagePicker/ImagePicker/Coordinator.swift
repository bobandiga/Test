//
//  Coordinator.swift
//  ImagePicker
//
//  Created by Максим Шаптала on 27.12.2020.
//

import Foundation
import PhotosUI

public class Coordinator: NSObject, PHPickerViewControllerDelegate {
    var parent: PImagePicker
    
    init(imagePicker: PImagePicker) {
        self.parent = imagePicker
    }
    
    public func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        parent.isOpened.toggle()
        if results.count == 1, let result = results.first {
            guard result.itemProvider.canLoadObject(ofClass: UIImage.self) else { return }
            result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (_image, _error) in
                guard _error == nil, let image = _image as? UIImage else { return }
                DispatchQueue.main.async {
                    self?.parent.imageCallback(image)
                }
            }
        } else {
            for (index, result) in results.enumerated() {
                guard result.itemProvider.canLoadObject(ofClass: UIImage.self) else { return }
                result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (_image, _error) in
                    guard _error == nil, let image = _image as? UIImage else { return }
                    DispatchQueue.main.async {
                        self?.parent.imagesCallback(index, image)
                    }
                }
            }
        }
    }
}
