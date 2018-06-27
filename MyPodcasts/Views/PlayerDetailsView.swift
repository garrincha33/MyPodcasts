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
        observePlayCurrentTime()
        let time = CMTimeMake(1, 3)
        let times = [NSValue(time: time)]
        player.addBoundaryTimeObserver(forTimes: times, queue: .main) { [weak self] in
            self?.enlargeImageView()
        }
    }
    
    deinit {
        print("reclaiming memory......")
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
    @IBOutlet weak var currentTimeSlider: UISlider!
    @IBOutlet weak var currentTimeLable: UILabel!
    @IBOutlet weak var durationLable: UILabel!
    
    @IBAction func handleCurrentTimerSliderChange(_ sender: Any) {
        let percentageValue = currentTimeSlider.value
        guard let duration = player.currentItem?.duration else {return}
        let durationSeconds = CMTimeGetSeconds(duration)
        let seekTimeSeconds = Float64(percentageValue) * durationSeconds
        let seekTime = CMTimeMakeWithSeconds(seekTimeSeconds, Int32(NSEC_PER_SEC))
        player.seek(to: seekTime)
    }
    
    
    @IBAction func handleRewind(_ sender: Any) {
        seekToCurrentTime(delta: -15)
    }

    @IBAction func handleFastForward(_ sender: Any) {
        seekToCurrentTime(delta: 15)
    }
    
    @IBAction func handleVolumeChange(_ sender: UISlider) {
        player.volume = sender.value
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
    
    fileprivate func seekToCurrentTime(delta: Int64) {
        let fiftenSeconds = CMTimeMake(delta, 1)
        let seekTime = CMTimeAdd(player.currentTime(), fiftenSeconds)
        player.seek(to: seekTime)
    }
    
    fileprivate func observePlayCurrentTime() {
        let interval = CMTimeMake(1, 2)
        player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] (time) in
            self?.currentTimeLable.text = time.toDisplayString()
            let durationTime = self?.player.currentItem?.duration
            self?.durationLable.text = durationTime?.toDisplayString()
            self?.updateCurrentTimeSlider()
        }
    }
    
    fileprivate func updateCurrentTimeSlider() {
        let currentTimeSeconds = CMTimeGetSeconds(player.currentTime())
        let durationSecondes = CMTimeGetSeconds(player.currentItem?.duration ?? CMTimeMake(1, 1))
        let percentage = currentTimeSeconds / durationSecondes
        self.currentTimeSlider.value = Float(percentage)
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
