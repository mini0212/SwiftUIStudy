/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A widget that shows the avatar for a single character.
*/

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    
    public typealias Entry = SimpleEntry
    
    func placeholder(in context: Context) -> SimpleEntry {
        return SimpleEntry(date: Date(), character: .panda)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        let entry = SimpleEntry(date: Date(), character: .panda)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
        let entries = [SimpleEntry(date: Date(), character: .panda)]
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
    
}

struct SimpleEntry: TimelineEntry {
    public let date: Date
    let character: CharacterDetail
}

struct PlaceholderView: View {
    var body: some View {
        AvatarView(.panda)
    }
}

struct EmojiRangerWidgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        AvatarView(entry.character)
    }
}

@main
struct EmojiRangerWidget: Widget {
    private let kind: String = "EmojiRangerWidget"

    public var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            EmojiRangerWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Ranger Detail")
        .description("See your favorite ranger.")
        .supportedFamilies([.systemSmall])
    }
}

struct Widget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AvatarView(CharacterDetail.panda)
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            
            PlaceholderView()
                .previewContext(WidgetPreviewContext(family: .systemSmall))
        }
    }
}
