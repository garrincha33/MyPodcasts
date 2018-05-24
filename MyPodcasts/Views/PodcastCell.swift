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
            episodeCount.text =  "\(podcast.trackCount ?? 0) Episodes"
            
            print("Loading image with Url:", podcast.artworkUrl600 ?? "")
            //MARK:- loading images
            guard let url = URL(string: podcast.artworkUrl600 ?? "") else {return}
            URLSession.shared.dataTask(with: url) { (data, _, _) in
                print("Finished Downloading image data: ", data ?? "")
                
                guard let data = data else {return}
                DispatchQueue.main.async {
                    self.podcastImage.image = UIImage(data: data)
                }
            }.resume()
        }
    }
}
