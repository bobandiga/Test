//
//  Provider.swift
//  GenesisWidget
//
//  Created by Максим Шаптала on 28.12.2020.
//

import Foundation
import WidgetKit

struct Provider: TimelineProvider {
    
    func placeholder(in context: Context) -> GEntry {
        return GEntry(collage: Collage(), widgetType: WidgetType.small, selectedLayoutIndex: 0)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (GEntry) -> Void) {
        DBManager().getActualEntity { (c, w, i) in
            completion(GEntry(collage: c, widgetType: w, selectedLayoutIndex: i))
        }
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<GEntry>) -> Void) {
        DBManager().getActualEntity { (c, w, i) in
            let entry = GEntry(collage: c, widgetType: w, selectedLayoutIndex: i)
            let timeline = Timeline(entries: [entry], policy: .never)
            completion(timeline)
        }
    }
    
}
