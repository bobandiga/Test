//
//  DBManager.swift
//  GenesisWidget
//
//  Created by Максим Шаптала on 28.12.2020.
//

import Foundation
import DBManager

class DBManager {
    
    lazy var group = DispatchGroup()
    lazy var queue = DispatchQueue(label: "com.mx.concurrent", qos: .userInitiated, attributes: .concurrent)
    
    func getActualEntity(_ completion: @escaping (Collage, WidgetType, Int) -> Void) {
    
        var selectedLayoutIndex: Int = 0
        var widgetType: WidgetType = .small
        var collage: Collage = Collage()
        
        group.enter()
        queue.async(group: group) {
            DBULiteManager<Int>(suitName: "group.mx.GenesisWidget").receive(key: "SelectedIndex") { [weak self] (index) in
                guard let i = index else { return }
                selectedLayoutIndex = i
                self?.group.leave()
            }
        }
        
        group.enter()
        queue.async(group: group) {
            DBULiteManager<WidgetType>(suitName: "group.mx.GenesisWidget").receive(key: "WidgetType") { [weak self] (type) in
                guard let type = type else { return }
                widgetType = type
                self?.group.leave()
            }
        }
        
        group.enter()
        queue.async(group: group) {
            DBULiteManager<Collage>(suitName: "group.mx.GenesisWidget").receive(key: "Collage") { [weak self] (_collage) in
                guard let c = _collage else { return }
                collage = c
                self?.group.leave()
            }
        }
        
        group.wait()
        group.notify(queue: DispatchQueue.main) {
            completion(collage, widgetType, selectedLayoutIndex)
        }
    }
    
    func setActualEntity(collage: Collage, widgetType: WidgetType, index: Int) {
        queue.async {
            DBULiteManager<Int>(suitName: "group.mx.GenesisWidget").save(entity: index, key: "SelectedIndex")
        }
        queue.async {
            DBULiteManager<WidgetType>(suitName: "group.mx.GenesisWidget").save(entity: widgetType, key: "WidgetType")
        }
        queue.async {
            DBULiteManager<Collage>(suitName: "group.mx.GenesisWidget").save(entity: collage, key: "Collage")
        }
    }
}
