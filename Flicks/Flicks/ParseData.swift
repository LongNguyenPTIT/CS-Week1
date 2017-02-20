//
//  ParseData.swift
//  Flicks
//
//  Created by Nguyen Nam Long on 10/15/16.
//  Copyright © 2016 Nguyen Nam Long. All rights reserved.
//

import Foundation

struct ParseData {
    
    let headers = ["content-type": "application/json"]
    let session = URLSession.shared
    
    
    
    
    
    func getDataFirst(completion: @escaping ([MovieModel]) -> () ) {
        
        
        let url = URL(string:"\(MovieAPI.share.MOVIES_NOW_PLAYING)\(MovieAPI.share.APIKey)")!

        var request = URLRequest(
            url: url,
            cachePolicy: .useProtocolCachePolicy,
            timeoutInterval: 10)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        

        
        let dataTask = session.dataTask(
            with: request,
            completionHandler: { (data, respones, error) in
            if (error != nil) {
                print(error)
            } else {
                if let responseDictionary = try! JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                    
                    if let movieData = responseDictionary["results"] as? [[String: AnyObject]] {
                        var listMovie = [MovieModel]()
                        for item in movieData {
                            let movie = MovieModel(JsonData: item)
                            listMovie.append(movie!)
                        }
                        completion(listMovie)
                    }
                }

            }
        })
        dataTask.resume()     
    }
    
    
    func loadDataMore(page: Int, completion: @escaping ([MovieModel]) -> () ) {
        
        let url = URL(string:"\(MovieAPI.share.MOVIES_NOW_PLAYING)\(MovieAPI.share.APIKey)&page=\(page)")!
        var request = URLRequest(
            url: url,
            cachePolicy: .useProtocolCachePolicy,
            timeoutInterval: 10)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        
        
        let dataTask = session.dataTask(
            with: request,
            completionHandler: { (data, respones, error) in
                if (error != nil) {
                    print(error)
                } else {
                    if let responseDictionary = try! JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                        
                        if let movieData = responseDictionary["results"] as? [[String: AnyObject]] {
                            var listMovie = [MovieModel]()
                            for item in movieData {
                                let movie = MovieModel(JsonData: item)
                                listMovie.append(movie!)
                            }
                            completion(listMovie)
                        }
                    }
                    
                }
        })
        dataTask.resume()
    }
    
    
    
    func getGenreListData(completion: @escaping ([GenreModel]) -> ()) {
        let url = URL(string:"\(MovieAPI.share.API_GENRE_LIST)\(MovieAPI.share.APIKey)")!
        var request = URLRequest(
            url: url,
            cachePolicy: .useProtocolCachePolicy,
            timeoutInterval: 10)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        
        
        let dataTask = session.dataTask(
            with: request,
            completionHandler: { (data, respones, error) in
                if (error != nil) {
                    print(error)
                } else {
                    if let responseDictionary = try! JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                        
                        if let movieData = responseDictionary["genres"] as? [[String: AnyObject]] {
                            var listGenre = [GenreModel]()
                            for item in movieData {
                                let genre = GenreModel(JsonData: item)
                                listGenre.append(genre!)
                            }
                            completion(listGenre)
                        }
                    }
                    
                }
        })
        dataTask.resume()
    }
    
    
    
    
    
    
    
}
