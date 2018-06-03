//
//  RSSFeed.swift
//  MyPodcasts
//
//  Created by Richard Price on 02/06/2018.
//  Copyright © 2018 twisted echo. All rights reserved.
//

import FeedKit

extension RSSFeed {
    
    func toEpisodes() -> [Episode] {
        let image = iTunes?.iTunesImage?.attributes?.href
        var episodes = [Episode]()
        items?.forEach({ (feedItem) in
            var episode = Episode(feedItem: feedItem)
            if episode.imageUrl == nil {
                episode.imageUrl = image
            }
            episodes.append(episode)
        })
        return episodes
    }
}
