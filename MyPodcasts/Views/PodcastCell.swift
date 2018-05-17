//
//  PodcastCell.swift
//  MyPodcasts
//
//  Created by Richard Price on 17/05/2018.
//  Copyright © 2018 twisted echo. All rights reserved.
//

import UIKit

class PodcastCell: UITableViewCell {
    
    
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var episodeCount: UILabel!
    @IBOutlet weak var podcastImage: UIImageView!
    
    var podcast: Podcasts! {
        didSet {
            
            trackName.text = podcast.trackName
            artistName.text = podcast.artistName

        }
    }
}
