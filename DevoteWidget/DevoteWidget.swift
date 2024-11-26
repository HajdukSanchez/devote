//
//  DevoteWidget.swift
//  DevoteWidget
//
//  Created by Jozek Andrzej Hajduk Sanchez on 22/11/24.
//

import WidgetKit
import SwiftUI

// MARK: - TimelineProvider
struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), emoji: "😀")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), emoji: "😀")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, emoji: "😀")
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }

//    func relevances() async -> WidgetRelevances<Void> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

// MARK: - TimelineEntry
struct SimpleEntry: TimelineEntry {
    let date: Date
    let emoji: String
}

// MARK: - View
struct DevoteWidgetEntryView : View {
    
    // MARK: - Properties
    @Environment(\.widgetFamily) var widgetFamily
    var entry: Provider.Entry
    
    // MARK: - Computed properties
    var positionPadding: Double {
        if widgetFamily == .systemSmall {
            return 10
        }
        return 25
    }
    var logoSize: Double {
        if widgetFamily == .systemSmall {
            return 36
        }
        return 56
    }
    var fontStyle: Font {
        if widgetFamily == .systemSmall {
            return .system(.footnote, design: .rounded)
        }
        return .system(.headline, design: .rounded)
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("rocket-small")
                    .resizable()
                    .scaledToFit()
                Image("logo")
                    .resizable()
                    .frame(width: logoSize, height: logoSize)
                    .position(x: geometry.size.width - positionPadding, y: positionPadding)
                HStack {
                    Text("Just Do It")
                        .foregroundStyle(.white)
                        .font(fontStyle)
                        .bold()
                        .padding(.horizontal, 12)
                        .padding(.vertical, 4)
                        .background(
                            Color(red: 0, green: 0, blue: 0, opacity: 0.5)
                                .blendMode(.overlay)
                                .clipShape(Capsule())
                        )
                    
                    if widgetFamily != .systemSmall {
                        Spacer()
                    }
                }
                .padding()
                .position(
                    x: geometry.size.width / 2,
                    y: geometry.size.height - positionPadding
                )
            }
        }
    }
}

// MARK: - Widget
struct DevoteWidget: Widget {
    let kind: String = "DevoteWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                DevoteWidgetEntryView(entry: entry)
                    .containerBackground(for: .widget) {
                        backgroundGradient
                    }
            } else {
                DevoteWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Devote launcher")
        .description("This is an example widget for the personal task manager app.")
    }
}

// MARK: - Previews
#Preview("Small", as: .systemSmall) {
    DevoteWidget()
} timeline: {
    SimpleEntry(date: .now, emoji: "😀")
    SimpleEntry(date: .now, emoji: "🤩")
}

#Preview("Medium", as: .systemMedium) {
    DevoteWidget()
} timeline: {
    SimpleEntry(date: .now, emoji: "😀")
    SimpleEntry(date: .now, emoji: "🤩")
}

#Preview("Large", as: .systemLarge) {
    DevoteWidget()
} timeline: {
    SimpleEntry(date: .now, emoji: "😀")
    SimpleEntry(date: .now, emoji: "🤩")
}
