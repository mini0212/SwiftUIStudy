//
//  EmojiRangerWidget.swift
//  EmojiRangerWidget
//
//  Created by Min on 2021/01/03.
//  Copyright © 2021 Apple. All rights reserved.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), character: .panda)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), character: .panda)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let entries: [SimpleEntry] = [SimpleEntry(date: Date(), character: .panda)]

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let character: CharacterDetail
}

// 홈 화면에서 보여지는 화면
struct EmojiRangerWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        AvatarView(entry.character)
    }
}

// 플레이스 홀더 화면(추가해줌)
struct PlaceholderView: View {
    var body: some View {
        AvatarView(.panda)
            .redacted(reason: .placeholder)
//            .isPlaceholder(true) // < 예시에서는 이렇게 나오는데 실제 존재하지않음..
    }
}

@main
struct EmojiRangerWidget: Widget {
    let kind: String = "EmojiRangerWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            EmojiRangerWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Emoji Ranger Detail")
        .description("Keep track of your favorite emoji ranger.")
        .supportedFamilies([.systemSmall])
    }
}

struct EmojiRangerWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AvatarView(.panda)
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            PlaceholderView()
                .previewContext(WidgetPreviewContext(family: .systemSmall))
        }
    }
}
