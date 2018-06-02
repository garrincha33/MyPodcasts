//
//  String.swift
//  MyPodcasts
//
//  Created by Richard Price on 02/06/2018.
//  Copyright © 2018 twisted echo. All rights reserved.
//

import Foundation

extension String {
    
    func toSecureHttps() -> String {
        
        return self.contains("https") ? self : self.replacingOccurrences(of: "http", with: "https")
        
    }
}
