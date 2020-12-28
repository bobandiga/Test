//
//  GEntry.swift
//  GenesisWidget
//
//  Created by Максим Шаптала on 28.12.2020.
//

import Foundation
import WidgetKit

struct GEntry: TimelineEntry {
    var date: Date = Date()
    var collage: Collage
    var widgetType: WidgetType
    var selectedLayoutIndex: Int
}
