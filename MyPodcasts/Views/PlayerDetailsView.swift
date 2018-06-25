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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let time = CMTimeMake(1, 3)
        let times = [NSValue(time: time)]
        player.addBoundaryTimeObserver(forTimes: times, queue: .main) {
            self.enlargeImageView()
        }
    }
    
    @IBAction func dissmissButtonTapped(_ sender: Any) {
        self.removeFromSuperview()
    }
    
    //MARK:- Actions and Outlets
    @IBOutlet weak var episodeImageView: UIImageView! {
        didSet {
            episodeImageView.layer.cornerRadius = 5
            episodeImageView.clipsToBounds = true
            episodeImageView.transform = self.shrinkTransform
        }
    }
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
            enlargeImageView()
        } else {
         player.pause()
            episodePlayPauseButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
            shrinkImageView()
        }
    }
    
    fileprivate let shrinkTransform = CGAffineTransform(scaleX: 0.7, y: 0.7)
    
    fileprivate func enlargeImageView() {
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.episodeImageView.transform = .identity
        }, completion: nil)
    }
    
    fileprivate func shrinkImageView() {
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.episodeImageView.transform = self.shrinkTransform
        })
    }
}
