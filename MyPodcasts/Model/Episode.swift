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
    
    
    init(feedItem: RSSFeedItem) {
        
        self.title = feedItem.title ?? ""
        self.description = feedItem.description ?? ""
        self.pubDate = feedItem.pubDate ?? Date()
        
    }
}