//
//  MovieCell.swift
//  Flicks
//
//  Created by Nguyen Nam Long on 10/15/16.
//  Copyright © 2016 Nguyen Nam Long. All rights reserved.
//

import UIKit
import AFNetworking

class MovieCell: UITableViewCell {

    @IBOutlet weak var backgroundMovieImage: UIImageView!
    @IBOutlet weak var moviePoint: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var titleBackground: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(dataCell: MovieModel) {
        backgroundMovieImage.backgroundColor = UIColor.clear
        backgroundMovieImage.image = nil
        
        if let imagePath = dataCell.backdropImagePath {
            let imageURL = URL(string: "\(MovieAPI.share.IMAGE_URL)\(imagePath)")
            backgroundMovieImage.setImageWith(imageURL!)
            
        }else {
            
            backgroundMovieImage.backgroundColor = UIColor.blue
        }
        moviePoint.text = String(dataCell.voteAverage)
        moviePoint.backgroundColor = UIColor.yellow
        movieTitle.text = dataCell.title
        titleBackground.backgroundColor = UIColor.lightGray
        titleBackground.alpha = 0.7
    }

}
