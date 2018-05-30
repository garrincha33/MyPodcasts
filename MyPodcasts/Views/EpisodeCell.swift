//
//  EpisodeCell.swift
//  MyPodcasts
//
//  Created by Richard Price on 30/05/2018.
//  Copyright © 2018 twisted echo. All rights reserved.
//

import UIKit

class EpisodeCell: UITableViewCell {
    
    @IBOutlet weak var episodeImage: UIImageView!
    @IBOutlet weak var pubDate: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var episodeDescription: UILabel!
    
    var episode: Episode! {
        
        didSet {
            pubDate.text = episode.pubDate.description
            title.text = episode.title
            episodeDescription.text = episode.description
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM, yyyy"
            pubDate.text = dateFormatter.string(from: episode.pubDate)
 
        }
    }
}
