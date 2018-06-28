//
//  EpisodesController.swift
//  MyPodcasts
//
//  Created by Richard Price on 25/05/2018.
//  Copyright © 2018 twisted echo. All rights reserved.
//

import UIKit
import FeedKit

class EpisodesController: UITableViewController {
    
    let cellId = "cellID"
    
    var podcast: Podcasts? {
        didSet {
            
            navigationItem.title = podcast?.trackName
            fetchPodcastEpisodes()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    //MARK:- podcastFeed
    
    fileprivate func fetchPodcastEpisodes() {
        print("get episodes at ... :- ", podcast?.feedUrl ?? "")
        guard let feedUrl = podcast?.feedUrl else {return}
        APIService.shared.fetchEpisodes(feedUrl: feedUrl) { (episodes) in
            self.episodes = episodes
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    var episodes = [Episode]()
    
    //MARK:- setupTableView
    fileprivate func setupTableView() {
        tableView.tableFooterView = UIView()
        APIService.shared.makeNib(with: "EpisodeCell", tableView: tableView, cellId: cellId)
    }
    //MARK:- UITableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! EpisodeCell
        let episode = episodes[indexPath.row]
        cell.episode = episode
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        let episode = self.episodes[indexPath.row]
        let window = UIApplication.shared.keyWindow
        let playerDetailsView = PlayerDetailsView.initFromNib()
        playerDetailsView.episode = episode
        playerDetailsView.frame = self.view.frame
        window?.addSubview(playerDetailsView)
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityIndicator.color = .darkGray
        activityIndicator.startAnimating()
        return activityIndicator
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return episodes.isEmpty ? 200 : 0
    }
    
}
