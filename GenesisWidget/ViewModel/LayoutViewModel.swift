//
//  LayoutViewModel.swift
//  GenesisWidget
//
//  Created by Максим Шаптала on 27.12.2020.
//

import SwiftUI

final class LayoutViewModel: ObservableObject {
    @Published
    private(set) var selectedLayoutIndex: Int
    @Published
    private(set) var widgetType: WidgetType
    @Published
    private(set) var collage: Collage
    
    
    var limit: Int {
        switch widgetType {
        case .small:
            switch selectedLayoutIndex {
                case 0: return 3
                case 1: return 2
                case 2: return 2
                case 3: return 4
                default: return 0
            }
        case .medium:
            switch selectedLayoutIndex {
                case 0: return 4
                case 1: return 3
                case 2: return 3
                case 3: return 2
                default: return 0
            }
        case .large:
            switch selectedLayoutIndex {
                case 0: return 3
                case 1: return 4
                case 2: return 3
                case 3: return 3
                default: return 0
            }
        }
    }
    
    var bottomHeight: CGFloat {
        switch widgetType {
        case .small:
            return 164
        case .medium:
            return 270
        case .large:
            return 164
        }
    }
    
    init() {
        self.widgetType = .small
        self.collage = Collage()
        self.selectedLayoutIndex = 0
        
        DBManager().getActualEntity { (c, w, i) in
            self.selectedLayoutIndex = i
            self.widgetType = w
            self.collage = c
        }
    }
    
    func setImage(index: Int, image: UIImage?) {
        guard index <= limit else { return }
        collage.images[index] = image
    }
    
    func setCollage(index: Int) {
        selectedLayoutIndex = index
        for pair in collage.images {
            setImage(index: pair.key, image: pair.value)
        }
    }
    
    func clear() {
        for pair in collage.images {
            setImage(index: pair.key, image: nil)
        }
    }
    
    func saveWidgetCustomization() {
        DBManager().setActualEntity(collage: collage, widgetType: widgetType, index: selectedLayoutIndex)
    }
    
    func setWidgetType(type: WidgetType) {
        widgetType = type
        selectedLayoutIndex = 0
    }
}
