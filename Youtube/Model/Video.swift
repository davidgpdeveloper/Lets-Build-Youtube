//
//  Video.swift
//  Youtube
//
//  Created by Studiogenesis Home on 22/9/18.
//  Copyright © 2018 Studiogenesis Home. All rights reserved.
//

import UIKit

struct Video: Decodable {
    
    var thumbnailImageName: String?
    var title: String?
    var numberOfViews: Int?
    var uploadDate: Date?
    
    var channel: Channel?
    
}

struct Channel: Decodable {
    var name: String?
    var profileImageName: String?
}

