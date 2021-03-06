//
//  PodcastSearchController.swift
//  MyPodcasts
//
//  Created by Richard Price on 03/05/2018.
//  Copyright © 2018 twisted echo. All rights reserved.
//

import UIKit

class PodcastSearchController: UITableViewController, UISearchBarDelegate {
    
    var timer: Timer?
    var podcasts = [Podcasts]()
    let cellId = "somerthing"
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewSetup()
        searchBarSetup()
    }
    
    fileprivate func tableViewSetup() {
        tableView.tableFooterView = UIView()
        APIService.shared.makeNib(with: "PodcastCell", tableView: tableView, cellId: cellId)
    }
    
    fileprivate func searchBarSetup() {
        self.definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        podcasts = []
        tableView.reloadData()

        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.8, repeats: false, block: { (timer) in
            APIService.shared.fetchPodcasts(searchText: searchText) { (podcast) in
                self.podcasts = podcast
                self.tableView.reloadData()
            }
        })
    }
    
    //MARK:- tableView Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = EpisodesController()
        let podcast = podcasts[indexPath.row]
        controller.podcast = podcast
        navigationController?.pushViewController(controller, animated: true)
 
    }
  
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcasts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! PodcastCell
        let podcast = self.podcasts[indexPath.row]
        cell.podcast = podcast
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 132
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let lable = UILabel()
        lable.text = "Please enter your search term"
        lable.textAlignment = .center
        lable.font = UIFont.systemFont(ofSize: 17)
        lable.textColor = .purple
        return lable
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return podcasts.isEmpty && searchController.searchBar.text?.isEmpty == true ? 250 : 0
    }
    
    var podcastSearchView = Bundle.main.loadNibNamed("PodcastsSearchingView", owner: self, options: nil)?.first as? UIView
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return podcasts.isEmpty && searchController.searchBar.text?.isEmpty == false ? 200 : 0
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return podcastSearchView
    }
}
