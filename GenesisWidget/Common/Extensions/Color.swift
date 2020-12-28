//
//  Color.swift
//  GenesisWidget
//
//  Created by Максим Шаптала on 27.12.2020.
//

import SwiftUI

extension Color {
    static func borderGray() -> Color {
        return Color(red: 1, green: 1, blue: 1, opacity: 0.1)
    }
    
    static func lightGray() -> Color {
        return Color(red: 1, green: 1, blue: 1, opacity: 0.15)
    }
    
    static func darkGray() -> Color {
        return Color(red: 0.108, green: 0.108, blue: 0.117, opacity: 1)
    }
    
    static func selectedGray() -> Color {
        return Color(red: 1, green: 1, blue: 1, opacity: 0.3)
    }
}
