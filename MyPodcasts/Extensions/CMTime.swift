//
//  CMTime.swift
//  MyPodcasts
//
//  Created by Richard Price on 25/06/2018.
//  Copyright © 2018 twisted echo. All rights reserved.
//

import AVKit

extension CMTime {
    
    func toDisplayString() -> String {
        let totalSeconds = Int(CMTimeGetSeconds(self))
        let seconds = totalSeconds % 60
        let minitues = totalSeconds / 60
        let timeFormatString = String(format: "%02d:%02d",minitues, seconds)
        return timeFormatString
    }
}
