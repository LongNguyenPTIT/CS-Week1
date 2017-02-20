//
//  MovieDatabaseAPI.swift
//  Flicks
//
//  Created by Nguyen Nam Long on 10/15/16.
//  Copyright © 2016 Nguyen Nam Long. All rights reserved.
//

import Foundation

struct MovieAPI {
    static let share = MovieAPI()
    
    let APIKey = "ab4eef3731795157e1464d7399e346c2"
    let MOVIES_NOW_PLAYING = "https://api.themoviedb.org/3/movie/now_playing?api_key="
    let MOVIES_TOP_RATE = "https://api.themoviedb.org/3/movie/top_rated?api_key="
    let IMAGE_URL = "https://image.tmdb.org/t/p/original"
    let API_GENRE_LIST = "https://api.themoviedb.org/3/genre/movie/list?api_key="
    
}
