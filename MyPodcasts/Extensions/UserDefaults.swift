//
//  UserDefaults.swift
//  MyPodcasts
//
//  Created by Richard Price on 29/06/2018.
//  Copyright © 2018 twisted echo. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    static let favouritedPodcastKey = "favouritedPodcast"
    
    func savedPodcasts() -> [Podcasts] {
        //get list of already saved podcasts rather than an empty array
        guard let savedPodcastsData = UserDefaults.standard.data(forKey: UserDefaults.favouritedPodcastKey) else {return [] }
        guard let savedPodcasts = NSKeyedUnarchiver.unarchiveObject(with: savedPodcastsData) as? [Podcasts] else {return [] }
        return savedPodcasts
    }
    
    func deletePodcast(podcast: Podcasts) {
        
        let podcasts = savedPodcasts()
        let filteredPodcasts = podcasts.filter { (p) -> Bool in
            return p.trackName != podcast.trackName ||
                (p.trackName == podcast.trackName && p.artistName != podcast.artistName)
        }
        
        let data = NSKeyedArchiver.archivedData(withRootObject: filteredPodcasts)
        UserDefaults.standard.set(data, forKey: UserDefaults.favouritedPodcastKey)
        
    }
    
    
    
    
}
