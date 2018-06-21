//
//  PlayerDetailsView.swift
//  MyPodcasts
//
//  Created by Richard Price on 07/06/2018.
//  Copyright © 2018 twisted echo. All rights reserved.
//

import UIKit
import AVKit

class PlayerDetailsView: UIView {
    
    @IBAction func dissmissButtonTapped(_ sender: Any) {
        self.removeFromSuperview()
    }
    //MARK:- Actions and Outlets
    @IBOutlet weak var episodeImageView: UIImageView!
    @IBOutlet weak var episodeTitle: UILabel!
    @IBOutlet weak var episodeAuthor: UILabel!
    @IBOutlet weak var episodePlayPauseButton: UIButton! {
        didSet {
            episodePlayPauseButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
            episodePlayPauseButton.addTarget(self, action: #selector(handlePayPause), for: .touchUpInside)
        }
    }
    //MARK:-
    
    var episode: Episode! {
        didSet {
            playEpisode()
            guard let url = URL(string: episode.imageUrl ?? "") else {return}
            episodeImageView.sd_setImage(with: url, completed: nil)
            episodeTitle.text = episode.title
            episodeAuthor.text = episode.author
            print("\(episodeAuthor.text = episode.author)")
        }
    }
    
    fileprivate func playEpisode() {
        guard let url  = URL(string: episode.streamUrl) else {return}
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)
        player.play()
    }
    
    let player: AVPlayer = {
        let avPlayer = AVPlayer()
        avPlayer.automaticallyWaitsToMinimizeStalling = false
        return avPlayer
    }()
    
    @objc fileprivate func handlePayPause() {
        if player.timeControlStatus == .paused {
            player.play()
            episodePlayPauseButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
        } else {
         player.pause()
            episodePlayPauseButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        }
    }
}
