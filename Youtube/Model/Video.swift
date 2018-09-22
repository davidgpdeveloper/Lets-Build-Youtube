//
//  Video.swift
//  Youtube
//
//  Created by Studiogenesis Home on 22/9/18.
//  Copyright © 2018 Studiogenesis Home. All rights reserved.
//

import UIKit

class Video: NSObject {
    
    var thumnailImageName: String?
    var title: String?
    var numberOfViews: NSNumber?
    var uploadDate: Date?
    
    var channel: Channel?
}

class Channel: NSObject {
    var name: String?
    var profileImageName: String?
}
