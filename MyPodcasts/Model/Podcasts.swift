//
//  Podcasts.swift
//  MyPodcasts
//
//  Created by Richard Price on 03/05/2018.
//  Copyright © 2018 twisted echo. All rights reserved.
//

import UIKit

class Podcasts: NSObject, Decodable, NSCoding {
    
    func encode(with aCoder: NSCoder) {
        print("trying to transform podcast into data")
        aCoder.encode(trackName ?? "", forKey: "trackNameKey")
        aCoder.encode(artistName ?? "", forKey: "artistNameNameKey")
        aCoder.encode(artworkUrl600 ?? "", forKey: "artworkUrl600NameKey")
    }
    
    required init?(coder aDecoder: NSCoder) {
        print("trying to turn data into a podcast object")
        self.trackName = aDecoder.decodeObject(forKey: "trackNameKey") as? String
        self.artistName = aDecoder.decodeObject(forKey: "artistNameNameKey") as? String
        self.artworkUrl600 = aDecoder.decodeObject(forKey: "artworkUrl600NameKey") as? String
    }
    
    var artistName: String?
    var trackName: String?
    var trackCount: Int?
    var collectionName: String?
    var artworkUrl600: String?
    var feedUrl: String?
}
