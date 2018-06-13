//
//  PlayerDetailsView.swift
//  MyPodcasts
//
//  Created by Richard Price on 07/06/2018.
//  Copyright © 2018 twisted echo. All rights reserved.
//

import UIKit

class PlayerDetailsView: UIView {
    
   
    @IBAction func dissmissButtonTapped(_ sender: Any) {
        
        self.removeFromSuperview()
        
    }
    @IBOutlet weak var episodeImageView: UIImageView!
    @IBOutlet weak var episodeTitle: UILabel!
    @IBOutlet weak var episodeAuthor: UILabel!
    @IBOutlet weak var episodePlayPauseButton: UIButton!
    
    var episode: Episode! {
        didSet {
            guard let url = URL(string: episode.imageUrl ?? "") else {return}
            episodeImageView.sd_setImage(with: url, completed: nil)
            episodeTitle.text = episode.title
            episodeAuthor.text = episode.author
            print("\(episodeAuthor.text = episode.author)")
        }
    }
}
