//
//  GWidget.swift
//  GWidget
//
//  Created by Максим Шаптала on 28.12.2020.
//

import WidgetKit
import SwiftUI
import Intents

@main
struct GWidget: Widget {
    let kind: String = "GWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WidgetEntryView(entry: GEntry(collage: Collage(), widgetType: WidgetType.small, selectedLayoutIndex: 0))
        }.supportedFamilies([.systemLarge])
    }
}

struct GWidget_Previews: PreviewProvider {
    static var previews: some View {
        WidgetEntryView(entry: GEntry(collage: Collage(), widgetType: WidgetType.small, selectedLayoutIndex: 0))
    }
}
