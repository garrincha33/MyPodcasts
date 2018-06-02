//
//  Podcasts.swift
//  MyPodcasts
//
//  Created by Richard Price on 03/05/2018.
//  Copyright © 2018 twisted echo. All rights reserved.
//

import UIKit

struct Podcasts: Decodable {
    var artistName: String?
    var trackName: String?
    var trackCount: Int?
    var collectionName: String?
    var artworkUrl600: String?
    var feedUrl: String?
}
