//
//  MovieModel.swift
//  Flicks
//
//  Created by Nguyen Nam Long on 10/15/16.
//  Copyright © 2016 Nguyen Nam Long. All rights reserved.
//

import Foundation
import AFNetworking

struct MovieModel {
    var posterImagePath:String?
    var audult = false
    var overView:String
    var releaseDate:Date
    var genre_ids = [Int]()
    var genre_name = [String]()
    var id:Int
    var originalTitle:String
    var originalLanguage:String
    var title:String!
    var backdropImagePath:String?
    var popularity:Double
    var voteCount:Int
    var voteAverage:Double
    
    
    
    
    init?(JsonData: [String: AnyObject]) {
        self.posterImagePath = JsonData["poster_path"] as? String
        self.audult = JsonData["adult"] as! Bool
        self.overView = (JsonData["overview"] as! String)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        self.releaseDate = dateFormatter.date(from: (JsonData["release_date"] as! String))!
        
        
        self.genre_ids = (JsonData["genre_ids"] as! [Int])
        self.id = (JsonData["id"] as! Int)
        self.originalTitle = (JsonData["original_title"] as! String)
        self.originalLanguage = (JsonData["original_language"] as! String)
        self.title = (JsonData["title"] as! String)
        self.backdropImagePath = JsonData["backdrop_path"] as? String
        self.popularity = (JsonData["popularity"] as! Double)
        self.voteCount = (JsonData["vote_count"] as! Int)
        self.voteAverage = (JsonData["vote_average"] as! Double)
    }
    
    init?(detail: MovieModel) {
        self = detail
    }
    
}
