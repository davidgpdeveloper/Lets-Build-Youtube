//
//  ViewController.swift
//  Youtube
//
//  Created by Studiogenesis Home on 8/7/18.
//  Copyright © 2018 Studiogenesis Home. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

//    var videos: [Video] = {
//
//        var kaneyChannel = Channel()
//        kaneyChannel.name = "KanyeIsTheBestChannel"
//        kaneyChannel.profileImageName = "kanye_profile"
//
//        var blankSpaceVideo = Video()
//        blankSpaceVideo.title = "Taylor Swift - Blank Space"
//        blankSpaceVideo.thumnailImageName = "taylor_swift_blank_space"
//        blankSpaceVideo.channel = kaneyChannel
//        blankSpaceVideo.numberOfViews = 2315616546156536
//
//        var badBloodVideo = Video()
//        badBloodVideo.title = "Taylor Swift - Bad Blood featuring Kendrick Lamar"
//        badBloodVideo.thumnailImageName = "taylor_swift_bad_blood"
//        badBloodVideo.channel = kaneyChannel
//        badBloodVideo.numberOfViews = 79854654654354
//
//        return [blankSpaceVideo, badBloodVideo]
//    }()
    
    var videos: [Video]?
    
    func fetchVideos() {
        let url = "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json"


        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { (data, response, error) -> Void in
  
            if error != nil {
                print(error)
                return
            }
            
            self.videos = [Video]()
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                for dictionary in json as! [[String : AnyObject]] {
                    
                    let video = Video()
                    video.title = dictionary["title"] as! String
                    video.thumnailImageName = dictionary["thumbnail_image_name"] as! String
                    
                    let channelDict = dictionary["channel"] as! [String : AnyObject]
                    
                    let channel = Channel()
                    channel.name = channelDict["name"] as! String
                    channel.profileImageName = channelDict["profile_image_name"] as! String
                    
                    video.channel = channel
                    self.videos?.append(video)
                }
                
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
                                
            } catch let jsonError {
                print(jsonError)
            }
            
        }).resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchVideos()
        
        navigationItem.title = "Home"
        navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "Home"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
        
        collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        
        setupBarMenu()
        setupBarButtons()
    }
    
    func setupBarButtons() {
        let searchImage = UIImage(named: "search")?.withRenderingMode(.alwaysOriginal)
        let searchBarButton = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        
        let moreButton = UIBarButtonItem(image: UIImage(named: "options")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleOptions))
                
        navigationItem.rightBarButtonItems = [moreButton, searchBarButton]
    }
    
    @objc func handleOptions() {
        print("456")
    }
    
    @objc func handleSearch() {
        print("123")
        
    }
    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    private func setupBarMenu() {
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", view: menuBar)
        view.addConstraintsWithFormat(format: "V:|[v0(50)]|", view: menuBar)
    }
   
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          return videos?.count ?? 0
    }
    

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell
        
        cell.video = videos?[indexPath.item]

        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width - 16 - 16) * 9 / 16
        return CGSize(width: view.frame.width, height: height + 16 + 88)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}


