//
//  SubscriptionCell.swift
//  Youtube
//
//  Created by Studiogenesis Home on 28/10/2018.
//  Copyright © 2018 Studiogenesis Home. All rights reserved.
//

import UIKit

class SubscriptionCell: FeddCell {

    override func fetchVideos() {
        ApiService.sharedInstance.fechSubscriptionFedd { (videos: [Video]) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
}
