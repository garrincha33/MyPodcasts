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
    
    fileprivate func fetchPodcastEpisodes() {
        print("get episodes at ... :- ", podcast?.feedUrl ?? "")
        
        guard let feedUrl = podcast?.feedUrl else {return}
        //unable to return feeds with http, create secure feed string
        let secureFeedUrl = feedUrl.contains("https") ? feedUrl : feedUrl.replacingOccurrences(of: "http", with: "https")
        guard let url = URL(string: secureFeedUrl) else {return}
        let parser = FeedParser(URL: url)
        
        parser?.parseAsync(result: { (result) in
            print("successfully parsed feed...", result.isSuccess)
            
            switch result {
            case let .rss(feed):
                var episodes = [Episode]()
                feed.items?.forEach({ (feedItem) in
                    let episode = Episode(feedItem: feedItem)
                    episodes.append(episode)
                })
                self.episodes = episodes
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                break
                
            case let .failure(error):
                print("failed to parse feed", error)
                break
                
            default:
                print("Feed has been found....")
            }
        })
    }
    
    var episodes = [Episode]()
    
    //MARK:- setupTableView
    fileprivate func setupTableView() {
        tableView.tableFooterView = UIView()
        let nib = UINib(nibName: "EpisodeCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellId)
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
    
}
