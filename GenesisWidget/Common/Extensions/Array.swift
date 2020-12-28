//
//  Array.swift
//  GenesisWidget
//
//  Created by Максим Шаптала on 28.12.2020.
//

extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
