//
//  TrendingCell.swift
//  Youtube
//
//  Created by Studiogenesis Home on 28/10/2018.
//  Copyright © 2018 Studiogenesis Home. All rights reserved.
//

import UIKit

class TrendingCell: FeddCell {

    
    override func fetchVideos() {
        ApiService.sharedInstance.fechTrendingFeed { (videos: [Video]) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
    
}
