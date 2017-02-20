//
//  MovieViewController.swift
//  Flicks
//
//  Created by Nguyen Nam Long on 10/15/16.
//  Copyright © 2016 Nguyen Nam Long. All rights reserved.
//

import UIKit
import AFNetworking

class MovieViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var dataResponds = ParseData()
    var listMovie = [MovieModel]()
    var listGenre = [GenreModel]()
    var nextPage:Int = 1
    var loadingView: UIView = UIView()
    var spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
//    let network = AFNetworkReachabilityManager.init(forDomain: "www.apple.com")
    
//    let network = AFNetworkReachabilityManager()
    
    
    @IBOutlet weak var movieTableView: UITableView!
    
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        movieTableView.delegate = self
        movieTableView.dataSource = self
        
        DispatchQueue.global().async {
            self.dataResponds.getDataFirst { (result) in
                self.listMovie = result
                self.nextPage += 1
                self.movieTableView.reloadData()
            }
        }
        listenForReachability()
        
        DispatchQueue.global().async {
            self.dataResponds.getGenreListData { (result) in
                self.listGenre = result
            }
        }
        
        
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listMovie.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? MovieCell
        if (indexPath.row + 1 < self.listMovie.count) {
            cell?.configCell(dataCell: listMovie[indexPath.row])
            cell?.backgroundColor = UIColor.clear
//            return cell!
//            
        } else {
            print(">>>>>>pages:\(nextPage)")
            showActivityIndicator()
            dataResponds.loadDataMore(page: nextPage, completion: { (result) in
                self.listMovie += result
//                for item in result {
//                    self.listMovie.append(item)
//                }
                
                self.movieTableView.reloadData()
                self.hideActivityIndicator()
            })
            self.nextPage += 1
        }
        cell?.configCell(dataCell: listMovie[indexPath.row])
        cell?.backgroundColor = UIColor.clear
        return cell!
    }
    
    
    
    
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
            self.loadingView.removeFromSuperview()
        }
    }



    func showActivityIndicator() {
        DispatchQueue.main.async {
            self.loadingView = UIView()
            self.loadingView.frame = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0)
            self.loadingView.center = self.view.center
            self.loadingView.backgroundColor = UIColor(red: 0.26, green: 0.26, blue: 0.26, alpha: 0.7)
            self.loadingView.alpha = 0.7
            self.loadingView.clipsToBounds = true
            self.loadingView.layer.cornerRadius = 10
            
            self.spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
            self.spinner.frame = CGRect(x: 0.0, y: 0.0, width: 80.0, height: 80.0)
            self.spinner.center = CGPoint(x:self.loadingView.bounds.size.width / 2, y:self.loadingView.bounds.size.height / 2)
            
            self.loadingView.addSubview(self.spinner)
            self.view.addSubview(self.loadingView)
            self.spinner.startAnimating()

        }
    }
    
    
    //MARK: check network
    func listenForReachability() {
        
        AFNetworkReachabilityManager.shared().setReachabilityStatusChange { (status) in
            switch status {
            case .notReachable:
                let alertController = UIAlertController(title: "NO INTERNET", message: "Please check your network", preferredStyle: .alert)
                let okAction = UIAlertAction.init(title: "OK", style: .default) { (result: UIAlertAction) -> Void in
                    print("OK")
                }
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                self.showActivityIndicator()
                break
            //Show error state
            case .reachableViaWWAN, .reachableViaWiFi, .unknown:
                self.hideActivityIndicator()
                
                
                self.dataResponds.getDataFirst { (result) in
                    self.listMovie = result
                    self.nextPage += 1
                    self.movieTableView.reloadData()
                }
                break
                //Hide error state
            }
        }
        AFNetworkReachabilityManager.shared().startMonitoring()
        
    }

    
    
      
        
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation*/
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let desVC = segue.destination as! MovieDetailViewController
        let indexPath = movieTableView.indexPath(for: sender as! UITableViewCell)
        desVC.movieDetail = listMovie[(indexPath?.row)!]
        desVC.listGenre = self.listGenre
        
//        for genreItem in listGenre {
//            for genreMovie in (desVC.movieDetail?.genre_ids)! {
//                if genreMovie == genreItem.id {
//                    desVC.genreText = desVC.genreText! + " \(genreItem.name),"
//                }
//            }
//        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

    

}

extension MovieViewController: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print("Selected Index :\(item.index)");
    }
}



