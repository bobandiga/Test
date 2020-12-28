//
//  WidgetEntryView.swift
//  GenesisWidget
//
//  Created by Максим Шаптала on 28.12.2020.
//

import SwiftUI

struct WidgetEntryView: View {
    
    var entry: GEntry
    
    var body: some View {
        if entry.widgetType == .small {
            CollageView(selectedLayoutIndex: entry.selectedLayoutIndex, collage: entry.collage)
        } else if entry.widgetType == .medium {
            MediumCollageView(selectedLayoutIndex: entry.selectedLayoutIndex, collage: entry.collage)
        } else {
            LargeCollageView(selectedLayoutIndex: entry.selectedLayoutIndex, collage: entry.collage)
        }
    }
    
}
