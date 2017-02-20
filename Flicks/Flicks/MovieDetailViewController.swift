//
//  MovieDetailViewController.swift
//  Flicks
//
//  Created by Nguyen Nam Long on 10/16/16.
//  Copyright © 2016 Nguyen Nam Long. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
 
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var votelabel: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var genresLabel: UILabel!
    
    
    var movieDetail:MovieModel?
    var listGenre = [GenreModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func setup(){
        genresLabel.text = ""
        if let item = movieDetail {
            titleLabel.text = item.title
            titleLabel.backgroundColor = UIColor.gray
            titleLabel.layer.cornerRadius = 10.0
            titleLabel.clipsToBounds = true
            
            
            languageLabel.text = item.originalLanguage
            votelabel.text = String(item.voteCount)
            pointLabel.text = String(item.voteAverage)
            
            if let imagePath = item.posterImagePath {
                let imageURL = URL(string: "\(MovieAPI.share.IMAGE_URL)\(imagePath)")
                movieImage.setImageWith(imageURL!)
                
            }else {
                
                movieImage.backgroundColor = UIColor.blue
            }
            for genreItem in listGenre {
                for genreMovie in (movieDetail?.genre_ids)! {
                    if genreMovie == genreItem.id {
                        genresLabel.text = genresLabel.text! + " \(genreItem.name),"
                    }
                }
            }
            genresLabel.sizeToFit()
            
            
            let contentWidth = scrollView.bounds.width
            let contentHeight = scrollView.bounds.height * 3
            scrollView.contentSize = CGSize(width: contentWidth, height: contentHeight)
            
            let overviewLabel = UILabel(frame: CGRect(x: 5, y: 5, width: contentWidth - 20, height: 200))
            overviewLabel.text = movieDetail?.overView
            overviewLabel.numberOfLines = 0
            overviewLabel.textColor = UIColor.white
            overviewLabel.font.withSize(CGFloat(18))
            overviewLabel.sizeToFit()
            scrollView.layer.cornerRadius = 20.0
            scrollView.clipsToBounds = true
            scrollView.addSubview(overviewLabel)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd,yyyy"
//            dateFormatter.dateStyle = DateFormatter.Style.long
            releaseDateLabel.text = dateFormatter.string(from: (movieDetail?.releaseDate)!)
            
            
                
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
