//
//  MovieDetailsViewController.swift
//  flixster
//
//  Created by Sam Gustafsson on 2/16/21.
//  Copyright © 2021 Sam Gustafsson. All rights reserved.
//

import UIKit
import AlamofireImage
import WebKit



class MovieDetailsViewController: UIViewController, UICollectionViewDelegate, WKUIDelegate {
    
    @IBOutlet weak var backDropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var trailerView: WKWebView!
    
    var webView: WKWebView!
    var movie: [String:Any]!
    var ytBaseUrl = "https://www.youtube.com/watch?v="
    var trailerId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        titleLabel.text = movie["title"] as? String
        titleLabel.sizeToFit()
        
        synopsisLabel.text = movie["overview"] as? String
        synopsisLabel.sizeToFit()
        
        let baseUrl = "http://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)
        
        posterView.af_setImage(withURL: posterUrl!)
        
        guard let backDropPath = movie["backdrop_path"] as? String else {
            print("no backdrop path for movie: \(movie["title"])")
            return
        }
        
        //let backDropPath = movie["backdrop_path"] as! String
        let backDropUrl = URL(string: "http://image.tmdb.org/t/p/w780" + backDropPath)
            
        backDropView.af_setImage(withURL: backDropUrl!)
        
        getTrailerId()
    }
    
    
    func getTrailerId(){
        let baseTrailerUrl = "https://api.themoviedb.org/3/movie/"
        let movieId = String(movie["id"] as! Int)
        let restOfUrl = "/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US"
        let wholeMovie = URL(string: baseTrailerUrl + movieId + restOfUrl)!
        let request = URLRequest(url: wholeMovie, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                print(dataDictionary)
                let results = dataDictionary["results"] as! [[String: Any]]
                let tempTrailerId = results.first?["key"] as! String
                self.trailerId = tempTrailerId
            }
        }
        task.resume()
    }

    @IBAction func tap(_ sender: Any) {
        let ytWholeUrl = ytBaseUrl + trailerId
        let request = URLRequest(url: URL(string: ytWholeUrl)!)
        
        trailerView.load(request)
    }
    

/*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
       
    }
    
*/
}
