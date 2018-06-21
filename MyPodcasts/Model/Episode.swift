//
//  Episode.swift
//  MyPodcasts
//
//  Created by Richard Price on 30/05/2018.
//  Copyright © 2018 twisted echo. All rights reserved.
//

import Foundation
import FeedKit


struct Episode {
    
    let title: String
    let description : String
    let pubDate: Date
    var imageUrl: String?
    let author: String
    let streamUrl: String

    init(feedItem: RSSFeedItem) {
        self.title = feedItem.title ?? ""
        self.pubDate = feedItem.pubDate ?? Date()
        self.imageUrl = feedItem.iTunes?.iTunesImage?.attributes?.href
        self.description = feedItem.iTunes?.iTunesSummary ?? feedItem.description ?? ""
        self.author = feedItem.iTunes?.iTunesAuthor ?? feedItem.author ?? ""
        self.streamUrl = feedItem.enclosure?.attributes?.url ?? ""
    }
}


