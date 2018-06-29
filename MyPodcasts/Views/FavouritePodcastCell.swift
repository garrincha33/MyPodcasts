//
//  FavouritePodcastCell.swift
//  MyPodcasts
//
//  Created by Richard Price on 29/06/2018.
//  Copyright © 2018 twisted echo. All rights reserved.
//

import UIKit

class FavouritePodcastCell: UICollectionViewCell {
    
    var podcast: Podcasts! {
        didSet {
            
            nameLable.text = podcast.trackName
            artistNameLable.text = podcast.artistName
            
            guard let url = URL(string: podcast.artworkUrl600 ?? "") else {return}
            imageView.sd_setImage(with: url)
            
        }
    }
    
    
    let imageView = UIImageView(image: #imageLiteral(resourceName: "appicon"))
    let nameLable = UILabel()
    let artistNameLable = UILabel()
    
    fileprivate func stylizeUI() {
        nameLable.text = "Podcast Name"
        nameLable.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        artistNameLable.text = "Artist Name"
        artistNameLable.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        artistNameLable.textColor = .lightGray
    }
    
    fileprivate func setupViews() {
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        let stackView = UIStackView(arrangedSubviews: [imageView, nameLable, artistNameLable])
        stackView.axis = .vertical
        //enables autolayout
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        stylizeUI()
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
