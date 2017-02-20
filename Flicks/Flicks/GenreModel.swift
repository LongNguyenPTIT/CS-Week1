//
//  GenreModel.swift
//  Flicks
//
//  Created by Nguyen Nam Long on 10/16/16.
//  Copyright © 2016 Nguyen Nam Long. All rights reserved.
//

import Foundation


struct GenreModel {
    var id:Int
    var name:String
    
    
    init?(JsonData: [String:AnyObject]) {
        self.id = JsonData["id"] as! Int
        self.name = JsonData["name"] as! String
    }
}
