//
//  PodcastSearchController.swift
//  MyPodcasts
//
//  Created by Richard Price on 03/05/2018.
//  Copyright © 2018 twisted echo. All rights reserved.
//

import UIKit
import Alamofire


class PodcastSearchController: UITableViewController, UISearchBarDelegate {
    
    let podcasts = [
        Podcasts(artistName: "Richard P", name: "Cast Away"),
        Podcasts(artistName: "Davey", name: "into the night")
    ]
    
    let cellId = "somerthing"
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewSetup()
        searchBarSetup()
    }
    
    
    fileprivate func tableViewSetup() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    fileprivate func searchBarSetup() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
        let url = "https://yahoo.com"
        Alamofire.request(url).response { (dataResponse) in
            if let err = dataResponse.error {
                print("unable to contact host", err)
                return
            }
            
            guard let data = dataResponse.data else {return}
            let fakeString = String(data: data, encoding: .utf8)
            print(fakeString ?? "")

        }

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcasts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let podcast = self.podcasts[indexPath.row]
        cell.textLabel?.numberOfLines = -1
        cell.textLabel?.text = "\(podcast.artistName)\n\(podcast.name)"
        cell.imageView?.image = #imageLiteral(resourceName: "appicon")
        return cell
        
    }
}
