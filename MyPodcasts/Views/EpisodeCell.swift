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
    @IBOutlet weak var episodePubdate: UILabel!
    @IBOutlet weak var episodeTitle: UILabel!
    @IBOutlet weak var episodeDescription: UILabel!
    
    var episode: Episode! {
        didSet {
            
            episodePubdate.text = episode.pubDate.description
            episodeTitle.text = episode.title
            episodeDescription.text = episode.description
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM, yyyy"
            episodePubdate.text = dateFormatter.string(from: episode.pubDate)

            
        }
    }
}
